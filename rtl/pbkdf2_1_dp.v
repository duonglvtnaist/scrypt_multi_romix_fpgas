module pbkdf2_1_dp(
	input	wire				clk					,	// clock signal
	input	wire				reset_n				,   // reset negative signal
	input	wire				sha256_init			,
	input	wire				sha256_first_block	,
	input	wire	[1:0]		sel_block_in_i_hash	,	// sel block_in for ihash
	input	wire				sel_block_in_o_hash	,	// sel block_in for ohash
	input	wire				sel_block_in		,	// sel block_in for sha256
	input	wire	[1:0]		sel_prev_hash		, 	// sel prev_hash for sha256
	input	wire				update_mem_0		,
	input	wire				update_mem_1		,
	input	wire				update_ixor_mem		,
	input	wire				update_oxor_mem		,
	input	wire				update_out_4		,
	input	wire				update_out_3		,
	input	wire				update_out_2		,
	input	wire				update_out_1		,
	input	wire	[2:0]		index				,
	input	wire	[639:0]		in					,   // input pbkdf2_1
	output	wire	[1023:0]	out					,   // output pbkdf2_1
	output	wire	[255:0]		ixor_hash			,
	output	wire	[255:0]		oxor_hash			,
	output	wire				sha256_digest_valid	
);
	parameter		index_pad 			= 29'h00000000;
	
	parameter	[255:0]	ipad	= 256'h3636363636363636363636363636363636363636363636363636363636363636;
	parameter	[255:0]	opad	= 256'h5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c;
// Wires for SHA256
	wire			sha256_clk				;
	wire			sha256_reset_n	        ;
	wire	[511:0]	sha256_block_in         ;	// select from mux
	wire	[255:0]	sha256_prev_digest      ;	// select from mux
	wire	[255:0]	sha256_digest			;
	
// SHA256 assignments
	assign	sha256_clk 		= clk			;
	assign	sha256_reset_n 	= reset_n		;

// SHA256 wires for block_in
	wire	[511:0]	in_high_wire			;	// KHASH - IHASH
	wire	[511:0]	in_low_wire				;	// KHASH
	wire	[511:0]	i_xor_wire				;	// IHASH
	wire	[511:0]	o_xor_wire				;	// OHASH
	wire	[511:0]	block_index_wire		;	// IHASH
	wire	[511:0]	block_o_hash_wire		;	// OHASH
	wire	[511:0]	block_in_i_hash			;
	wire	[511:0]	block_in_o_hash			;
// SHA256 wires for prev_digest
	wire	[255:0]		sha256_mem_0_wire		;	// KHASH - IHASH
	wire	[255:0]		sha256_mem_1_wire		;	// IHASH
	wire	[255:0]		sha256_ixor_mem_wire	;	// IHASH
	wire	[255:0]		sha256_oxor_mem_wire	;	// OHASH
	wire	[31:0]		sha256_index_pad		;
// SHA256 wires for block_in assignments
	assign 	in_high_wire		= 	in[639:128]										;
	assign	in_low_wire 		= 	{in[127:0], 4'h8,380'h280}						;
	assign	i_xor_wire			= 	{sha256_mem_0_wire ^ ipad, ipad}				;
	assign	o_xor_wire			=	{sha256_mem_0_wire ^ opad, opad}				;
	assign	sha256_index_pad	=	{index_pad, index}								;
	assign 	block_index_wire	= 	{in[127:0], sha256_index_pad, 4'h8, 348'h4a0}	;
	assign	block_o_hash_wire 	=	{sha256_mem_0_wire, 4'h8, 252'h300}				;
	
// SHA256 memories save hash results
	reg		[255:0]		sha256_mem_0			;
	reg		[255:0]		sha256_mem_1			;
	reg		[255:0]		sha256_ixor_mem			;	// hashed ixor
	reg		[255:0]		sha256_oxor_mem			;	// hashed oxor
	reg		[1023:0] 	out_reg;
	


// SHA256 wires for prev_digest assignments
	assign	sha256_mem_0_wire 		= 	sha256_mem_0;
	assign	sha256_mem_1_wire 		= 	sha256_mem_1;
	assign	sha256_ixor_mem_wire 	= 	sha256_ixor_mem;
	assign	sha256_oxor_mem_wire 	= 	sha256_oxor_mem;

// Mux to select block_in
		mux41#(512)	mux_sel_block_in_i_hash
					(
						.in0(in_high_wire)					,
						.in1(in_low_wire)					,
						.in2(i_xor_wire)					,
						.in3(block_index_wire)				,
						.sel(sel_block_in_i_hash)			,
						.out(block_in_i_hash)				
					);
		
		mux21#(512) mux_sel_block_in_o_hash
					(
						.in0(o_xor_wire)					, 
						.in1(block_o_hash_wire)				,
						.sel(sel_block_in_o_hash)			,
						.out(block_in_o_hash)
					);
		mux21#(512)	mux_sel_block_in
					(
						.in0(block_in_i_hash)				, 
						.in1(block_in_o_hash)				,
						.sel(sel_block_in)					,
						.out(sha256_block_in)
					);

// Mux to select prev_hash
		mux41#(256)	mux_sel_prev_hash
					(
						.in0(sha256_mem_0_wire)				,
						.in1(sha256_mem_1_wire)				,
						.in2(sha256_ixor_mem_wire)			,
						.in3(sha256_oxor_mem_wire)			,
						.sel(sel_prev_hash)					,
						.out(sha256_prev_digest)				
					);
// SHA256 instance

	sha256_core_standard sha256_core(
		.clk				(sha256_clk)			,
		.reset_n			(sha256_reset_n)		,
		.init				(sha256_init)			,
		.block_in			(sha256_block_in)		,
		.prev_digest		(sha256_prev_digest)	,
		.first_block		(sha256_first_block)	,
		.digest_valid		(sha256_digest_valid)	,
		.digest				(sha256_digest)			
	);
	
// Assignments for ixor_hash and oxor_hash

	assign	out = out_reg;
	assign 	ixor_hash = sha256_ixor_mem;
	assign	oxor_hash = sha256_oxor_mem;
// Always for update memories
	always @(posedge clk or negedge reset_n) begin : update_sha256_mem_0
		if(reset_n == 1'b0) begin
			sha256_mem_0 <= 256'h0;
		end
		else begin
			if(update_mem_0 == 1'b1) begin
				sha256_mem_0 <= sha256_digest;
			end
			else begin
				sha256_mem_0 <= sha256_mem_0_wire;
			end
		end
	end

	always @(posedge clk or negedge reset_n) begin : update_sha256_mem_1
		if(reset_n == 1'b0) begin
			sha256_mem_1 <= 256'h0;
		end
		else begin
			if(update_mem_1 == 1'b1) begin
				sha256_mem_1 <= sha256_digest;
			end
			else begin
				sha256_mem_1 <= sha256_mem_1_wire;
			end
		end
	end

	always @(posedge clk or negedge reset_n) begin : update_sha256_ixor_mem
		if(reset_n == 1'b0) begin
			sha256_ixor_mem <= 256'h0;
		end
		else begin
			if(update_ixor_mem == 1'b1) begin
				sha256_ixor_mem <= sha256_digest;
			end
			else begin
				sha256_ixor_mem <= sha256_ixor_mem_wire;
			end
		end
	end

	always @(posedge clk or negedge reset_n) begin : update_sha256_oxor_mem
		if(reset_n == 1'b0) begin
			sha256_oxor_mem <= 256'h0;
		end
		else begin
			if(update_oxor_mem == 1'b1) begin
				sha256_oxor_mem <= sha256_digest;
			end
			else begin
				sha256_oxor_mem <= sha256_oxor_mem_wire;
			end
		end
	end

	always @(posedge clk or negedge reset_n) begin : update_out_4_seg
		if(reset_n == 1'b0) begin
			out_reg[1023:768] <= 256'h0;
		end
		else begin
			if(update_out_4 == 1'b1) begin
				out_reg[1023:768] <= sha256_digest;
			end
			else begin
				out_reg[1023:768] <= out[1023:768];
			end
		end
	end
	
	always @(posedge clk or negedge reset_n) begin : update_out_3_seg
		if(reset_n == 1'b0) begin
			out_reg[767:512] <= 256'h0;
		end
		else begin
			if(update_out_3 == 1'b1) begin
				out_reg[767:512] <= sha256_digest;
			end
			else begin
				out_reg[767:512] <= out[767:512];
			end
		end
	end
	
	always @(posedge clk or negedge reset_n) begin : update_out_2_seg
		if(reset_n == 1'b0) begin
			out_reg[511:256] <= 256'h0;
		end
		else begin
			if(update_out_2 == 1'b1) begin
				out_reg[511:256] <= sha256_digest;
			end
			else begin
				out_reg[511:256] <= out[511:256];
			end
		end
	end
	
	always @(posedge clk or negedge reset_n) begin : update_out_1_seg
		if(reset_n == 1'b0) begin
			out_reg[255:0] <= 256'h0;
		end
		else begin
			if(update_out_1 == 1'b1) begin
				out_reg[255:0] <= sha256_digest;
			end
			else begin
				out_reg[255:0] <= out[255:0];
			end
		end
	end
endmodule