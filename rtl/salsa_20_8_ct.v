module salsa_20_8_ct(
	input	wire	clk,
	input	wire	init,
	input	wire	reset_n,
	output	wire	write_temp,
	output	wire	sel_in,	
	// output	wire	sel_order,	
	output  wire	valid
);
	parameter IDLE = 4'd0;
	// parameter ROUNDS_1_1 = 4'd1;
	parameter ROUNDS_1_2 = 4'd2;
	parameter ROUNDS_2_1 = 4'd3;
	parameter ROUNDS_2_2 = 4'd4;
	parameter ROUNDS_3_1 = 4'd5;
	parameter ROUNDS_3_2 = 4'd6;
	parameter ROUNDS_4_1 = 4'd7;
	parameter ROUNDS_4_2 = 4'd8;
	parameter DONE = 4'd9;
	
	// Control registers and wires
	reg  [3:0] salsa_state_reg;
	wire [3:0] salsa_state_wire;
	reg  [3:0] salsa_next_state_reg;
	wire [3:0] salsa_next_state_wire;
	
	// Control signals
	reg write_temp_reg;
	reg sel_in_reg;
	// reg sel_order_reg;
	reg valid_reg;
	
	// Assign
	
	assign salsa_state_wire 		= salsa_state_reg;
	assign salsa_next_state_wire 	= salsa_next_state_reg;
	
	assign write_temp  = write_temp_reg;
	assign sel_in 	   = sel_in_reg;
	// assign sel_order   = sel_order_reg;
	assign valid 	   = valid_reg;
	
	// Always block for fsm
	always @(posedge clk or negedge reset_n) begin : update_state
		if(reset_n == 1'b0) begin
			salsa_state_reg <= IDLE;
		end
		else begin
			salsa_state_reg <= salsa_next_state_wire;
		end
	end
	
	always @(salsa_state_wire or init) begin: update_next_state
		case (salsa_state_wire)
			IDLE: begin
				if(init == 1'b1) begin
					salsa_next_state_reg = ROUNDS_1_2;
				end
				else begin
					salsa_next_state_reg = IDLE;
				end
			end
			// ROUNDS_1_1: begin
				// salsa_next_state_reg = ROUNDS_1_2;
			// end
			ROUNDS_1_2: begin
				salsa_next_state_reg = ROUNDS_2_1;
			end
			ROUNDS_2_1: begin
				salsa_next_state_reg = ROUNDS_2_2;
			end
			ROUNDS_2_2: begin
				salsa_next_state_reg = ROUNDS_3_1;
			end
			ROUNDS_3_1: begin
				salsa_next_state_reg = ROUNDS_3_2;
			end
			ROUNDS_3_2: begin
				salsa_next_state_reg = ROUNDS_4_1;
			end
			ROUNDS_4_1: begin
				salsa_next_state_reg = ROUNDS_4_2;
			end
			ROUNDS_4_2: begin
				salsa_next_state_reg = DONE;
			end
			DONE: begin 
				if(init == 1'b0) begin
					salsa_next_state_reg = IDLE;
				end
				else begin
					salsa_next_state_reg = DONE;
				end
			end
			default: begin
				salsa_next_state_reg = IDLE;
			end
		endcase
	end
	
	always @(salsa_state_wire) begin : output_state
		case (salsa_state_wire)
			IDLE: begin
				sel_in_reg 		= 1'b0;
				//sel_order_reg 	= 1'b0;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b1;
			end
			// ROUNDS_1_1: begin
				// sel_in_reg 		= 1'b0;
				// sel_order_reg 	= 1'b0;
				// valid_reg 		= 1'b0;
				// write_temp_reg 	= 1'b1;
			// end
			ROUNDS_1_2: begin
				sel_in_reg 		= 1'b1;
				// sel_order_reg	= 1'b1;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b1;
			end
			ROUNDS_2_1: begin
				sel_in_reg 		= 1'b1;
				//sel_order_reg 	= 1'b0;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b1;
			end
			ROUNDS_2_2: begin
				sel_in_reg 		= 1'b1;
				//sel_order_reg 	= 1'b1;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b1;
			end
			ROUNDS_3_1: begin
				sel_in_reg 		= 1'b1;
				//sel_order_reg 	= 1'b0;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b1;
			end
			ROUNDS_3_2: begin
				sel_in_reg 		= 1'b1;
				//sel_order_reg 	= 1'b1;
				valid_reg 		= 1'b0;
				write_temp_reg	= 1'b1;
			end
			ROUNDS_4_1: begin
				sel_in_reg 		= 1'b1;
				//sel_order_reg 	= 1'b0;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b1;
			end
			ROUNDS_4_2: begin
				sel_in_reg 		= 1'b1;
				//sel_order_reg 	= 1'b1;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b1;
			end
			DONE: begin 
				sel_in_reg 		= 1'b1;
				//sel_order_reg 	= 1'b1;
				valid_reg 		= 1'b1;
				write_temp_reg 	= 1'b0;
			end
			default: begin
				sel_in_reg 		= 1'b0;
				//sel_order_reg 	= 1'b0;
				valid_reg 		= 1'b0;
				write_temp_reg 	= 1'b0;
			end
		endcase
	end
endmodule