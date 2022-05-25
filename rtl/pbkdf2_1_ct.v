module pbkdf2_1_ct(
// inputs
		input	 	wire				clk						,
		input	 	wire				reset_n					,
		input	 	wire				init					,
		input	 	wire				sha256_digest_valid		,
// outputs	
		output 		wire				sha256_init				,
		output 		wire				sha256_first_block		,
		output 		wire	[1:0]		sel_block_in_i_hash		,
		output 		wire				sel_block_in_o_hash		,
		output 		wire				sel_block_in			,
		output 		wire	[1:0]		sel_prev_hash			,
		output 		wire				update_mem_0			,
		output 		wire				update_mem_1			,
		output 		wire				update_ixor_mem			,
		output 		wire				update_oxor_mem			,
		output		wire				update_out_4			,
		output		wire				update_out_3			,
		output		wire				update_out_2			,
		output		wire				update_out_1			,
		output 		wire	[2:0]		index					,		
		output		wire				valid			
);


// Parameters encoded state

	parameter	S0_IDLE 				= 	5'd0;
	parameter	S1_KHASH_0				=	5'd1;
	parameter	S2_STORE_KHASH_0		=	5'd2;
	parameter	S3_KHASH_1				=	5'd3;
	parameter	S4_STORE_KHASH_1		=	5'd4;
	parameter	S5_IHASH_0				=	5'd5;
	parameter	S6_STORE_IHASH_0		=	5'd6;
	parameter	S7_OHASH_0				=	5'd7;
	parameter	S8_STORE_OHASH_0		=	5'd8;
	parameter	S9_IHASH_1				=	5'd9;
	parameter	S10_STORE_IHASH_1		=	5'd10;
	parameter	S11_IHASH_2				=	5'd11;
	parameter	S12_STORE_IHASH_2		=	5'd12;
	parameter	S13_OHASH_1				=	5'd13;
	parameter	S14_STORE_OHASH_1		=	5'd14;
	parameter	S15_IHASH_3				=	5'd15;
	parameter	S16_STORE_IHASH_3		=	5'd16;
	parameter	S17_OHASH_2				=	5'd17;
	parameter	S18_STORE_OHASH_2		=	5'd18;
	parameter	S19_IHASH_4				=	5'd19;
	parameter	S20_STORE_IHASH_4		=	5'd20;
	parameter	S21_OHASH_3				=	5'd21;
	parameter	S22_STORE_OHASH_3		=	5'd22;
	parameter	S23_IHASH_5				=	5'd23;
	parameter	S24_STORE_IHASH_5		=	5'd24;
	parameter	S25_OHASH_4				=	5'd25;
	parameter	S26_STORE_OHASH_4		=	5'd26;
	parameter	S27_DONE				=	5'd27;
	
// Registers, wires, and assignment for current states management

// Registers
	reg		[4:0]	pbkdf2_state_reg;
	
// Wires
	wire 	[4:0]	pbkdf2_state_wire;

// Assignments

	assign 	pbkdf2_state_wire = pbkdf2_state_reg;
	
// Registers and wires for next states management

// Registers
	reg		[4:0]	pbkdf2_next_state_reg;
	
// Wires
	wire 	[4:0]	pbkdf2_next_state_wire;

// Assignment

	assign 	pbkdf2_next_state_wire = pbkdf2_next_state_reg;
	
// Registers and assignments for control signals

// Registers	
	
	reg				sha256_init_reg				;
	reg				sha256_first_block_reg		;
	reg		[1:0]	sel_block_in_i_hash_reg		;
	reg				sel_block_in_o_hash_reg		;
	reg				sel_block_in_reg			;
	reg		[1:0]	sel_prev_hash_reg			;
	reg				update_mem_0_reg			;
	reg				update_mem_1_reg			;
	reg				update_ixor_mem_reg			;
	reg				update_oxor_mem_reg			;
	reg				update_out_4_reg			;
	reg				update_out_3_reg			;
	reg				update_out_2_reg			;
	reg				update_out_1_reg			;
	reg 	[2:0]	index_reg	                ;
	reg				valid_reg					;
	
// Assignments
	assign	sha256_init 		= sha256_init_reg			;
	assign	sha256_first_block 	= sha256_first_block_reg	;
	assign	sel_block_in_i_hash = sel_block_in_i_hash_reg	;
	assign	sel_block_in_o_hash = sel_block_in_o_hash_reg	;
	assign	sel_block_in 		= sel_block_in_reg			;
	assign	sel_prev_hash 		= sel_prev_hash_reg			;
	assign	update_mem_0 		= update_mem_0_reg			;
	assign	update_mem_1 		= update_mem_1_reg			;
	assign	update_ixor_mem 	= update_ixor_mem_reg		;
	assign	update_oxor_mem 	= update_oxor_mem_reg		;
	assign	update_out_4 		= update_out_4_reg			;
	assign	update_out_3 		= update_out_3_reg			;
	assign	update_out_2 		= update_out_2_reg			;
	assign	update_out_1 		= update_out_1_reg			;
	assign	index 				= index_reg					;
	assign	valid				= valid_reg					;
	
// Always block for fsms
//flipflop update state
	always @(posedge clk or negedge reset_n)begin: update_state
		if(reset_n == 1'b0) begin
			pbkdf2_state_reg <= S0_IDLE;
		end
		else begin
			pbkdf2_state_reg <= pbkdf2_next_state_wire;
		end
	end	

//state change condition
	always @(pbkdf2_state_wire or init or sha256_digest_valid) begin: update_next_state
		case (pbkdf2_state_wire)
			S0_IDLE: begin
				if(init == 1'b1) begin
					pbkdf2_next_state_reg = S1_KHASH_0;
				end
				else begin
					pbkdf2_next_state_reg = S0_IDLE;
				end
			end
			S1_KHASH_0: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S2_STORE_KHASH_0;
				end
				else begin
					pbkdf2_next_state_reg = S1_KHASH_0;
				end
			end
			S2_STORE_KHASH_0: begin
				pbkdf2_next_state_reg = S3_KHASH_1;
			end
			S3_KHASH_1: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S4_STORE_KHASH_1;
				end
				else begin
					pbkdf2_next_state_reg = S3_KHASH_1;
				end
			end
			S4_STORE_KHASH_1: begin
				pbkdf2_next_state_reg = S5_IHASH_0;
			end
			S5_IHASH_0: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S6_STORE_IHASH_0;
				end
				else begin
					pbkdf2_next_state_reg = S5_IHASH_0;
				end
			end
			S6_STORE_IHASH_0: begin
				pbkdf2_next_state_reg = S7_OHASH_0;
			end
			S7_OHASH_0: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S8_STORE_OHASH_0;
				end
				else begin
					pbkdf2_next_state_reg = S7_OHASH_0;
				end			
			end
			S8_STORE_OHASH_0: begin
				pbkdf2_next_state_reg = S9_IHASH_1;
			end
			S9_IHASH_1: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S10_STORE_IHASH_1;
				end
				else begin
					pbkdf2_next_state_reg = S9_IHASH_1;
				end		
			end
			S10_STORE_IHASH_1: begin
				pbkdf2_next_state_reg = S11_IHASH_2;
			end
			S11_IHASH_2: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S12_STORE_IHASH_2;
				end
				else begin
					pbkdf2_next_state_reg = S11_IHASH_2;
				end		
			end
			S12_STORE_IHASH_2: begin
				pbkdf2_next_state_reg = S13_OHASH_1;
			end
			S13_OHASH_1: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S14_STORE_OHASH_1;
				end
				else begin
					pbkdf2_next_state_reg = S13_OHASH_1;
				end		
			end
			S14_STORE_OHASH_1: begin
				pbkdf2_next_state_reg = S15_IHASH_3;
			end
			S15_IHASH_3: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S16_STORE_IHASH_3;
				end
				else begin
					pbkdf2_next_state_reg = S15_IHASH_3;
				end		
			end
			S16_STORE_IHASH_3: begin
				pbkdf2_next_state_reg = S17_OHASH_2;
			end
			S17_OHASH_2: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S18_STORE_OHASH_2;
				end
				else begin
					pbkdf2_next_state_reg = S17_OHASH_2;
				end		
			end
			S18_STORE_OHASH_2: begin
				pbkdf2_next_state_reg = S19_IHASH_4;
			end
			S19_IHASH_4: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S20_STORE_IHASH_4;
				end
				else begin
					pbkdf2_next_state_reg = S19_IHASH_4;
				end		
			end
			S20_STORE_IHASH_4: begin
				pbkdf2_next_state_reg = S21_OHASH_3;
			end
			S21_OHASH_3: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S22_STORE_OHASH_3;
				end
				else begin
					pbkdf2_next_state_reg = S21_OHASH_3;
				end		
			end
			S22_STORE_OHASH_3: begin
				pbkdf2_next_state_reg = S23_IHASH_5;
			end
			S23_IHASH_5: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S24_STORE_IHASH_5;
				end
				else begin
					pbkdf2_next_state_reg = S23_IHASH_5;
				end		
			end
			S24_STORE_IHASH_5: begin
				pbkdf2_next_state_reg = S25_OHASH_4;
			end
			S25_OHASH_4: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S26_STORE_OHASH_4;
				end
				else begin
					pbkdf2_next_state_reg = S25_OHASH_4;
				end		
			end
			S26_STORE_OHASH_4: begin
				pbkdf2_next_state_reg = S27_DONE;
			end
			S27_DONE: begin
				if(init == 1'b0) begin
					pbkdf2_next_state_reg = S0_IDLE;
				end
				else begin
					pbkdf2_next_state_reg = S27_DONE;
				end			
			end
			default: begin
				pbkdf2_next_state_reg = S0_IDLE;
			end
		endcase
	end
	
	always @(pbkdf2_state_wire) begin : output_state
		case (pbkdf2_state_wire)
			S0_IDLE: begin
				sha256_init_reg 		= 1'b0;
                sha256_first_block_reg 	= 1'b1;	// use constant for sha256 core
                sel_block_in_i_hash_reg = 2'd0;
                sel_block_in_o_hash_reg = 1'b0;
                sel_block_in_reg 		= 1'b0;	// choose IHASH - KHASH
                sel_prev_hash_reg 		= 2'd0;	// use constant - ignored
                update_mem_0_reg 		= 1'b0;	
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S1_KHASH_0: begin
				sha256_init_reg 		= 1'b1; // run sha256 core
                sha256_first_block_reg 	= 1'b1;	// use constant for sha256 core
                sel_block_in_i_hash_reg = 2'd0;	// select high input bit
                sel_block_in_o_hash_reg = 1'b0;
                sel_block_in_reg 		= 1'b0;	// choose IHASH - KHASH
                sel_prev_hash_reg 		= 2'd0;	// use constant - ignored
                update_mem_0_reg 		= 1'b0;	
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;	
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S2_STORE_KHASH_0: begin
				sha256_init_reg 		= 1'b0;
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd1;	// select low input bit
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH - KHASH
                sel_prev_hash_reg 		= 2'b0;	// select sha256_mem_0 as prev_hash
                update_mem_0_reg 		= 1'b1;	// update mem_0
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;	
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S3_KHASH_1: begin
				sha256_init_reg 		= 1'b1;	// run sha256 core
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd1;	// select low input bit
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH - KHASH
                sel_prev_hash_reg 		= 2'b0;	// select sha256_mem_0 as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;	
                index_reg 				= 3'd0;	// don't use
				valid_reg				= 1'b0;				
			end
			S4_STORE_KHASH_1: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b1;	// use constant for sha256 core
                sel_block_in_i_hash_reg = 2'd2;	// select i_xor_wire as block_in
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH - KHASH
                sel_prev_hash_reg 		= 2'd0;	// use constant for sha256 core
                update_mem_0_reg 		= 1'b1; // update mem_0
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;	
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S5_IHASH_0: begin
				sha256_init_reg 		= 1'b1;	// run sha256 core
                sha256_first_block_reg 	= 1'b1;	// use constant for sha256 core
                sel_block_in_i_hash_reg = 2'd2;	// select i_xor_wire as block_in
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH - KHASH
                sel_prev_hash_reg 		= 2'd0;	// use constant for sha256 core
                update_mem_0_reg 		= 1'b0; 
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;	
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S6_STORE_IHASH_0: begin
				sha256_init_reg			= 1'b0;	
                sha256_first_block_reg 	= 1'b1;	// use constant for sha256 core
                sel_block_in_i_hash_reg = 2'd0;	
                sel_block_in_o_hash_reg = 1'b0;	// select o_xor_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd0;	// use constant for sha256 core
                update_mem_0_reg 		= 1'b0; 
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b1;	// update i_xor mem
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S7_OHASH_0: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b1;	// use constant for sha256 core
                sel_block_in_i_hash_reg = 2'd0;	
                sel_block_in_o_hash_reg = 1'b0;	// select o_xor_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd0;	// use constant for sha256 core
                update_mem_0_reg 		= 1'b0; 
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd0;	// don't use
				valid_reg				= 1'b0;
			end
			S8_STORE_OHASH_0: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd0;	// select input high bit as block_in
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd2;	// use sha256_ixor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b0; 
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b1; // update o_xor mem
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S9_IHASH_1: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd0;	// select input high bit as block_in
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd2;	// use sha256_ixor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b0; 
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
			S10_STORE_IHASH_1: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0; 
                update_mem_1_reg 		= 1'b1;	// update mem_1
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd1;	// choose index 
				valid_reg				= 1'b0;
			end
			S11_IHASH_2: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0; 
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd1;	// choose index 
				valid_reg				= 1'b0;
			end
			S12_STORE_IHASH_2: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_in_o_hash as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b1;	// update mem_0 
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd1;	// choose index 
				valid_reg				= 1'b0;
			end
			S13_OHASH_1: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_in_o_hash as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd1;	// choose index 
				valid_reg				= 1'b0;
			end
			S14_STORE_OHASH_1: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b1;	// update out_seg_4
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd2;	// choose index 
				valid_reg				= 1'b0;
			end
			S15_IHASH_3: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b0;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd2;	// choose index 
				valid_reg				= 1'b0;
			end
			S16_STORE_IHASH_3: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_o_hash_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b1;	// update mem_0
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd2;	// choose index 
				valid_reg				= 1'b0;
			end
			S17_OHASH_2: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_o_hash_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b0;	
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd2;	// choose index
				valid_reg				= 1'b0;				
			end
			S18_STORE_OHASH_2: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b1; // update out_seg_3
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd3;	// choose index	
				valid_reg				= 1'b0;				
			end
			S19_IHASH_4: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd3;	// choose index	
				valid_reg				= 1'b0;
			end
			S20_STORE_IHASH_4: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_o_hash_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b1;	// update mem_0
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd3;	// choose index	
				valid_reg				= 1'b0;
			end
			S21_OHASH_3: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_o_hash_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b0;	
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd3;	// choose index
				valid_reg				= 1'b0;
			end
			S22_STORE_OHASH_3: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b1; // update out_seg_2
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd4;	// choose index
				valid_reg				= 1'b0;				
			end
			S23_IHASH_5: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd4;	// choose index	
				valid_reg				= 1'b0;
			end
			S24_STORE_IHASH_5: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_o_hash_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b1;	// update mem_0
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd4;	// choose index		
				valid_reg				= 1'b0;
			end
			S25_OHASH_4: begin
				sha256_init_reg 		= 1'b1;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	
                sel_block_in_o_hash_reg = 1'b1;	// select block_o_hash_wire as block_in
                sel_block_in_reg 		= 1'b1;	// choose OHASH
                sel_prev_hash_reg 		= 2'd3;	// use sha256_oxor_mem_wire as prev_hash
                update_mem_0_reg 		= 1'b0;	
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd4;	// choose index
				valid_reg				= 1'b0;
			end
			S26_STORE_OHASH_4: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0; 
				update_out_1_reg		= 1'b1;	// update out_seg_1
                index_reg 				= 3'd4;	// choose index	
				valid_reg				= 1'b0;
			end
			S27_DONE: begin
				sha256_init_reg 		= 1'b0;	
                sha256_first_block_reg 	= 1'b0;	// use mux for prev_hash
                sel_block_in_i_hash_reg = 2'd3;	// select block_index_wire as block_in
                sel_block_in_o_hash_reg = 1'b1;	
                sel_block_in_reg 		= 1'b0;	// choose IHASH-KHASH
                sel_prev_hash_reg 		= 2'd1;	// use sha256_mem_1_wire as prev_hash
                update_mem_0_reg 		= 1'b0;
                update_mem_1_reg 		= 1'b0;
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0; 
				update_out_1_reg		= 1'b0;
                index_reg 				= 3'd4;	// choose index	
				valid_reg				= 1'b1;
			end
			default: begin
				sha256_init_reg 		= 1'b0;
                sha256_first_block_reg 	= 1'b0;	// use constant for sha256 core
                sel_block_in_i_hash_reg = 2'd0;
                sel_block_in_o_hash_reg = 1'b0;
                sel_block_in_reg 		= 1'b0;	// choose IHASH - KHASH
                sel_prev_hash_reg 		= 1'b0;	// use constant - ignored
                update_mem_0_reg 		= 1'b0;	
                update_mem_1_reg 		= 1'b0;	
                update_ixor_mem_reg 	= 1'b0;	
                update_oxor_mem_reg 	= 1'b0;
				update_out_4_reg		= 1'b0;
				update_out_3_reg		= 1'b0;
				update_out_2_reg		= 1'b0;
				update_out_1_reg		= 1'b0;	
                index_reg 				= 3'd0;	// don't use 
				valid_reg				= 1'b0;
			end
		endcase
	end	
	
endmodule