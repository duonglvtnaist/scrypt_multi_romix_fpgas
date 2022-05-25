module sha256_core_standard_fsm#(
					// Constants for state
					parameter S0_IDLE 				= 2'd0,
					parameter S1_ROUNDS 			= 2'd1,
					parameter S2_DONE				= 2'd3
					)
					(
					input		wire 		clk,
					input		wire 		reset_n,
					input		wire 		init,
					input		wire 		t_ctr_last,
					output 		wire		t_ctr_init,
					output		wire		t_ctr_next,
					output		wire		digest_init,
					output		wire		loop_init,
					output		wire		loop_next,
					output		wire		w_init,
					output		wire		w_next,
					output		wire		digest_valid
					);
	reg 	[1:0]	sha256_core_state_reg = S0_IDLE;
	reg		[1:0]	sha256_core_state_new;
	reg				t_ctr_init_reg		;
	reg				digest_init_reg		;
	reg				loop_init_reg		;
	reg				t_ctr_next_reg		;
	reg				digest_next_reg		;
	reg				loop_next_reg		;
	reg				digest_valid_reg	;
	reg				w_init_reg			;
	reg				w_next_reg			;
	wire	[1:0]	sha256_core_state_wire;

	//Combinational Output Logic
	assign	sha256_core_state_wire	=	sha256_core_state_reg;
	assign	t_ctr_init				= 	t_ctr_init_reg;
	assign	digest_init  			= 	digest_init_reg;	
	assign	loop_init	 			= 	loop_init_reg;	
	assign	t_ctr_next	 			= 	t_ctr_next_reg;
	assign	loop_next   			= 	loop_next_reg;
	assign	digest_valid			= 	digest_valid_reg;
	assign 	w_init 					= 	w_init_reg;
	assign 	w_next 					= 	w_next_reg;
	
	// Next state block
	always @(sha256_core_state_wire or init or t_ctr_last) begin: combinational_next_state_logic
		case(sha256_core_state_wire)
			S0_IDLE: begin
				if(init == 1'b1) begin
					sha256_core_state_new = S1_ROUNDS;
				end
				else begin
					sha256_core_state_new = S0_IDLE;
				end
			end
			S1_ROUNDS: begin
				if(t_ctr_last == 1'b1) begin
					sha256_core_state_new = S2_DONE;
				end
				else begin
					sha256_core_state_new = S1_ROUNDS;
				end
			end
			S2_DONE: begin
				if(init == 1'b0) begin
					sha256_core_state_new = S0_IDLE;
				end
				else begin
					sha256_core_state_new = S2_DONE;
				end
			end
			default: sha256_core_state_new = S0_IDLE;
		endcase
	end
	
	//output logic
	always@(sha256_core_state_wire) begin
		case(sha256_core_state_wire)
		S0_IDLE: begin
			t_ctr_init_reg		=	1'b1;
			digest_init_reg		=	1'b1;
			loop_init_reg		=	1'b1;
			w_init_reg			=  	1'b1;
			w_next_reg			= 	1'b0;
			t_ctr_next_reg		=	1'b0;
			loop_next_reg		=	1'b0;
			digest_valid_reg	=	1'b0;
		end
		S1_ROUNDS: begin
			t_ctr_init_reg		=	1'b0;
			digest_init_reg		=	1'b0;
			loop_init_reg		=	1'b0;
			w_init_reg			= 	1'b0;
			w_next_reg			= 	1'b1;
			t_ctr_next_reg		=	1'b1;
			loop_next_reg		=	1'b1;
			digest_valid_reg	=	1'b0;				
		end
		S2_DONE: begin
			t_ctr_init_reg		=	1'b0;
			digest_init_reg		=	1'b0;
			loop_init_reg		=	1'b0;
			w_init_reg			= 	1'b0;
			w_next_reg			= 	1'b0;
			t_ctr_next_reg		=	1'b0;
			loop_next_reg		=	1'b0;
			digest_valid_reg	=	1'b1;				
		end
		default: begin
			t_ctr_init_reg		=	1'b0;
			digest_init_reg		=	1'b0;
			loop_init_reg		=	1'b0;
			t_ctr_next_reg		=	1'b0;
			w_init_reg			= 	1'b0;
			w_next_reg			= 	1'b0;
			loop_next_reg		=	1'b0;
			digest_valid_reg	=	1'b0;
		end
		endcase
	end

	// State FF transition
	always @(posedge clk or negedge reset_n) begin: state_ff_transition
		if(reset_n == 1'b0) begin
			sha256_core_state_reg <= S0_IDLE;
		end
		else begin
			sha256_core_state_reg <= sha256_core_state_new;
		end
	end

endmodule