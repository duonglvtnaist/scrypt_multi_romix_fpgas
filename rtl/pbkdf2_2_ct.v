module pbkdf2_2_ct(
// inputs
		input	 	wire				clk						,
		input	 	wire				reset_n					,
		input	 	wire				init					,
		input	 	wire				sha256_digest_valid		,
// outputs	
		output 		wire				sha256_init				,
		output 		wire				sha256_first_block		,
		output 		wire	[1:0]		sel_block_in			,
		output 		wire	[1:0]		sel_prev_hash			,
		output 		wire				update_mem_0			,		
        output      wire                store_i_o_hash          ,
		output		wire				valid			
);


// Parameters encoded state

	parameter	S0_IDLE 				= 	4'd0;
	parameter	S0X_STORE_I_O_HASH		=	4'd1;
	parameter	S1_IHASH_1				=	4'd2;
	parameter	S2_STORE_IHASH_1		=	4'd3;
	parameter	S3_IHASH_2				=	4'd4;
	parameter	S4_STORE_IHASH_2		=	4'd5;
	parameter	S5_IHASH_3				=	4'd6;
	parameter	S6_STORE_IHASH_3		=	4'd7;
	parameter	S7_OHASH_1				=	4'd8;
	parameter	S8_DONE					=	4'd9;
	
// Registers, wires, and assignment for current states management

// Registers
	reg		[3:0]	pbkdf2_state_reg;
	
// Wires
	wire 	[3:0]	pbkdf2_state_wire;

// Assignments

	assign 	pbkdf2_state_wire = pbkdf2_state_reg;
	
// Registers and wires for next states management

// Registers
	reg		[3:0]	pbkdf2_next_state_reg;
	
// Wires
	wire 	[3:0]	pbkdf2_next_state_wire;

// Assignment

	assign 	pbkdf2_next_state_wire = pbkdf2_next_state_reg;
	
// Registers and assignments for control signals

// Registers	
	
	reg				sha256_init_reg				;
	reg				sha256_first_block_reg		;
	reg		[1:0]	sel_block_in_reg			;
	reg		[1:0]	sel_prev_hash_reg			;
	reg				update_mem_0_reg			;
	reg				valid_reg					;
    reg             store_i_o_hash_reg          ;
	
// Assignments
	assign	sha256_init 		= sha256_init_reg			;
	assign	sha256_first_block 	= sha256_first_block_reg	;
	assign	sel_block_in 		= sel_block_in_reg			;
	assign	sel_prev_hash 		= sel_prev_hash_reg			;
	assign	update_mem_0 		= update_mem_0_reg			;
	assign	valid				= valid_reg					;
    assign  store_i_o_hash      = store_i_o_hash_reg        ;  
	
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
					pbkdf2_next_state_reg = S0X_STORE_I_O_HASH;
				end
				else begin
					pbkdf2_next_state_reg = S0_IDLE;
				end
			end
            S0X_STORE_I_O_HASH: begin
                pbkdf2_next_state_reg = S1_IHASH_1;
            end
			S1_IHASH_1: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S2_STORE_IHASH_1;
				end
				else begin
					pbkdf2_next_state_reg = S1_IHASH_1;
				end
			end
			S2_STORE_IHASH_1: begin
				pbkdf2_next_state_reg = S3_IHASH_2;
			end
			S3_IHASH_2: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S4_STORE_IHASH_2;
				end
				else begin
					pbkdf2_next_state_reg = S3_IHASH_2;
				end
			end
			S4_STORE_IHASH_2: begin
				pbkdf2_next_state_reg = S5_IHASH_3;
			end
			S5_IHASH_3: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S6_STORE_IHASH_3;
				end
				else begin
					pbkdf2_next_state_reg = S5_IHASH_3;
				end
			end
			S6_STORE_IHASH_3: begin
				pbkdf2_next_state_reg = S7_OHASH_1;
			end
			S7_OHASH_1: begin
				if(sha256_digest_valid == 1'b1) begin
					pbkdf2_next_state_reg = S8_DONE;
				end
				else begin
					pbkdf2_next_state_reg = S7_OHASH_1;
				end			
			end
			S8_DONE: begin
				if(init == 1'b0) begin
					pbkdf2_next_state_reg = S0_IDLE;
				end
				else begin
					pbkdf2_next_state_reg = S8_DONE;
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
				sha256_init_reg				=	1'b0	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd0	;	// select sha256_1_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd0	;	// select sha256_ixor_mem_wire as prev_hash
                store_i_o_hash_reg          =   1'd0    ;
				update_mem_0_reg			=	1'b0	;
				valid_reg					=	1'b0	;
			end
            S0X_STORE_I_O_HASH: begin
                sha256_init_reg				=	1'b0	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd0	;	// select sha256_1_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd0	;	// select sha256_ixor_mem_wire as prev_hash
                store_i_o_hash_reg          =   1'd1    ;
				update_mem_0_reg			=	1'b0	;
				valid_reg					=	1'b0	;
            end
			S1_IHASH_1: begin
				sha256_init_reg				=	1'b1	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd0	;	// select sha256_1_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd0	;	// select sha256_ixor_mem_wire as prev_hash
				update_mem_0_reg			=	1'b0	;
                store_i_o_hash_reg          =   1'd0    ;
				valid_reg					=	1'b0	;
			end
			S2_STORE_IHASH_1: begin
				sha256_init_reg				=	1'b0	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd1	;	// select sha256_2_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd1	;	// select sha256_mem_0_wire as prev_hash
				update_mem_0_reg			=	1'b1	;	// update mem_0
                store_i_o_hash_reg          =   1'd0    ;
				valid_reg					=	1'b0	;
			end
			S3_IHASH_2: begin
				sha256_init_reg				=	1'b1	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd1	;	// select sha256_2_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd1	;	// select sha256_mem_0_wire as prev_hash
				update_mem_0_reg			=	1'b0	;
                store_i_o_hash_reg          =   1'd0    ;                
				valid_reg					=	1'b0	;
			end
			S4_STORE_IHASH_2: begin
				sha256_init_reg				=	1'b0	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd2	;	// select sha256_3_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd1	;	// select sha256_mem_0_wire as prev_hash
				update_mem_0_reg			=	1'b1	;	// update mem_0
                store_i_o_hash_reg          =   1'd0    ;  
				valid_reg					=	1'b0	;
			end
			S5_IHASH_3: begin
				sha256_init_reg				=	1'b1	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd2	;	// select sha256_3_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd1	;	// select sha256_mem_0_wire as prev_hash
				update_mem_0_reg			=	1'b0	;
                store_i_o_hash_reg          =   1'd0    ;  
				valid_reg					=	1'b0	;
			end
			S6_STORE_IHASH_3: begin
				sha256_init_reg				=	1'b0	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd3	;	// select sha256_o_block_in_wire as block in
				sel_prev_hash_reg			=	2'd2	;	// select sha256_oxor_mem_wire as prev_hash
				update_mem_0_reg			=	1'b1	;	// update mem_0
                store_i_o_hash_reg          =   1'd0    ;  
				valid_reg					=	1'b0	;
			end
			S7_OHASH_1: begin
				sha256_init_reg				=	1'b1	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd3	;	// select sha256_3_i_block_in_wire as block in
				sel_prev_hash_reg			=	2'd2	;	// select sha256_mem_0_wire as prev_hash
				update_mem_0_reg			=	1'b0	;
                store_i_o_hash_reg          =   1'd0    ;  
				valid_reg					=	1'b0	;
			end
			S8_DONE: begin
				sha256_init_reg				=	1'b0	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd0	;
				sel_prev_hash_reg			=	2'd0	;
				update_mem_0_reg			=	1'b0	;
                store_i_o_hash_reg          =   1'd0    ;  
				valid_reg					=	1'b1	;	// output is valid
			end
			default: begin
				sha256_init_reg				=	1'b0	;
				sha256_first_block_reg		=	1'b0	;
				sel_block_in_reg			=	2'd0	;
				sel_prev_hash_reg			=	2'd0	;
				update_mem_0_reg			=	1'b0	;
                store_i_o_hash_reg          =   1'd0    ;  
				valid_reg					=	1'b0	;
			end
		endcase
	end	
	
endmodule