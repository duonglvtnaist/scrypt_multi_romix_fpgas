// Blockmix Datapath
module blockmix_dp (
		input 	wire	clk			,	// clock signal
		input	wire	reset_n		,   // reset negative signal
		// inputs 	
		input	wire [31:0]	in0 		,
		input	wire [31:0]	in1 		,
		input	wire [31:0]	in2 		,
		input	wire [31:0]	in3 		,
		input	wire [31:0]	in4 		,
		input	wire [31:0]	in5 		,
		input	wire [31:0]	in6 		,
		input	wire [31:0]	in7 		,
		input	wire [31:0]	in8 		,
		input	wire [31:0]	in9 		,
		input	wire [31:0]	in10		,
		input	wire [31:0]	in11		,
		input	wire [31:0]	in12		,
		input	wire [31:0]	in13		,
		input	wire [31:0]	in14		,
		input	wire [31:0]	in15		,
		input	wire [31:0]	in16		,
		input	wire [31:0]	in17		,
		input	wire [31:0]	in18		,
		input	wire [31:0]	in19		,
		input	wire [31:0]	in20		,
		input	wire [31:0]	in21		,
		input	wire [31:0]	in22		,
		input	wire [31:0]	in23		,
		input	wire [31:0]	in24		,
		input	wire [31:0]	in25		,
		input	wire [31:0]	in26		,
		input	wire [31:0]	in27		,
		input	wire [31:0]	in28		,
		input	wire [31:0]	in29		,
		input	wire [31:0]	in30		,
		input	wire [31:0]	in31		,
		// input control signals from controller
		input	wire	valid			,	// have result
		input	wire	sel_in			,	// select input for salsa 20/8 block -> loop index [0,1]
		input	wire	in_en			,	// allow to save input data
		input 	wire	xor_en			,	// allow to calculate xor for the loop
		input 	wire	salsa_init		,	// allow running salsa 20/8 block
		input 	wire	sum_en			,	// allow to calculate sum for the loop
		input	wire	update_high		, 	// allow to update high-bit output
		input	wire	update_low		, 	// allow to update low-bit output
		// outputs
		output	wire [31:0]	out0 		,
		output	wire [31:0]	out1 		,
		output	wire [31:0]	out2 		,
		output	wire [31:0]	out3 		,
		output	wire [31:0]	out4 		,
		output	wire [31:0]	out5 		,
		output	wire [31:0]	out6 		,
		output	wire [31:0]	out7 		,
		output	wire [31:0]	out8 		,
		output	wire [31:0]	out9 		,
		output	wire [31:0]	out10		,
		output	wire [31:0]	out11		,
		output	wire [31:0]	out12		,
		output	wire [31:0]	out13		,
		output	wire [31:0]	out14		,
		output	wire [31:0]	out15		,		
		output	wire [31:0]	out16		,
		output	wire [31:0]	out17		,
		output	wire [31:0]	out18		,
		output	wire [31:0]	out19		,
		output	wire [31:0]	out20		,
		output	wire [31:0]	out21		,
		output	wire [31:0]	out22		,
		output	wire [31:0]	out23		,
		output	wire [31:0]	out24		,
		output	wire [31:0]	out25		,
		output	wire [31:0]	out26		,
		output	wire [31:0]	out27		,
		output	wire [31:0]	out28		,
		output	wire [31:0]	out29		,
		output	wire [31:0]	out30		,
		output	wire [31:0]	out31		,
		
		// output signal
		
		output 	wire	salsa_valid		// salsa 20/8 have result
);

	// input registers
	reg [31:0]	in0_reg ;
	reg [31:0]	in1_reg ;
	reg [31:0]	in2_reg ;
	reg [31:0]	in3_reg ;
	reg [31:0]	in4_reg ;
	reg [31:0]	in5_reg ;
	reg [31:0]	in6_reg ;
	reg [31:0]	in7_reg ;
	reg [31:0]	in8_reg ;
	reg [31:0]	in9_reg ;
	reg [31:0]	in10_reg;
	reg [31:0]	in11_reg;
	reg [31:0]	in12_reg;
	reg [31:0]	in13_reg;
	reg [31:0]	in14_reg;
	reg [31:0]	in15_reg;
	reg [31:0]	in16_reg;
	reg [31:0]	in17_reg;
	reg [31:0]	in18_reg;
	reg [31:0]	in19_reg;
	reg [31:0]	in20_reg;
	reg [31:0]	in21_reg;
	reg [31:0]	in22_reg;
	reg [31:0]	in23_reg;
	reg [31:0]	in24_reg;
	reg [31:0]	in25_reg;
	reg [31:0]	in26_reg;
	reg [31:0]	in27_reg;
	reg [31:0]	in28_reg;
	reg [31:0]	in29_reg;
	reg [31:0]	in30_reg;
	reg [31:0]	in31_reg;
	
	// input high-bit wire
	
	wire [31:0]	in_high_0_wire ;
	wire [31:0]	in_high_1_wire ;
	wire [31:0]	in_high_2_wire ;
	wire [31:0]	in_high_3_wire ;
	wire [31:0]	in_high_4_wire ;
	wire [31:0]	in_high_5_wire ;
	wire [31:0]	in_high_6_wire ;
	wire [31:0]	in_high_7_wire ;
	wire [31:0]	in_high_8_wire ;
	wire [31:0]	in_high_9_wire ;
	wire [31:0]	in_high_10_wire;
	wire [31:0]	in_high_11_wire;
	wire [31:0]	in_high_12_wire;
	wire [31:0]	in_high_13_wire;
	wire [31:0]	in_high_14_wire;
	wire [31:0]	in_high_15_wire;
	
	// input low-bit wire
	
	wire [31:0]	in_low_0_wire ;
	wire [31:0]	in_low_1_wire ;
	wire [31:0]	in_low_2_wire ;
	wire [31:0]	in_low_3_wire ;
	wire [31:0]	in_low_4_wire ;
	wire [31:0]	in_low_5_wire ;
	wire [31:0]	in_low_6_wire ;
	wire [31:0]	in_low_7_wire ;
	wire [31:0]	in_low_8_wire ;
	wire [31:0]	in_low_9_wire ;
	wire [31:0]	in_low_10_wire;
	wire [31:0]	in_low_11_wire;
	wire [31:0]	in_low_12_wire;
	wire [31:0]	in_low_13_wire;
	wire [31:0]	in_low_14_wire;
	wire [31:0]	in_low_15_wire;
	
	// input a xor wires (out of mux "sel_xor")
	
	wire [31:0]	in_xor_0_wire ;
	wire [31:0]	in_xor_1_wire ;	
	wire [31:0]	in_xor_2_wire ;	
	wire [31:0]	in_xor_3_wire ;	
	wire [31:0]	in_xor_4_wire ;	
	wire [31:0]	in_xor_5_wire ;	
	wire [31:0]	in_xor_6_wire ;	
	wire [31:0]	in_xor_7_wire ;	
	wire [31:0]	in_xor_8_wire ;	
	wire [31:0]	in_xor_9_wire ;	
	wire [31:0]	in_xor_10_wire;
	wire [31:0]	in_xor_11_wire;
	wire [31:0]	in_xor_12_wire;
	wire [31:0]	in_xor_13_wire;
	wire [31:0]	in_xor_14_wire;
	wire [31:0]	in_xor_15_wire;
	
	// xor result registers
	
	reg [31:0]	xor_0_reg ;
	reg [31:0]	xor_1_reg ;
	reg [31:0]	xor_2_reg ;
	reg [31:0]	xor_3_reg ;
	reg [31:0]	xor_4_reg ;
	reg [31:0]	xor_5_reg ;
	reg [31:0]	xor_6_reg ;
	reg [31:0]	xor_7_reg ;
	reg [31:0]	xor_8_reg ;
	reg [31:0]	xor_9_reg ;
	reg [31:0]	xor_10_reg;
	reg [31:0]	xor_11_reg;
	reg [31:0]	xor_12_reg;
	reg [31:0]	xor_13_reg;
	reg [31:0]	xor_14_reg;
	reg [31:0]	xor_15_reg;
	
	
	// xor wires
	
	wire [31:0]	xor_0_wire ;
	wire [31:0]	xor_1_wire ;
	wire [31:0]	xor_2_wire ;
	wire [31:0]	xor_3_wire ;
	wire [31:0]	xor_4_wire ;
	wire [31:0]	xor_5_wire ;
	wire [31:0]	xor_6_wire ;
	wire [31:0]	xor_7_wire ;
	wire [31:0]	xor_8_wire ;
	wire [31:0]	xor_9_wire ;
	wire [31:0]	xor_10_wire;
	wire [31:0]	xor_11_wire;
	wire [31:0]	xor_12_wire;
	wire [31:0]	xor_13_wire;
	wire [31:0]	xor_14_wire;
	wire [31:0]	xor_15_wire;
	
	// calculate xor wires
	
	wire [31:0]	cal_xor_0_wire ;
	wire [31:0]	cal_xor_1_wire ;
	wire [31:0]	cal_xor_2_wire ;
	wire [31:0]	cal_xor_3_wire ;
	wire [31:0]	cal_xor_4_wire ;
	wire [31:0]	cal_xor_5_wire ;
	wire [31:0]	cal_xor_6_wire ;
	wire [31:0]	cal_xor_7_wire ;
	wire [31:0]	cal_xor_8_wire ;
	wire [31:0]	cal_xor_9_wire ;
	wire [31:0]	cal_xor_10_wire;
	wire [31:0]	cal_xor_11_wire;
	wire [31:0]	cal_xor_12_wire;
	wire [31:0]	cal_xor_13_wire;
	wire [31:0]	cal_xor_14_wire;
	wire [31:0]	cal_xor_15_wire;
	
	// sum result registers
	
	reg [31:0]	sum_0_reg ;
	reg [31:0]	sum_1_reg ;
	reg [31:0]	sum_2_reg ;
	reg [31:0]	sum_3_reg ;
	reg [31:0]	sum_4_reg ;
	reg [31:0]	sum_5_reg ;
	reg [31:0]	sum_6_reg ;
	reg [31:0]	sum_7_reg ;
	reg [31:0]	sum_8_reg ;
	reg [31:0]	sum_9_reg ;
	reg [31:0]	sum_10_reg;
	reg [31:0]	sum_11_reg;
	reg [31:0]	sum_12_reg;
	reg [31:0]	sum_13_reg;
	reg [31:0]	sum_14_reg;
	reg [31:0]	sum_15_reg;

	// sum result wires
	
	wire [31:0]	sum_0_wire ;
	wire [31:0]	sum_1_wire ;
	wire [31:0]	sum_2_wire ;
	wire [31:0]	sum_3_wire ;
	wire [31:0]	sum_4_wire ;
	wire [31:0]	sum_5_wire ;
	wire [31:0]	sum_6_wire ;
	wire [31:0]	sum_7_wire ;
	wire [31:0]	sum_8_wire ;
	wire [31:0]	sum_9_wire ;
	wire [31:0]	sum_10_wire;
	wire [31:0]	sum_11_wire;
	wire [31:0]	sum_12_wire;
	wire [31:0]	sum_13_wire;
	wire [31:0]	sum_14_wire;
	wire [31:0]	sum_15_wire;
	
	// calculate sum wires
	
	wire [31:0]	cal_sum_0_wire ;
	wire [31:0]	cal_sum_1_wire ;
	wire [31:0]	cal_sum_2_wire ;
	wire [31:0]	cal_sum_3_wire ;
	wire [31:0]	cal_sum_4_wire ;
	wire [31:0]	cal_sum_5_wire ;
	wire [31:0]	cal_sum_6_wire ;
	wire [31:0]	cal_sum_7_wire ;
	wire [31:0]	cal_sum_8_wire ;
	wire [31:0]	cal_sum_9_wire ;
	wire [31:0]	cal_sum_10_wire;
	wire [31:0]	cal_sum_11_wire;
	wire [31:0]	cal_sum_12_wire;
	wire [31:0]	cal_sum_13_wire;
	wire [31:0]	cal_sum_14_wire;
	wire [31:0]	cal_sum_15_wire;
	
	// salsa out registers
	
	reg [31:0]	salsa_out_0_reg ;
	reg [31:0]	salsa_out_1_reg ;
	reg [31:0]	salsa_out_2_reg ;
	reg [31:0]	salsa_out_3_reg ;
	reg [31:0]	salsa_out_4_reg ;
	reg [31:0]	salsa_out_5_reg ;
	reg [31:0]	salsa_out_6_reg ;
	reg [31:0]	salsa_out_7_reg ;
	reg [31:0]	salsa_out_8_reg ;
	reg [31:0]	salsa_out_9_reg ;
	reg [31:0]	salsa_out_10_reg;
	reg [31:0]	salsa_out_11_reg;
	reg [31:0]	salsa_out_12_reg;
	reg [31:0]	salsa_out_13_reg;
	reg [31:0]	salsa_out_14_reg;
	reg [31:0]	salsa_out_15_reg;
	
	// salsa out wires
	
	wire [31:0]	salsa_out_0_wire ;
	wire [31:0]	salsa_out_1_wire ;
	wire [31:0]	salsa_out_2_wire ;
	wire [31:0]	salsa_out_3_wire ;
	wire [31:0]	salsa_out_4_wire ;
	wire [31:0]	salsa_out_5_wire ;
	wire [31:0]	salsa_out_6_wire ;
	wire [31:0]	salsa_out_7_wire ;
	wire [31:0]	salsa_out_8_wire ;
	wire [31:0]	salsa_out_9_wire ;
	wire [31:0]	salsa_out_10_wire;
	wire [31:0]	salsa_out_11_wire;
	wire [31:0]	salsa_out_12_wire;
	wire [31:0]	salsa_out_13_wire;
	wire [31:0]	salsa_out_14_wire;
	wire [31:0]	salsa_out_15_wire;
	
	// calculate salsa out wires
	
	wire [31:0]	cal_salsa_out_0_wire ;
	wire [31:0]	cal_salsa_out_1_wire ;
	wire [31:0]	cal_salsa_out_2_wire ;
	wire [31:0]	cal_salsa_out_3_wire ;
	wire [31:0]	cal_salsa_out_4_wire ;
	wire [31:0]	cal_salsa_out_5_wire ;
	wire [31:0]	cal_salsa_out_6_wire ;
	wire [31:0]	cal_salsa_out_7_wire ;
	wire [31:0]	cal_salsa_out_8_wire ;
	wire [31:0]	cal_salsa_out_9_wire ;
	wire [31:0]	cal_salsa_out_10_wire;
	wire [31:0]	cal_salsa_out_11_wire;
	wire [31:0]	cal_salsa_out_12_wire;
	wire [31:0]	cal_salsa_out_13_wire;
	wire [31:0]	cal_salsa_out_14_wire;
	wire [31:0]	cal_salsa_out_15_wire;
	
	// output wires
	
	wire [31:0]	out0_wire ;
	wire [31:0]	out1_wire ;
	wire [31:0]	out2_wire ;
	wire [31:0]	out3_wire ;
	wire [31:0]	out4_wire ;
	wire [31:0]	out5_wire ;
	wire [31:0]	out6_wire ;
	wire [31:0]	out7_wire ;
	wire [31:0]	out8_wire ;
	wire [31:0]	out9_wire ;
	wire [31:0]	out10_wire;
	wire [31:0]	out11_wire;
	wire [31:0]	out12_wire;
	wire [31:0]	out13_wire;
	wire [31:0]	out14_wire;
	wire [31:0]	out15_wire;
	wire [31:0]	out16_wire;
	wire [31:0]	out17_wire;
	wire [31:0]	out18_wire;
	wire [31:0]	out19_wire;
	wire [31:0]	out20_wire;
	wire [31:0]	out21_wire;
	wire [31:0]	out22_wire;
	wire [31:0]	out23_wire;
	wire [31:0]	out24_wire;
	wire [31:0]	out25_wire;
	wire [31:0]	out26_wire;
	wire [31:0]	out27_wire;
	wire [31:0]	out28_wire;
	wire [31:0]	out29_wire;
	wire [31:0]	out30_wire;
	wire [31:0]	out31_wire;
	// output registers
	
	reg [31:0]	out0_reg ;
	reg [31:0]	out1_reg ;
	reg [31:0]	out2_reg ;
	reg [31:0]	out3_reg ;
	reg [31:0]	out4_reg ;
	reg [31:0]	out5_reg ;
	reg [31:0]	out6_reg ;
	reg [31:0]	out7_reg ;
	reg [31:0]	out8_reg ;
	reg [31:0]	out9_reg ;
	reg [31:0]	out10_reg;
	reg [31:0]	out11_reg;
	reg [31:0]	out12_reg;
	reg [31:0]	out13_reg;
	reg [31:0]	out14_reg;
	reg [31:0]	out15_reg;
	reg [31:0]	out16_reg;
	reg [31:0]	out17_reg;
	reg [31:0]	out18_reg;
	reg [31:0]	out19_reg;
	reg [31:0]	out20_reg;
	reg [31:0]	out21_reg;
	reg [31:0]	out22_reg;
	reg [31:0]	out23_reg;
	reg [31:0]	out24_reg;
	reg [31:0]	out25_reg;
	reg [31:0]	out26_reg;
	reg [31:0]	out27_reg;
	reg [31:0]	out28_reg;
	reg [31:0]	out29_reg;
	reg [31:0]	out30_reg;
	reg [31:0]	out31_reg;
	// Assign wires
	
	// high-bit input wires
	assign in_high_0_wire 	= 	in0_reg ;
	assign in_high_1_wire 	= 	in1_reg ;
	assign in_high_2_wire 	= 	in2_reg ;
	assign in_high_3_wire 	= 	in3_reg ;
	assign in_high_4_wire 	= 	in4_reg ;
	assign in_high_5_wire 	= 	in5_reg ;
	assign in_high_6_wire 	= 	in6_reg ;
	assign in_high_7_wire 	= 	in7_reg ;
	assign in_high_8_wire 	= 	in8_reg ;
	assign in_high_9_wire 	= 	in9_reg ;
	assign in_high_10_wire	= 	in10_reg;
	assign in_high_11_wire	= 	in11_reg;
	assign in_high_12_wire	= 	in12_reg;
	assign in_high_13_wire	= 	in13_reg;
	assign in_high_14_wire	= 	in14_reg;
	assign in_high_15_wire	= 	in15_reg;
	
	// low-bit input wires
	assign in_low_0_wire 	= 	in16_reg;
	assign in_low_1_wire 	= 	in17_reg;
	assign in_low_2_wire 	= 	in18_reg;
	assign in_low_3_wire 	= 	in19_reg;
	assign in_low_4_wire 	= 	in20_reg;
	assign in_low_5_wire 	= 	in21_reg;
	assign in_low_6_wire 	= 	in22_reg;
	assign in_low_7_wire 	= 	in23_reg;
	assign in_low_8_wire 	= 	in24_reg;
	assign in_low_9_wire 	= 	in25_reg;
	assign in_low_10_wire	= 	in26_reg;
	assign in_low_11_wire	= 	in27_reg;
	assign in_low_12_wire	= 	in28_reg;
	assign in_low_13_wire	= 	in29_reg;
	assign in_low_14_wire	= 	in30_reg;
	assign in_low_15_wire	= 	in31_reg;
	
	// xor wires
	
	assign xor_0_wire  = xor_0_reg ;
	assign xor_1_wire  = xor_1_reg ;
	assign xor_2_wire  = xor_2_reg ;
	assign xor_3_wire  = xor_3_reg ;
	assign xor_4_wire  = xor_4_reg ;
	assign xor_5_wire  = xor_5_reg ;
	assign xor_6_wire  = xor_6_reg ;
	assign xor_7_wire  = xor_7_reg ;
	assign xor_8_wire  = xor_8_reg ;
	assign xor_9_wire  = xor_9_reg ;
	assign xor_10_wire = xor_10_reg;
	assign xor_11_wire = xor_11_reg;
	assign xor_12_wire = xor_12_reg;
	assign xor_13_wire = xor_13_reg;
	assign xor_14_wire = xor_14_reg;
	assign xor_15_wire = xor_15_reg;
	
	// calculate xor wires -> output of "sel_in_xor" mux ^ low-bit input 
	
	assign cal_xor_0_wire  = in_xor_0_wire  ^ in_low_0_wire ;
	assign cal_xor_1_wire  = in_xor_1_wire  ^ in_low_1_wire ;
	assign cal_xor_2_wire  = in_xor_2_wire  ^ in_low_2_wire ;
	assign cal_xor_3_wire  = in_xor_3_wire  ^ in_low_3_wire ;
	assign cal_xor_4_wire  = in_xor_4_wire  ^ in_low_4_wire ;
	assign cal_xor_5_wire  = in_xor_5_wire  ^ in_low_5_wire ;
	assign cal_xor_6_wire  = in_xor_6_wire  ^ in_low_6_wire ;
	assign cal_xor_7_wire  = in_xor_7_wire  ^ in_low_7_wire ;
	assign cal_xor_8_wire  = in_xor_8_wire  ^ in_low_8_wire ;
	assign cal_xor_9_wire  = in_xor_9_wire  ^ in_low_9_wire ;
	assign cal_xor_10_wire = in_xor_10_wire ^ in_low_10_wire;
	assign cal_xor_11_wire = in_xor_11_wire ^ in_low_11_wire;
	assign cal_xor_12_wire = in_xor_12_wire ^ in_low_12_wire;
	assign cal_xor_13_wire = in_xor_13_wire ^ in_low_13_wire;
	assign cal_xor_14_wire = in_xor_14_wire ^ in_low_14_wire;
	assign cal_xor_15_wire = in_xor_15_wire ^ in_low_15_wire;
	
	// sum wires
	
	assign sum_0_wire  = sum_0_reg ;
	assign sum_1_wire  = sum_1_reg ;
	assign sum_2_wire  = sum_2_reg ;
	assign sum_3_wire  = sum_3_reg ;
	assign sum_4_wire  = sum_4_reg ;
	assign sum_5_wire  = sum_5_reg ;
	assign sum_6_wire  = sum_6_reg ;
	assign sum_7_wire  = sum_7_reg ;
	assign sum_8_wire  = sum_8_reg ;
	assign sum_9_wire  = sum_9_reg ;
	assign sum_10_wire = sum_10_reg;
	assign sum_11_wire = sum_11_reg;
	assign sum_12_wire = sum_12_reg;
	assign sum_13_wire = sum_13_reg;
	assign sum_14_wire = sum_14_reg;
	assign sum_15_wire = sum_15_reg;
	
	// calculate sum wires
	
	assign cal_sum_0_wire  = xor_0_wire  + salsa_out_0_wire ;
	assign cal_sum_1_wire  = xor_1_wire  + salsa_out_1_wire ;
	assign cal_sum_2_wire  = xor_2_wire  + salsa_out_2_wire ;
	assign cal_sum_3_wire  = xor_3_wire  + salsa_out_3_wire ;
	assign cal_sum_4_wire  = xor_4_wire  + salsa_out_4_wire ;
	assign cal_sum_5_wire  = xor_5_wire  + salsa_out_5_wire ;
	assign cal_sum_6_wire  = xor_6_wire  + salsa_out_6_wire ;
	assign cal_sum_7_wire  = xor_7_wire  + salsa_out_7_wire ;
	assign cal_sum_8_wire  = xor_8_wire  + salsa_out_8_wire ;
	assign cal_sum_9_wire  = xor_9_wire  + salsa_out_9_wire ;
	assign cal_sum_10_wire = xor_10_wire + salsa_out_10_wire;
	assign cal_sum_11_wire = xor_11_wire + salsa_out_11_wire;
	assign cal_sum_12_wire = xor_12_wire + salsa_out_12_wire;
	assign cal_sum_13_wire = xor_13_wire + salsa_out_13_wire;
	assign cal_sum_14_wire = xor_14_wire + salsa_out_14_wire;
	assign cal_sum_15_wire = xor_15_wire + salsa_out_15_wire;
	
	// salsa out wires
	
	assign salsa_out_0_wire  = salsa_out_0_reg ;
	assign salsa_out_1_wire  = salsa_out_1_reg ;
	assign salsa_out_2_wire  = salsa_out_2_reg ;
	assign salsa_out_3_wire  = salsa_out_3_reg ;
	assign salsa_out_4_wire  = salsa_out_4_reg ;
	assign salsa_out_5_wire  = salsa_out_5_reg ;
	assign salsa_out_6_wire  = salsa_out_6_reg ;
	assign salsa_out_7_wire  = salsa_out_7_reg ;
	assign salsa_out_8_wire  = salsa_out_8_reg ;
	assign salsa_out_9_wire  = salsa_out_9_reg ;
	assign salsa_out_10_wire = salsa_out_10_reg;
	assign salsa_out_11_wire = salsa_out_11_reg;
	assign salsa_out_12_wire = salsa_out_12_reg;
	assign salsa_out_13_wire = salsa_out_13_reg;
	assign salsa_out_14_wire = salsa_out_14_reg;
	assign salsa_out_15_wire = salsa_out_15_reg;
	
	// output wires
	
	assign out0  = out0_reg  	;
	assign out1  = out1_reg  	;
	assign out2  = out2_reg  	;
	assign out3  = out3_reg  	;
	assign out4  = out4_reg  	;
	assign out5  = out5_reg  	;
	assign out6  = out6_reg  	;
	assign out7  = out7_reg  	;
	assign out8  = out8_reg  	;
	assign out9  = out9_reg  	;
	assign out10 = out10_reg 	;
	assign out11 = out11_reg 	;
	assign out12 = out12_reg 	;
	assign out13 = out13_reg 	;
	assign out14 = out14_reg 	;
	assign out15 = out15_reg 	;
	assign out16 = out16_reg 	;
	assign out17 = out17_reg 	;
	assign out18 = out18_reg 	;
	assign out19 = out19_reg 	;
	assign out20 = out20_reg 	;
	assign out21 = out21_reg 	;
	assign out22 = out22_reg 	;
	assign out23 = out23_reg 	;
	assign out24 = out24_reg 	;
	assign out25 = out25_reg 	;
	assign out26 = out26_reg 	;
	assign out27 = out27_reg 	;
	assign out28 = out28_reg 	;
	assign out29 = out29_reg 	;
	assign out30 = out30_reg 	;
	assign out31 = out31_reg 	;
	
	
	assign out0_wire  = out0_reg	; 
	assign out1_wire  = out1_reg	; 
	assign out2_wire  = out2_reg	; 
	assign out3_wire  = out3_reg	; 
	assign out4_wire  = out4_reg	; 
	assign out5_wire  = out5_reg	; 
	assign out6_wire  = out6_reg	; 
	assign out7_wire  = out7_reg	; 
	assign out8_wire  = out8_reg	; 
	assign out9_wire  = out9_reg	; 
	assign out10_wire = out10_reg	;
	assign out11_wire = out11_reg	;
	assign out12_wire = out12_reg	;
	assign out13_wire = out13_reg	;
	assign out14_wire = out14_reg	;
	assign out15_wire = out15_reg	;
	assign out16_wire = out16_reg	;
	assign out17_wire = out17_reg	;
	assign out18_wire = out18_reg	;
	assign out19_wire = out19_reg	;
	assign out20_wire = out20_reg	;
	assign out21_wire = out21_reg	;
	assign out22_wire = out22_reg	;
	assign out23_wire = out23_reg	;
	assign out24_wire = out24_reg	;
	assign out25_wire = out25_reg	;
	assign out26_wire = out26_reg	;
	assign out27_wire = out27_reg	;
	assign out28_wire = out28_reg	;
	assign out29_wire = out29_reg	;
	assign out30_wire = out30_reg	;
	assign out31_wire = out31_reg	;


	// Select a input source for xor operator (xor_out = a ^ b)
	mux21#(32) sel_in_xor_0			(in_high_0_wire , sum_0_wire , sel_in, in_xor_0_wire );
	mux21#(32) sel_in_xor_1			(in_high_1_wire , sum_1_wire , sel_in, in_xor_1_wire );
	mux21#(32) sel_in_xor_2			(in_high_2_wire , sum_2_wire , sel_in, in_xor_2_wire );
	mux21#(32) sel_in_xor_3			(in_high_3_wire , sum_3_wire , sel_in, in_xor_3_wire );	
	mux21#(32) sel_in_xor_4			(in_high_4_wire , sum_4_wire , sel_in, in_xor_4_wire );
	mux21#(32) sel_in_xor_5			(in_high_5_wire , sum_5_wire , sel_in, in_xor_5_wire );
	mux21#(32) sel_in_xor_6			(in_high_6_wire , sum_6_wire , sel_in, in_xor_6_wire );
	mux21#(32) sel_in_xor_7			(in_high_7_wire , sum_7_wire , sel_in, in_xor_7_wire );
	mux21#(32) sel_in_xor_8			(in_high_8_wire , sum_8_wire , sel_in, in_xor_8_wire );
	mux21#(32) sel_in_xor_9			(in_high_9_wire , sum_9_wire , sel_in, in_xor_9_wire );
	mux21#(32) sel_in_xor_10		(in_high_10_wire, sum_10_wire, sel_in, in_xor_10_wire);
	mux21#(32) sel_in_xor_11		(in_high_11_wire, sum_11_wire, sel_in, in_xor_11_wire);	
	mux21#(32) sel_in_xor_12		(in_high_12_wire, sum_12_wire, sel_in, in_xor_12_wire);
	mux21#(32) sel_in_xor_13		(in_high_13_wire, sum_13_wire, sel_in, in_xor_13_wire);
	mux21#(32) sel_in_xor_14		(in_high_14_wire, sum_14_wire, sel_in, in_xor_14_wire);
	mux21#(32) sel_in_xor_15		(in_high_15_wire, sum_15_wire, sel_in, in_xor_15_wire);

	// Salsa 20/8
	
	salsa_20_8 salsa_20_8 (
		.clk	(clk)					,
		.init	(salsa_init)			,
		.reset_n(reset_n)				,
		.x0		(xor_0_wire )			,
		.x1		(xor_1_wire )			,
		.x2		(xor_2_wire )			,
		.x3		(xor_3_wire )			,
		.x4		(xor_4_wire )			,
		.x5		(xor_5_wire )			,
		.x6		(xor_6_wire )			,
		.x7		(xor_7_wire )			,
		.x8		(xor_8_wire )			,
		.x9		(xor_9_wire )			,
		.x10	(xor_10_wire)			,
		.x11	(xor_11_wire)			,
		.x12	(xor_12_wire)			,
		.x13	(xor_13_wire)			,
		.x14	(xor_14_wire)			,
		.x15	(xor_15_wire)			,	
		.out0	(cal_salsa_out_0_wire )	,
		.out1	(cal_salsa_out_1_wire )	,
		.out2	(cal_salsa_out_2_wire )	,
		.out3	(cal_salsa_out_3_wire )	,
		.out4	(cal_salsa_out_4_wire )	,
		.out5	(cal_salsa_out_5_wire )	,
		.out6	(cal_salsa_out_6_wire )	,
		.out7	(cal_salsa_out_7_wire )	,
		.out8	(cal_salsa_out_8_wire )	,
		.out9	(cal_salsa_out_9_wire )	,
		.out10	(cal_salsa_out_10_wire)	,
		.out11	(cal_salsa_out_11_wire)	,
		.out12	(cal_salsa_out_12_wire)	,
		.out13	(cal_salsa_out_13_wire)	,
		.out14	(cal_salsa_out_14_wire)	,
		.out15	(cal_salsa_out_15_wire)	,
		.valid	(salsa_valid)
	);

	always@(posedge clk or negedge reset_n)
	begin : store_in_data
		if(reset_n == 1'b0) begin
			in0_reg  <= 32'd0;
			in1_reg  <= 32'd0;
			in2_reg  <= 32'd0;
			in3_reg  <= 32'd0;
			in4_reg  <= 32'd0;
			in5_reg  <= 32'd0;
			in6_reg  <= 32'd0;
			in7_reg  <= 32'd0;
			in8_reg  <= 32'd0;
			in9_reg  <= 32'd0;
			in10_reg <= 32'd0;
			in11_reg <= 32'd0;
			in12_reg <= 32'd0;
			in13_reg <= 32'd0;
			in14_reg <= 32'd0;
			in15_reg <= 32'd0;
			in16_reg <= 32'd0;
			in17_reg <= 32'd0;
			in18_reg <= 32'd0;
			in19_reg <= 32'd0;
			in20_reg <= 32'd0;
			in21_reg <= 32'd0;
			in22_reg <= 32'd0;
			in23_reg <= 32'd0;
			in24_reg <= 32'd0;
			in25_reg <= 32'd0;
			in26_reg <= 32'd0;
			in27_reg <= 32'd0;
			in28_reg <= 32'd0;
			in29_reg <= 32'd0;
			in30_reg <= 32'd0;
			in31_reg <= 32'd0;
		end
		else begin
			if(in_en == 1'b1) begin
				in0_reg  <= in0 ;
				in1_reg  <= in1 ;
				in2_reg  <= in2 ;
				in3_reg  <= in3 ;
				in4_reg  <= in4 ;
				in5_reg  <= in5 ;
				in6_reg  <= in6 ;
				in7_reg  <= in7 ;
				in8_reg  <= in8 ;
				in9_reg  <= in9 ;
				in10_reg <= in10;
				in11_reg <= in11;
				in12_reg <= in12;
				in13_reg <= in13;
				in14_reg <= in14;
				in15_reg <= in15;
				in16_reg <= in16;
				in17_reg <= in17;
				in18_reg <= in18;
				in19_reg <= in19;
				in20_reg <= in20;
				in21_reg <= in21;
				in22_reg <= in22;
				in23_reg <= in23;
				in24_reg <= in24;
				in25_reg <= in25;
				in26_reg <= in26;
				in27_reg <= in27;
				in28_reg <= in28;
				in29_reg <= in29;
				in30_reg <= in30;
				in31_reg <= in31;
			end
			else begin
				in0_reg  <= in_high_0_wire 	;
				in1_reg  <= in_high_1_wire 	;
				in2_reg  <= in_high_2_wire 	;
				in3_reg  <= in_high_3_wire 	;
				in4_reg  <= in_high_4_wire 	;
				in5_reg  <= in_high_5_wire 	;
				in6_reg  <= in_high_6_wire 	;
				in7_reg  <= in_high_7_wire 	;
				in8_reg  <= in_high_8_wire 	;
				in9_reg  <= in_high_9_wire 	;
				in10_reg <= in_high_10_wire	;
				in11_reg <= in_high_11_wire	;
				in12_reg <= in_high_12_wire	;
				in13_reg <= in_high_13_wire	;
				in14_reg <= in_high_14_wire	;
				in15_reg <= in_high_15_wire	;
				in16_reg <= in_low_0_wire  	;
				in17_reg <= in_low_1_wire  	;
				in18_reg <= in_low_2_wire  	;
				in19_reg <= in_low_3_wire  	;
				in20_reg <= in_low_4_wire  	;
				in21_reg <= in_low_5_wire  	;
				in22_reg <= in_low_6_wire  	;
				in23_reg <= in_low_7_wire  	;
				in24_reg <= in_low_8_wire  	;
				in25_reg <= in_low_9_wire  	;
				in26_reg <= in_low_10_wire 	;
				in27_reg <= in_low_11_wire 	;
				in28_reg <= in_low_12_wire 	;
				in29_reg <= in_low_13_wire 	;
				in30_reg <= in_low_14_wire 	;
				in31_reg <= in_low_15_wire 	;
			end
		end
	end
	always@(posedge clk or negedge reset_n)
	begin : store_xor_output
		if(reset_n == 1'b0) begin
			xor_0_reg  <= 32'd0;
			xor_1_reg  <= 32'd0;
			xor_2_reg  <= 32'd0;
			xor_3_reg  <= 32'd0;
			xor_4_reg  <= 32'd0;
			xor_5_reg  <= 32'd0;
			xor_6_reg  <= 32'd0;
			xor_7_reg  <= 32'd0;
			xor_8_reg  <= 32'd0;
			xor_9_reg  <= 32'd0;
			xor_10_reg <= 32'd0;
			xor_11_reg <= 32'd0;
			xor_12_reg <= 32'd0;
			xor_13_reg <= 32'd0;
			xor_14_reg <= 32'd0;
			xor_15_reg <= 32'd0;
		end
		else begin
			if(xor_en == 1'b1) begin
				xor_0_reg  <= cal_xor_0_wire ;
				xor_1_reg  <= cal_xor_1_wire ;
				xor_2_reg  <= cal_xor_2_wire ;
				xor_3_reg  <= cal_xor_3_wire ;
				xor_4_reg  <= cal_xor_4_wire ;
				xor_5_reg  <= cal_xor_5_wire ;
				xor_6_reg  <= cal_xor_6_wire ;
				xor_7_reg  <= cal_xor_7_wire ;
				xor_8_reg  <= cal_xor_8_wire ;
				xor_9_reg  <= cal_xor_9_wire ;
				xor_10_reg <= cal_xor_10_wire;
				xor_11_reg <= cal_xor_11_wire;
				xor_12_reg <= cal_xor_12_wire;
				xor_13_reg <= cal_xor_13_wire;
				xor_14_reg <= cal_xor_14_wire;
				xor_15_reg <= cal_xor_15_wire;
			end
			else begin
				xor_0_reg  <= xor_0_wire ;
				xor_1_reg  <= xor_1_wire ;
				xor_2_reg  <= xor_2_wire ;
				xor_3_reg  <= xor_3_wire ;
				xor_4_reg  <= xor_4_wire ;
				xor_5_reg  <= xor_5_wire ;
				xor_6_reg  <= xor_6_wire ;
				xor_7_reg  <= xor_7_wire ;
				xor_8_reg  <= xor_8_wire ;
				xor_9_reg  <= xor_9_wire ;
				xor_10_reg <= xor_10_wire;
				xor_11_reg <= xor_11_wire;
				xor_12_reg <= xor_12_wire;
				xor_13_reg <= xor_13_wire;
				xor_14_reg <= xor_14_wire;
				xor_15_reg <= xor_15_wire;
			end
		end
	end
	always@(posedge clk or negedge reset_n)
	begin : store_sum_output
		if(reset_n == 1'b0) begin
			sum_0_reg  <= 32'd0;
			sum_1_reg  <= 32'd0;
			sum_2_reg  <= 32'd0;
			sum_3_reg  <= 32'd0;
			sum_4_reg  <= 32'd0;
			sum_5_reg  <= 32'd0;
			sum_6_reg  <= 32'd0;
			sum_7_reg  <= 32'd0;
			sum_8_reg  <= 32'd0;
			sum_9_reg  <= 32'd0;
			sum_10_reg <= 32'd0;
			sum_11_reg <= 32'd0;
			sum_12_reg <= 32'd0;
			sum_13_reg <= 32'd0;
			sum_14_reg <= 32'd0;
			sum_15_reg <= 32'd0;
		end
		else begin
			if(sum_en == 1'b1) begin
				sum_0_reg  <= cal_sum_0_wire ;
				sum_1_reg  <= cal_sum_1_wire ;
				sum_2_reg  <= cal_sum_2_wire ;
				sum_3_reg  <= cal_sum_3_wire ;
				sum_4_reg  <= cal_sum_4_wire ;
				sum_5_reg  <= cal_sum_5_wire ;
				sum_6_reg  <= cal_sum_6_wire ;
				sum_7_reg  <= cal_sum_7_wire ;
				sum_8_reg  <= cal_sum_8_wire ;
				sum_9_reg  <= cal_sum_9_wire ;
				sum_10_reg <= cal_sum_10_wire;
				sum_11_reg <= cal_sum_11_wire;
				sum_12_reg <= cal_sum_12_wire;
				sum_13_reg <= cal_sum_13_wire;
				sum_14_reg <= cal_sum_14_wire;
				sum_15_reg <= cal_sum_15_wire;
			end
			else begin
				sum_0_reg  <= sum_0_wire ;
				sum_1_reg  <= sum_1_wire ;
				sum_2_reg  <= sum_2_wire ;
				sum_3_reg  <= sum_3_wire ;
				sum_4_reg  <= sum_4_wire ;
				sum_5_reg  <= sum_5_wire ;
				sum_6_reg  <= sum_6_wire ;
				sum_7_reg  <= sum_7_wire ;
				sum_8_reg  <= sum_8_wire ;
				sum_9_reg  <= sum_9_wire ;
				sum_10_reg <= sum_10_wire;
				sum_11_reg <= sum_11_wire;
				sum_12_reg <= sum_12_wire;
				sum_13_reg <= sum_13_wire;
				sum_14_reg <= sum_14_wire;
				sum_15_reg <= sum_15_wire;
			end
		end
	end
	always@(posedge clk or negedge reset_n)
	begin : store_salsa_output
		if(reset_n == 1'b0) begin
			salsa_out_0_reg  <= 32'd0;
			salsa_out_1_reg  <= 32'd0;
			salsa_out_2_reg  <= 32'd0;
			salsa_out_3_reg  <= 32'd0;
			salsa_out_4_reg  <= 32'd0;
			salsa_out_5_reg  <= 32'd0;
			salsa_out_6_reg  <= 32'd0;
			salsa_out_7_reg  <= 32'd0;
			salsa_out_8_reg  <= 32'd0;
			salsa_out_9_reg  <= 32'd0;
			salsa_out_10_reg <= 32'd0;
			salsa_out_11_reg <= 32'd0;
			salsa_out_12_reg <= 32'd0;
			salsa_out_13_reg <= 32'd0;
			salsa_out_14_reg <= 32'd0;
			salsa_out_15_reg <= 32'd0;
		end
		else begin
			if(salsa_valid == 1'b1) begin
				salsa_out_0_reg  <= cal_salsa_out_0_wire ;
				salsa_out_1_reg  <= cal_salsa_out_1_wire ;
				salsa_out_2_reg  <= cal_salsa_out_2_wire ;
				salsa_out_3_reg  <= cal_salsa_out_3_wire ;
				salsa_out_4_reg  <= cal_salsa_out_4_wire ;
				salsa_out_5_reg  <= cal_salsa_out_5_wire ;
				salsa_out_6_reg  <= cal_salsa_out_6_wire ;
				salsa_out_7_reg  <= cal_salsa_out_7_wire ;
				salsa_out_8_reg  <= cal_salsa_out_8_wire ;
				salsa_out_9_reg  <= cal_salsa_out_9_wire ;
				salsa_out_10_reg <= cal_salsa_out_10_wire;
				salsa_out_11_reg <= cal_salsa_out_11_wire;
				salsa_out_12_reg <= cal_salsa_out_12_wire;
				salsa_out_13_reg <= cal_salsa_out_13_wire;
				salsa_out_14_reg <= cal_salsa_out_14_wire;
				salsa_out_15_reg <= cal_salsa_out_15_wire;
			end
			else begin
				salsa_out_0_reg  <= salsa_out_0_wire ;
				salsa_out_1_reg  <= salsa_out_1_wire ;
				salsa_out_2_reg  <= salsa_out_2_wire ;
				salsa_out_3_reg  <= salsa_out_3_wire ;
				salsa_out_4_reg  <= salsa_out_4_wire ;
				salsa_out_5_reg  <= salsa_out_5_wire ;
				salsa_out_6_reg  <= salsa_out_6_wire ;
				salsa_out_7_reg  <= salsa_out_7_wire ;
				salsa_out_8_reg  <= salsa_out_8_wire ;
				salsa_out_9_reg  <= salsa_out_9_wire ;
				salsa_out_10_reg <= salsa_out_10_wire;
				salsa_out_11_reg <= salsa_out_11_wire;
				salsa_out_12_reg <= salsa_out_12_wire;
				salsa_out_13_reg <= salsa_out_13_wire;
				salsa_out_14_reg <= salsa_out_14_wire;
				salsa_out_15_reg <= salsa_out_15_wire;
			end
		end
	end
	
	always@(posedge clk or negedge reset_n)
	begin
		if(reset_n == 1'd0) begin
			out0_reg  <= 32'd0;
			out1_reg  <= 32'd0;
			out2_reg  <= 32'd0;
			out3_reg  <= 32'd0;
			out4_reg  <= 32'd0;
			out5_reg  <= 32'd0;
			out6_reg  <= 32'd0;
			out7_reg  <= 32'd0;
			out8_reg  <= 32'd0;
			out9_reg  <= 32'd0;
			out10_reg <= 32'd0;
			out11_reg <= 32'd0;
			out12_reg <= 32'd0;
			out13_reg <= 32'd0;
			out14_reg <= 32'd0;
			out15_reg <= 32'd0;
			out16_reg <= 32'd0;
			out17_reg <= 32'd0;
			out18_reg <= 32'd0;
			out19_reg <= 32'd0;
			out20_reg <= 32'd0;
			out21_reg <= 32'd0;
			out22_reg <= 32'd0;
			out23_reg <= 32'd0;
			out24_reg <= 32'd0;
			out25_reg <= 32'd0;
			out26_reg <= 32'd0;
			out27_reg <= 32'd0;
			out28_reg <= 32'd0;
			out29_reg <= 32'd0;
			out30_reg <= 32'd0;
			out31_reg <= 32'd0;
		end
		else begin
			if(update_high == 1'd1) begin
				out0_reg  <= sum_0_wire ;
				out1_reg  <= sum_1_wire ;
				out2_reg  <= sum_2_wire ;
				out3_reg  <= sum_3_wire ;
				out4_reg  <= sum_4_wire ;
				out5_reg  <= sum_5_wire ;
				out6_reg  <= sum_6_wire ;
				out7_reg  <= sum_7_wire ;
				out8_reg  <= sum_8_wire ;
				out9_reg  <= sum_9_wire ;
				out10_reg <= sum_10_wire;
				out11_reg <= sum_11_wire;
				out12_reg <= sum_12_wire;
				out13_reg <= sum_13_wire;
				out14_reg <= sum_14_wire;
				out15_reg <= sum_15_wire;
				out16_reg <= out16_wire;
				out17_reg <= out17_wire;
				out18_reg <= out18_wire;
				out19_reg <= out19_wire;
				out20_reg <= out20_wire;
				out21_reg <= out21_wire;
				out22_reg <= out22_wire;
				out23_reg <= out23_wire;
				out24_reg <= out24_wire;
				out25_reg <= out25_wire;
				out26_reg <= out26_wire;
				out27_reg <= out27_wire;
				out28_reg <= out28_wire;
				out29_reg <= out29_wire;
				out30_reg <= out30_wire;
				out31_reg <= out31_wire;
			end
			else if (update_low == 1'd1) begin
				out0_reg  <= out0_wire ;
				out1_reg  <= out1_wire ;
				out2_reg  <= out2_wire ;
				out3_reg  <= out3_wire ;
				out4_reg  <= out4_wire ;
				out5_reg  <= out5_wire ;
				out6_reg  <= out6_wire ;
				out7_reg  <= out7_wire ;
				out8_reg  <= out8_wire ;
				out9_reg  <= out9_wire ;
				out10_reg <= out10_wire;
				out11_reg <= out11_wire;
				out12_reg <= out12_wire;
				out13_reg <= out13_wire;
				out14_reg <= out14_wire;
				out15_reg <= out15_wire;
				out16_reg <= sum_0_wire ;
				out17_reg <= sum_1_wire ;
				out18_reg <= sum_2_wire ;
				out19_reg <= sum_3_wire ;
				out20_reg <= sum_4_wire ;
				out21_reg <= sum_5_wire ;
				out22_reg <= sum_6_wire ;
				out23_reg <= sum_7_wire ;
				out24_reg <= sum_8_wire ;
				out25_reg <= sum_9_wire ;
				out26_reg <= sum_10_wire;
				out27_reg <= sum_11_wire;
				out28_reg <= sum_12_wire;
				out29_reg <= sum_13_wire;
				out30_reg <= sum_14_wire;
				out31_reg <= sum_15_wire;
			end
			else begin
				out0_reg  <= out0_wire ;
				out1_reg  <= out1_wire ;
				out2_reg  <= out2_wire ;
				out3_reg  <= out3_wire ;
				out4_reg  <= out4_wire ;
				out5_reg  <= out5_wire ;
				out6_reg  <= out6_wire ;
				out7_reg  <= out7_wire ;
				out8_reg  <= out8_wire ;
				out9_reg  <= out9_wire ;
				out10_reg <= out10_wire;
				out11_reg <= out11_wire;
				out12_reg <= out12_wire;
				out13_reg <= out13_wire;
				out14_reg <= out14_wire;
				out15_reg <= out15_wire;
				out16_reg <= out16_wire;
				out17_reg <= out17_wire;
				out18_reg <= out18_wire;
				out19_reg <= out19_wire;
				out20_reg <= out20_wire;
				out21_reg <= out21_wire;
				out22_reg <= out22_wire;
				out23_reg <= out23_wire;
				out24_reg <= out24_wire;
				out25_reg <= out25_wire;
				out26_reg <= out26_wire;
				out27_reg <= out27_wire;
				out28_reg <= out28_wire;
				out29_reg <= out29_wire;
				out30_reg <= out30_wire;
				out31_reg <= out31_wire;
			end
		end
	end
	
endmodule