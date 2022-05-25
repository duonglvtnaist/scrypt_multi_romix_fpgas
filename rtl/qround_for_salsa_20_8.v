module q_round_for_salsa_20_8(
								input wire [31:0] x0,
								input wire [31:0] x1,
								input wire [31:0] x2,
								input wire [31:0] x3,
								output wire [31:0] out0,
								output wire [31:0] out1,
								output wire [31:0] out2,
								output wire [31:0] out3
);
   
	// Sum wires
	wire [31:0] sum_1_2;
	wire [31:0] sum_0_3;
	wire [31:0] sum_1_0;
	wire [31:0] sum_2_1;
	
	assign sum_1_2 = x3 + x2;
	assign out0 = x0 ^ {sum_1_2[24:0], sum_1_2[31:25]}; 
	assign sum_0_3 = out0 + x3;
	assign out1 = x1 ^ {sum_0_3[22:0], sum_0_3[31:23]};
	assign sum_1_0 = out1 + out0;
	assign out2 = x2 ^ {sum_1_0[18:0], sum_1_0[31:19]};
	assign sum_2_1 = out2 + out1;
	assign out3 = x3 ^ {sum_2_1[13:0], sum_2_1[31:14]};
	
endmodule
