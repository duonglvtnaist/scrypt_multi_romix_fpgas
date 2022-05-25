module blockmix_dpct(
		input 	wire	clk		,	// clock signal
		input	wire	init	,   // start signal
		input	wire	reset_n	,   // reset negative signal
		// inputs 
		input	wire [1023:0]	in	,

		// outputs
		output	wire [1023:0]	out ,
		output	wire		valid		// have result
	);
	// control wires
	
	wire 	sel_in;
	wire 	in_en;
	wire 	xor_en;
	wire	salsa_init;
	wire	salsa_valid;
	wire	sum_en;
	wire	update_high;
	wire	update_low;
	
	
	wire [31:0]	in0 	;
	wire [31:0]	in1 	;
	wire [31:0]	in2 	;
	wire [31:0]	in3 	;
	wire [31:0]	in4 	;
	wire [31:0]	in5 	;
	wire [31:0]	in6 	;
	wire [31:0]	in7 	;
	wire [31:0]	in8 	;
	wire [31:0]	in9 	;
	wire [31:0]	in10	;
	wire [31:0]	in11	;
	wire [31:0]	in12	;
	wire [31:0]	in13	;
	wire [31:0]	in14	;
	wire [31:0]	in15	;
	wire [31:0]	in16	;
	wire [31:0]	in17	;
	wire [31:0]	in18	;
	wire [31:0]	in19	;
	wire [31:0]	in20	;
	wire [31:0]	in21	;
	wire [31:0]	in22	;
	wire [31:0]	in23	;
	wire [31:0]	in24	;
	wire [31:0]	in25	;
	wire [31:0]	in26	;
	wire [31:0]	in27	;
	wire [31:0]	in28	;
	wire [31:0]	in29	;
	wire [31:0]	in30	;
	wire [31:0]	in31	;
	
	
	wire [31:0]	out0 	;
	wire [31:0]	out1 	;
	wire [31:0]	out2 	;
	wire [31:0]	out3 	;
	wire [31:0]	out4 	;
	wire [31:0]	out5 	;
	wire [31:0]	out6 	;
	wire [31:0]	out7 	;
	wire [31:0]	out8 	;
	wire [31:0]	out9 	;
	wire [31:0]	out10	;
	wire [31:0]	out11	;
	wire [31:0]	out12	;
	wire [31:0]	out13	;
	wire [31:0]	out14	;
	wire [31:0]	out15	;		
	wire [31:0]	out16	;
	wire [31:0]	out17	;
	wire [31:0]	out18	;
	wire [31:0]	out19	;
	wire [31:0]	out20	;
	wire [31:0]	out21	;
	wire [31:0]	out22	;
	wire [31:0]	out23	;
	wire [31:0]	out24	;
	wire [31:0]	out25	;
	wire [31:0]	out26	;
	wire [31:0]	out27	;
	wire [31:0]	out28	;
	wire [31:0]	out29	;
	wire [31:0]	out30	;
	wire [31:0]	out31	;
	
	
	assign in0 	= 	in[	1023	:	992	]			;
	assign in1 	= 	in[	991		:	960	]			;
	assign in2 	= 	in[	959		:	928	]			;
	assign in3 	= 	in[	927		:	896	]			;
	assign in4 	= 	in[	895		:	864	]			;
	assign in5 	= 	in[	863		:	832	]			;
	assign in6 	= 	in[	831		:	800	]			;
	assign in7 	= 	in[	799		:	768	]			;
	assign in8 	= 	in[	767		:	736	]			;
	assign in9 	= 	in[	735		:	704	]			;
	assign in10	= 	in[	703		:	672	]			;
	assign in11	= 	in[	671		:	640	]			;
	assign in12	= 	in[	639		:	608	]			;
	assign in13	= 	in[	607		:	576	]			;
	assign in14	= 	in[	575		:	544	]			;
	assign in15	= 	in[	543		:	512	]			;
	assign in16	= 	in[	511		:	480	]			;
	assign in17	= 	in[	479		:	448	]			;
	assign in18	= 	in[	447		:	416	]			;
	assign in19	= 	in[	415		:	384	]			;
	assign in20	= 	in[	383		:	352	]			;
	assign in21	= 	in[	351		:	320	]			;
	assign in22	= 	in[	319		:	288	]			;
	assign in23	= 	in[	287		:	256	]			;
	assign in24	= 	in[	255		:	224	]			;
	assign in25	= 	in[	223		:	192	]			;
	assign in26	= 	in[	191		:	160	]			;
	assign in27	= 	in[	159		:	128	]			;
	assign in28	= 	in[	127		:	96	]			;
	assign in29	= 	in[	95		:	64	]			;
	assign in30	= 	in[	63		:	32	]			;
	assign in31	= 	in[	31		:	0	]			;
	
	
	assign out = {
		out0 ,
	    out1 ,
	    out2 ,
	    out3 ,
	    out4 ,
	    out5 ,
	    out6 ,
	    out7 ,
	    out8 ,
	    out9 ,
	    out10,
	    out11,
	    out12,
	    out13,
	    out14,
	    out15,
	    out16,
	    out17,
	    out18,
	    out19,
	    out20,
	    out21,
	    out22,
	    out23,
	    out24,
	    out25,
	    out26,
	    out27,
	    out28,
	    out29,
	    out30,
	    out31
	};
	// Datapath
	blockmix_dp datapath(
		.clk	(clk)				,	// clock signal
		.reset_n(reset_n)			,	// reset negative signal
		//inputs		
		.in0 		(in0 )			,
		.in1 		(in1 )			,
		.in2 		(in2 )			,
		.in3 		(in3 )			,
		.in4 		(in4 )			,
		.in5 		(in5 )			,
		.in6 		(in6 )			,
		.in7 		(in7 )			,
		.in8 		(in8 )			,
		.in9 		(in9 )			,
		.in10		(in10)			,
		.in11		(in11)			,
		.in12		(in12)			,
		.in13		(in13)			,
		.in14		(in14)			,
		.in15		(in15)			,
		.in16		(in16)			,
		.in17		(in17)			,
		.in18		(in18)			,
		.in19		(in19)			,
		.in20		(in20)			,
		.in21		(in21)			,
		.in22		(in22)			,
		.in23		(in23)			,
		.in24		(in24)			,
		.in25		(in25)			,
		.in26		(in26)			,
		.in27		(in27)			,
		.in28		(in28)			,
		.in29		(in29)			,
		.in30		(in30)			,
		.in31		(in31)			,
		// input signals from controller
		.valid		(valid)			,
		.sel_in 	(sel_in)		,	// select input for salsa 20/8 block -> loop index [0,1]
		.in_en 		(in_en)			,	// allow to save input data
		.xor_en		(xor_en)		,	// allow to calculate xor for the loop
		.salsa_init	(salsa_init)	,	// allow running salsa 20/8 block
		.sum_en 	(sum_en)		,	// allow to calculate sum for the loop
		.update_high(update_high)	,	// allow to update high-bit output
		.update_low (update_low)	,   // allow to update low-bit output
		// outputs
		.out0 		(out0 )			,
		.out1 		(out1 )			,
		.out2 		(out2 )			,
		.out3 		(out3 )			,
		.out4 		(out4 )			,
		.out5 		(out5 )			,
		.out6 		(out6 )			,
		.out7 		(out7 )			,
		.out8 		(out8 )			,
		.out9 		(out9 )			,
		.out10		(out10)			,
		.out11		(out11)			,
		.out12		(out12)			,
		.out13		(out13)			,
		.out14		(out14)			,
		.out15		(out15)			,
		.out16		(out16)			,
		.out17		(out17)			,
		.out18		(out18)			,
		.out19		(out19)			,
		.out20		(out20)			,
		.out21		(out21)			,
		.out22		(out22)			,
		.out23		(out23)			,
		.out24		(out24)			,
		.out25		(out25)			,
		.out26		(out26)			,
		.out27		(out27)			,
		.out28		(out28)			,
		.out29		(out29)			,
		.out30		(out30)			,
		.out31		(out31)			,
		//output signals
		.salsa_valid (salsa_valid)		// salsa 20/8 have result
	);
	
	blockmix_ct controller(
		.clk		(clk)			,	// clock signal
		.init		(init)			,	// start signal
		.reset_n	(reset_n)		,	// reset negative signal
		.salsa_valid(salsa_valid)	,	// salsa have output
		.sel_in 	(sel_in)		,	// select input for salsa 20/8 block
		.in_en 		(in_en)			,	// allow to save input data
		.xor_en		(xor_en)		,	// allow to calculate xor for the first loop
		.salsa_init	(salsa_init)	,	// allow running salsa 20/8 block
		.sum_en 	(sum_en)		,	// allow to calculate sum for the first loop
		.update_high(update_high)	,	// allow to update high-bit output
		.update_low	(update_low)	,   // allow to update low-bit output
		.valid		(valid)				// block mix have result
	);
	

	
endmodule