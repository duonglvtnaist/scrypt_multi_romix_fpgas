// Blockmix Controller
module blockmix_ct (
		input 	wire	clk			,	// clock signal
		input	wire	init		,   // start signal
		input	wire	reset_n		,   // reset negative signal
		input	wire	salsa_valid	, 	// salsa have output
		output 	wire	sel_in		, 	// select input for salsa 20/8 block
		output 	wire	in_en		, 	// allow to save input data
		output 	wire	xor_en		, 	// allow to calculate xor for the first loop
		output 	wire	salsa_init	, 	// allow running salsa 20/8 block block
		output 	wire	sum_en		, 	// allow to calculate sum for the first loop
		output	wire	update_high	, 	// allow to update high-bit output
		output	wire	update_low	, 	// allow to update low-bit output
		output 	wire	valid		 	// block mix have result
);

// Parameters encoded state

	parameter S0_IDLE 		= 	4'd0;
	parameter S1_GET_IN 	= 	4'd1;
	parameter S2_XOR_0 		= 	4'd2;
	parameter S3_SALSA_0 	= 	4'd3;
	parameter S4_SUM_0 		= 	4'd4;
	parameter S5_XOR_1 		= 	4'd5;
	parameter S6_SALSA_1 	= 	4'd6;
	parameter S7_SUM_1 		= 	4'd7;
	parameter S8_DONE 		= 	4'd8;

// Registers, wires, and assignment for current states management

// Registers
	reg		[3:0]	blockmix_state_reg;
	
// Wires
	wire 	[3:0]	blockmix_state_wire;

// Assignments

	assign 	blockmix_state_wire = blockmix_state_reg;
	
// Registers and wires for next states management

// Registers
	reg		[3:0]	blockmix_next_state_reg;
	
// Wires
	wire 	[3:0]	blockmix_next_state_wire;

// Assignment

	assign 	blockmix_next_state_wire = blockmix_next_state_reg;
	
// Registers and assignments for control signals

// Registers
	reg				sel_in_reg		;
	reg				in_en_reg		;
	reg				xor_en_reg		;
	reg				salsa_init_reg	;
	reg				sum_en_reg		;
	reg				update_high_reg	;
	reg				update_low_reg	;
	reg				valid_reg		;
	
// Assignments

	assign sel_in		= 	sel_in_reg		;
	assign in_en 		= 	in_en_reg		;
	assign xor_en 		= 	xor_en_reg		;
	assign salsa_init 	= 	salsa_init_reg	;
	assign sum_en 		= 	sum_en_reg		;
	assign update_high	=	update_high_reg	;
	assign update_low	=	update_low_reg	;
	assign valid	 	= 	valid_reg		;
	
// Always block for fsms
//flipflop update state
	always @(posedge clk or negedge reset_n)begin: update_state
		if(reset_n == 1'b0) begin
			blockmix_state_reg <= S0_IDLE;
		end
		else begin
			blockmix_state_reg <= blockmix_next_state_wire;
		end
	end
//state change condition
	always @(blockmix_state_wire or init or salsa_valid) begin: update_next_state
		case (blockmix_state_wire)
			S0_IDLE: begin
				if(init == 1'b1) begin
					blockmix_next_state_reg = S1_GET_IN;
				end
				else begin
					blockmix_next_state_reg = S0_IDLE;
				end
			end
			S1_GET_IN: begin
				blockmix_next_state_reg = S2_XOR_0;
			end
			S2_XOR_0: begin
				blockmix_next_state_reg = S3_SALSA_0;
			end
			S3_SALSA_0: begin
				if(salsa_valid == 1'b1) begin
					blockmix_next_state_reg = S4_SUM_0;
				end
				else begin
					blockmix_next_state_reg = S3_SALSA_0;
				end
			end
			S4_SUM_0: begin
				blockmix_next_state_reg = S5_XOR_1;
			end
			S5_XOR_1: begin
				blockmix_next_state_reg = S6_SALSA_1;
			end
			S6_SALSA_1: begin
				if(salsa_valid == 1'b1) begin
					blockmix_next_state_reg = S7_SUM_1;
				end
				else begin
					blockmix_next_state_reg = S6_SALSA_1;
				end
			end
			S7_SUM_1: begin
				blockmix_next_state_reg = S8_DONE;
			end
			S8_DONE: begin
				if(init == 1'b0) begin
					blockmix_next_state_reg = S0_IDLE;
				end
				else begin
					blockmix_next_state_reg = S8_DONE;
				end
			end
			default: begin
				blockmix_next_state_reg = S0_IDLE;
			end
		endcase
	end
	
	always @(blockmix_state_wire) begin : output_state
		case (blockmix_state_wire)
			S0_IDLE: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;
			end
			S1_GET_IN: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b1;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;
			end
			S2_XOR_0: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b1;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;
			end
			S3_SALSA_0: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b1;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;
			end
			S4_SUM_0: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b1;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;
			end
			S5_XOR_1: begin
				sel_in_reg 		= 		1'b1;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b1;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b1;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;
			end
			S6_SALSA_1: begin
				sel_in_reg 		= 		1'b1;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b1;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;				
			end
			S7_SUM_1: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b1;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;	
			end
			S8_DONE: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b1;
				valid_reg 		= 		1'b1;		
			end
			default: begin
				sel_in_reg 		= 		1'b0;
				in_en_reg 		= 		1'b0;
				xor_en_reg 		= 		1'b0;
				salsa_init_reg 	= 		1'b0;
				sum_en_reg 		= 		1'b0;
				update_high_reg	=		1'b0;
				update_low_reg	=		1'b0;
				valid_reg 		= 		1'b0;				
			end
		endcase
	end
endmodule