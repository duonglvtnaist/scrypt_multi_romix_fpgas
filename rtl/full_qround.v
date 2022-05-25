module full_qround(
		input	wire 	[31:0]	x0		,
		input	wire 	[31:0]	x1		,
		input	wire 	[31:0]	x2		,
		input	wire 	[31:0]	x3		,
		input	wire 	[31:0]	x4		,
		input	wire 	[31:0]	x5		,
		input	wire 	[31:0]	x6		,
		input	wire 	[31:0]	x7		,
		input	wire 	[31:0]	x8		,
		input	wire 	[31:0]	x9		,
		input	wire 	[31:0]	x10		,
		input	wire 	[31:0]	x11		,
		input	wire 	[31:0]	x12		,
		input	wire 	[31:0]	x13		,
		input	wire 	[31:0]	x14		,
		input	wire 	[31:0]	x15		,		
		output	wire 	[31:0]	out0	,
		output	wire 	[31:0]	out1	,
		output	wire 	[31:0]	out2	,
		output	wire 	[31:0]	out3	,
		output	wire 	[31:0]	out4	,
		output	wire 	[31:0]	out5	,
		output	wire 	[31:0]	out6	,
		output	wire 	[31:0]	out7	,
		output	wire 	[31:0]	out8	,
		output	wire 	[31:0]	out9	,
		output	wire 	[31:0]	out10	,
		output	wire 	[31:0]	out11	,
		output	wire 	[31:0]	out12	,
		output	wire 	[31:0]	out13	,
		output	wire 	[31:0]	out14	,
		output	wire 	[31:0]	out15
);
	q_round_for_salsa_20_8 q_round_1(
									.x0(x0),
									.x1(x1),
									.x2(x2),
									.x3(x3),
									.out0(out0),
									.out1(out1),
									.out2(out2),
									.out3(out3)
	);
	q_round_for_salsa_20_8 q_round_2(
									.x0(x4),
									.x1(x5),
									.x2(x6),
									.x3(x7),
									.out0(out4),
									.out1(out5),
									.out2(out6),
									.out3(out7)
	);
	q_round_for_salsa_20_8 q_round_3(
									.x0(x8),
									.x1(x9),
									.x2(x10),
									.x3(x11),
									.out0(out8),
									.out1(out9),
									.out2(out10),
									.out3(out11)
	);
	q_round_for_salsa_20_8 q_round_4(
									.x0(x12),
									.x1(x13),
									.x2(x14),
									.x3(x15),
									.out0(out12),
									.out1(out13),
									.out2(out14),
									.out3(out15)
	);
endmodule