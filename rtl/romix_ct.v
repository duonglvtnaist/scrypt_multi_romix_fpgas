module romix_ct (
		input 	wire				clk				,
		input 	wire				init			,
		input	wire				reset_n			,
		
		input	wire				blockmix_valid	,
		input	wire				first_count		,
		input	wire				end_count		,
		
		
		// output	wire				keep_input		,
		output	wire				counter_reset_n	,
		output	wire				count_up		,
		output 	wire				blockmix_en		,
		output	wire				sel_mux_0		,
		output	wire				sel_mux_1		,
		output	wire				sel_mux_2		,
		output	wire				write_en		,
		output	wire				valid					
);

// Parameters encoded state

	parameter S0_IDLE 				= 	4'd0;
	parameter S1_START_WRITE		= 	4'd1;
	parameter S2_BLOCKMIX_WRITE		= 	4'd2;
	parameter S3_INCR_ADDR_WRITE	= 	4'd3;
	parameter S4_WRITE_MEM			= 	4'd4;
	parameter S5_START_READ			= 	4'd5;
	parameter S6_BLOCKMIX_READ		= 	4'd6;
	parameter S7_UPDATE_ADDR_READ	= 	4'd7;
	parameter S8_LAST_BLOCKMIX		= 	4'd8;
	parameter S9_DONE 				= 	4'd9;

// Registers, wires, and assignment for current states management

// Registers
	reg		[3:0]	romix_state_reg;
	
// Wires
	wire 	[3:0]	romix_state_wire;

// Assignments

	assign 	romix_state_wire = romix_state_reg;
	
// Registers and wires for next states management

// Registers
	reg		[3:0]	romix_next_state_reg;
	
// Wires
	wire 	[3:0]	romix_next_state_wire;

// Assignment

	assign 	romix_next_state_wire = romix_next_state_reg;
	
// Registers and assignments for control signals

// Registers
	
	reg				keep_input_reg		;
	reg				counter_reset_n_reg	;
	reg				count_up_reg		;
	reg				blockmix_en_reg		;
	reg				sel_mux_0_reg		;
	reg				sel_mux_1_reg		;
	reg				sel_mux_2_reg		;
	reg				write_en_reg		;
	reg				valid_reg			;					
	
	
// Assignments

	// assign	keep_input		 		= 		keep_input_reg		;
	assign	counter_reset_n	 		= 		counter_reset_n_reg	;
	assign	count_up		 		= 		count_up_reg		;
	assign	blockmix_en		 		= 		blockmix_en_reg		;
	assign	sel_mux_0		 		= 		sel_mux_0_reg		;
	assign	sel_mux_1		 		= 		sel_mux_1_reg		;
	assign	sel_mux_2		 		= 		sel_mux_2_reg		;
	assign	write_en		 		= 		write_en_reg		;
	assign	valid			 		= 		valid_reg			;
	
// Always block for fsms
//flipflop update state
	always @(posedge clk or negedge reset_n)begin: update_state
		if(reset_n == 1'b0) begin
			romix_state_reg <= S0_IDLE;
		end
		else begin
			romix_state_reg <= romix_next_state_wire;
		end
	end	

//state change condition
	always @(romix_state_wire or init or blockmix_valid or end_count) begin: update_next_state
		case (romix_state_wire)
			S0_IDLE: begin
				if(init == 1'b1) begin
					romix_next_state_reg = S1_START_WRITE;
				end
				else begin
					romix_next_state_reg = S0_IDLE;
				end
			end
			S1_START_WRITE: begin
				romix_next_state_reg = S2_BLOCKMIX_WRITE;
			end
			S2_BLOCKMIX_WRITE: begin
				if(blockmix_valid == 1'b1) begin
					romix_next_state_reg = S3_INCR_ADDR_WRITE;
				end
				else begin
					romix_next_state_reg = S2_BLOCKMIX_WRITE;
				end
			end
			S3_INCR_ADDR_WRITE: begin
				romix_next_state_reg = S4_WRITE_MEM;
			end
			S4_WRITE_MEM: begin								// increase
				if(end_count == 1'b1) begin
					romix_next_state_reg = S5_START_READ;
				end
				else begin
					romix_next_state_reg = S2_BLOCKMIX_WRITE;
				end
			end
			S5_START_READ: begin
				if(blockmix_valid == 1'b1) begin
					romix_next_state_reg = S6_BLOCKMIX_READ;
				end
				else begin
					romix_next_state_reg = S5_START_READ;
				end
			end
			S6_BLOCKMIX_READ: begin
				if(blockmix_valid == 1'b1) begin
					romix_next_state_reg = S7_UPDATE_ADDR_READ;
				end
				else begin
					romix_next_state_reg = S6_BLOCKMIX_READ;
				end
			end
			S7_UPDATE_ADDR_READ: begin
				if(end_count == 1'b1) begin
					romix_next_state_reg = S8_LAST_BLOCKMIX;
				end
				else begin
					romix_next_state_reg = S6_BLOCKMIX_READ;
				end
			end
			S8_LAST_BLOCKMIX: begin
				if(blockmix_valid == 1'b1) begin
					romix_next_state_reg = S9_DONE;
				end
				else begin
					romix_next_state_reg = S8_LAST_BLOCKMIX;
				end
			end
			S9_DONE: begin
				if(init == 1'b0) begin
					romix_next_state_reg = S0_IDLE;
				end
				else begin
					romix_next_state_reg = S9_DONE;
				end
			end
			default: begin
				romix_next_state_reg = S0_IDLE;
			end
		endcase
	end
	
	always @(romix_state_wire or first_count) begin : output_state
		case (romix_state_wire)
			S0_IDLE: begin
				// keep_input_reg		= 1'b1	;
				counter_reset_n_reg	= 1'b0	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b0	;
				sel_mux_0_reg		= 1'b0	;
				sel_mux_1_reg		= 1'b0	;
				sel_mux_2_reg		= 1'b0	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b0	;

			end
			S1_START_WRITE: begin	// Write the first value to the first mem
				// keep_input_reg		= 1'b1	;
				counter_reset_n_reg	= 1'b1	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b0	;
				sel_mux_0_reg		= 1'b0	;
				sel_mux_1_reg		= 1'b0	;
				sel_mux_2_reg		= 1'b0	;
				write_en_reg		= 1'b1	;
				valid_reg			= 1'b0	;
			end
			S2_BLOCKMIX_WRITE: begin 
				if(first_count == 1'b1) begin
					// keep_input_reg		= 1'b1	;
					counter_reset_n_reg	= 1'b1	;
					count_up_reg		= 1'b0	;
					blockmix_en_reg		= 1'b1	;
					sel_mux_0_reg		= 1'b0	;
					sel_mux_1_reg		= 1'b0	;
					sel_mux_2_reg		= 1'b0	;
					write_en_reg		= 1'b0	;
					valid_reg			= 1'b0	;
				end
				else begin
					// keep_input_reg		= 1'b0	;
					counter_reset_n_reg	= 1'b1	;
					count_up_reg		= 1'b0	;
					blockmix_en_reg		= 1'b1	;
					sel_mux_0_reg		= 1'b1	;
					sel_mux_1_reg		= 1'b0	;
					sel_mux_2_reg		= 1'b0	;
					write_en_reg		= 1'b0	;
					valid_reg			= 1'b0	;
				end
			end
			S3_INCR_ADDR_WRITE: begin	// save to mem and increase address in the next state
				// keep_input_reg		= 1'b0	;
				counter_reset_n_reg	= 1'b1	;
				count_up_reg		= 1'b1	;
				blockmix_en_reg		= 1'b0	;
				sel_mux_0_reg		= 1'b1	;
				sel_mux_1_reg		= 1'b0	;
				sel_mux_2_reg		= 1'b0	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b0	;
			end
			S4_WRITE_MEM: begin
				// keep_input_reg		= 1'b0	;
				counter_reset_n_reg	= 1'b1	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b0	;
				sel_mux_0_reg		= 1'b1	;
				sel_mux_1_reg		= 1'b0	;
				sel_mux_2_reg		= 1'b0	;
				write_en_reg		= 1'b1	;
				valid_reg			= 1'b0	;
			end
			S5_START_READ: begin					// calculation last read blockmix
				// keep_input_reg		= 1'b0	;
				counter_reset_n_reg	= 1'b0	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b1	;
				sel_mux_0_reg		= 1'b1	;
				sel_mux_1_reg		= 1'b0	;
				sel_mux_2_reg		= 1'b1	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b0	;
			end
			S6_BLOCKMIX_READ: begin
				// keep_input_reg		= 1'b0	;
				counter_reset_n_reg	= 1'b1	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b1	;
				sel_mux_0_reg		= 1'b1	;
				sel_mux_1_reg		= 1'b1	;
				sel_mux_2_reg		= 1'b1	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b0	;
			end
			S7_UPDATE_ADDR_READ: begin
				// keep_input_reg		= 1'b0	;
				counter_reset_n_reg	= 1'b1	;
				count_up_reg		= 1'b1	;
				blockmix_en_reg		= 1'b0	;
				sel_mux_0_reg		= 1'b1	;
				sel_mux_1_reg		= 1'b1	;
				sel_mux_2_reg		= 1'b1	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b0	;
			end
			S8_LAST_BLOCKMIX: begin
				// keep_input_reg		= 1'b0	;
				counter_reset_n_reg	= 1'b0	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b1	;
				sel_mux_0_reg		= 1'b1	;
				sel_mux_1_reg		= 1'b1	;
				sel_mux_2_reg		= 1'b1	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b0	;
			end
			S9_DONE: begin
				// keep_input_reg		= 1'b0	;
				counter_reset_n_reg	= 1'b0	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b0	;
				sel_mux_0_reg		= 1'b1	;
				sel_mux_1_reg		= 1'b1	;
				sel_mux_2_reg		= 1'b1	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b1	;
			end
			default: begin
				// keep_input_reg		= 1'b1	;
				counter_reset_n_reg	= 1'b0	;
				count_up_reg		= 1'b0	;
				blockmix_en_reg		= 1'b0	;
				sel_mux_0_reg		= 1'b0	;
				sel_mux_1_reg		= 1'b0	;
				sel_mux_2_reg		= 1'b0	;
				write_en_reg		= 1'b0	;
				valid_reg			= 1'b0	;	
			end
		endcase
	end
	
	
	
endmodule