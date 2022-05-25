module pbkdf2_2_dp(
	input	wire				clk					,	// clock signal
	input	wire				reset_n				,   // reset negative signal
	input	wire				sha256_init			,
	input	wire				sha256_first_block	,
	input	wire	[1:0]		sel_block_in		,	// sel block_in for sha256
	input	wire	[1:0]		sel_prev_hash		, 	// sel prev_hash for sha256
	input	wire				update_mem_0		,
	input	wire				store_i_o_hash		,
	input	wire	[1023:0]	in					,   // input pbkdf2_2
	input	wire	[255:0]		ixor_hash			,
	input	wire	[255:0]		oxor_hash			,

	output	wire	[255:0]		out					,   // output pbkdf2_2
	output	wire				sha256_digest_valid	
);
	parameter		index_pad 	= 	32'h00000001	;
	
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
	wire	[511:0]		sha256_1_i_block_in_wire		;
	wire	[511:0]		sha256_2_i_block_in_wire		;
	wire	[511:0]		sha256_3_i_block_in_wire		;
	wire	[511:0]		sha256_o_block_in_wire			;
// SHA256 wires for prev_digest
	wire	[255:0]		sha256_mem_0_wire				;	// KHASH - IHASH
	wire	[255:0]		sha256_ixor_mem_wire			;	// IHASH
	wire	[255:0]		sha256_oxor_mem_wire			;	// IHASH
    wire    [1023:0]    in_wire                         ;
    reg     [1023:0]    in_reg                          ;

    assign  in_wire  =  in_reg                          ;
// SHA256 wires for block_in assignments
	assign	sha256_1_i_block_in_wire	=	in_wire[1023:512]						;
	assign	sha256_2_i_block_in_wire	=	in_wire[511:0]							;
	assign	sha256_3_i_block_in_wire	= 	{index_pad, 4'h8, 476'h620}				;
	assign	sha256_o_block_in_wire		= 	{sha256_mem_0_wire, 4'h8, 252'h300}		;
	
// SHA256 memories save hash results
	reg		[255:0]		sha256_mem_0						;
	
    reg	    [255:0]		ixor_hash_reg			            ;
	reg	    [255:0]		oxor_hash_reg			            ;    
    wire    [255:0]		ixor_hash_wire			            ;
	wire    [255:0]		oxor_hash_wire			            ;
    
    
    assign  ixor_hash_wire          =   ixor_hash_reg       ;
    assign  oxor_hash_wire          =   oxor_hash_reg       ;
// SHA256 wires for prev_digest assignments
	assign	sha256_mem_0_wire 		= 	sha256_mem_0		;
	assign	sha256_ixor_mem_wire	= 	ixor_hash_wire		;
	assign	sha256_oxor_mem_wire	= 	oxor_hash_wire		;
	assign	out 					= 	sha256_digest		;
// Mux to select block_in
		mux41#(512)	mux_sel_block_in_i_hash
					(
						.in0(sha256_1_i_block_in_wire)				,
						.in1(sha256_2_i_block_in_wire)				,
						.in2(sha256_3_i_block_in_wire)				,
						.in3(sha256_o_block_in_wire)				,
						.sel(sel_block_in)							,
						.out(sha256_block_in)				
					);
		
// Mux to select prev_hash
		mux41#(256)	mux_sel_prev_hash
					(
						.in0(sha256_ixor_mem_wire)			,
						.in1(sha256_mem_0_wire)				,
						.in2(sha256_oxor_mem_wire)			,
						.in3(256'd0)						,
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
// Always for update i_o_hash
	always @(posedge clk or negedge reset_n) begin : update_i_o_hash
		if(reset_n == 1'b0) begin
			ixor_hash_reg <= 256'h0;
            oxor_hash_reg <= 256'h0;
            in_reg        <= 1024'd0;
		end
		else begin
			if(store_i_o_hash == 1'b1) begin
				ixor_hash_reg <= ixor_hash  ;
				oxor_hash_reg <= oxor_hash  ;
                in_reg        <= in         ;
			end
			else begin
				ixor_hash_reg <= ixor_hash_wire ;
				oxor_hash_reg <= oxor_hash_wire ;
                in_reg        <= in_wire        ;
			end
		end
	end
endmodule