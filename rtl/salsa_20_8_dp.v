module salsa_20_8_dp(
		input	wire 			clk,
		input	wire			reset_n,
		input 	wire			write_temp,
		input	wire			sel_in,
		// input	wire			sel_order,
		input	wire 	[31:0]	x0,
		input	wire 	[31:0]	x1,
		input	wire 	[31:0]	x2,
		input	wire 	[31:0]	x3,
		input	wire 	[31:0]	x4,
		input	wire 	[31:0]	x5,
		input	wire 	[31:0]	x6,
		input	wire 	[31:0]	x7,
		input	wire 	[31:0]	x8,
		input	wire 	[31:0]	x9,
		input	wire 	[31:0]	x10,
		input	wire 	[31:0]	x11,
		input	wire 	[31:0]	x12,
		input	wire 	[31:0]	x13,
		input	wire 	[31:0]	x14,
		input	wire 	[31:0]	x15,		
		output	wire 	[31:0]	out0 ,
		output	wire 	[31:0]	out1 ,
		output	wire 	[31:0]	out2 ,
		output	wire 	[31:0]	out3 ,
		output	wire 	[31:0]	out4 ,
		output	wire 	[31:0]	out5 ,
		output	wire 	[31:0]	out6 ,
		output	wire 	[31:0]	out7 ,
		output	wire 	[31:0]	out8 ,
		output	wire 	[31:0]	out9 ,
		output	wire 	[31:0]	out10,
		output	wire 	[31:0]	out11,
		output	wire 	[31:0]	out12,
		output	wire 	[31:0]	out13,
		output	wire 	[31:0]	out14,
		output	wire 	[31:0]	out15,
		input 	wire			valid
);
	// declare temp to save temporary value
	reg [31:0] x_temp_0 ;
	reg [31:0] x_temp_1 ;
	reg [31:0] x_temp_2 ;
	reg [31:0] x_temp_3 ;
	reg [31:0] x_temp_4 ;
	reg [31:0] x_temp_5 ;
	reg [31:0] x_temp_6 ;
	reg [31:0] x_temp_7 ;
	reg [31:0] x_temp_8 ;
	reg [31:0] x_temp_9 ;
	reg [31:0] x_temp_10;
	reg [31:0] x_temp_11;
	reg [31:0] x_temp_12;
	reg [31:0] x_temp_13;
	reg [31:0] x_temp_14;
	reg [31:0] x_temp_15;		
	
	wire [31:0] x_temp_0_w ;
	wire [31:0] x_temp_1_w ;
	wire [31:0] x_temp_2_w ;
	wire [31:0] x_temp_3_w ;
	wire [31:0] x_temp_4_w ;
	wire [31:0] x_temp_5_w ;
	wire [31:0] x_temp_6_w ;
	wire [31:0] x_temp_7_w ;
	wire [31:0] x_temp_8_w ;
	wire [31:0] x_temp_9_w ;
	wire [31:0] x_temp_10_w;
	wire [31:0] x_temp_11_w;
	wire [31:0] x_temp_12_w;
	wire [31:0] x_temp_13_w;
	wire [31:0] x_temp_14_w;
	wire [31:0] x_temp_15_w;	
	
	// Selected input source for full_qround
	wire [31:0] in_0 ;
	wire [31:0] in_1 ;
	wire [31:0] in_2 ;
	wire [31:0] in_3 ;
	wire [31:0] in_4 ;
	wire [31:0] in_5 ;
	wire [31:0] in_6 ;
	wire [31:0] in_7 ;
	wire [31:0] in_8 ;
	wire [31:0] in_9 ;
	wire [31:0] in_10;
	wire [31:0] in_11;
	wire [31:0] in_12;
	wire [31:0] in_13;
	wire [31:0] in_14;
	wire [31:0] in_15;
	
	// Selected order source for full_qround
	// wire [31:0] f_in_0 ;
	// wire [31:0] f_in_1 ;
	// wire [31:0] f_in_2 ;
	// wire [31:0] f_in_3 ;
	// wire [31:0] f_in_4 ;
	// wire [31:0] f_in_5 ;
	// wire [31:0] f_in_6 ;
	// wire [31:0] f_in_7 ;
	// wire [31:0] f_in_8 ;
	// wire [31:0] f_in_9 ;
	// wire [31:0] f_in_10;
	// wire [31:0] f_in_11;
	// wire [31:0] f_in_12;
	// wire [31:0] f_in_13;
	// wire [31:0] f_in_14;
	// wire [31:0] f_in_15;
	
	// full_qround output wires
	
	wire [31:0] f_out_0 ;
	wire [31:0] f_out_1 ;
	wire [31:0] f_out_2 ;
	wire [31:0] f_out_3 ;
	wire [31:0] f_out_4 ;
	wire [31:0] f_out_5 ;
	wire [31:0] f_out_6 ;
	wire [31:0] f_out_7 ;
	wire [31:0] f_out_8 ;
	wire [31:0] f_out_9 ;
	wire [31:0] f_out_10;
	wire [31:0] f_out_11;
	wire [31:0] f_out_12;
	wire [31:0] f_out_13;
	wire [31:0] f_out_14;
	wire [31:0] f_out_15;
	
	// Assign temp registers for temp wires
	assign x_temp_0_w  = x_temp_0 ;
	assign x_temp_1_w  = x_temp_1 ;
	assign x_temp_2_w  = x_temp_2 ;
	assign x_temp_3_w  = x_temp_3 ;
	assign x_temp_4_w  = x_temp_4 ;
	assign x_temp_5_w  = x_temp_5 ;
	assign x_temp_6_w  = x_temp_6 ;
	assign x_temp_7_w  = x_temp_7 ;
	assign x_temp_8_w  = x_temp_8 ;
	assign x_temp_9_w  = x_temp_9 ;
	assign x_temp_10_w = x_temp_10;
	assign x_temp_11_w = x_temp_11;
	assign x_temp_12_w = x_temp_12;
	assign x_temp_13_w = x_temp_13;
	assign x_temp_14_w = x_temp_14;
	assign x_temp_15_w = x_temp_15;
	
	assign out0  = (valid == 1'b1) ? x_temp_3  : 32'd0;
	assign out1  = (valid == 1'b1) ? x_temp_0  : 32'd0;
	assign out2  = (valid == 1'b1) ? x_temp_1  : 32'd0;
	assign out3  = (valid == 1'b1) ? x_temp_2  : 32'd0;
	assign out4  = (valid == 1'b1) ? x_temp_6  : 32'd0;
	assign out5  = (valid == 1'b1) ? x_temp_7  : 32'd0;
	assign out6  = (valid == 1'b1) ? x_temp_4  : 32'd0;
	assign out7  = (valid == 1'b1) ? x_temp_5  : 32'd0;
	assign out8  = (valid == 1'b1) ? x_temp_9  : 32'd0;
	assign out9  = (valid == 1'b1) ? x_temp_10 : 32'd0;
	assign out10 = (valid == 1'b1) ? x_temp_11 : 32'd0;
	assign out11 = (valid == 1'b1) ? x_temp_8  : 32'd0;
	assign out12 = (valid == 1'b1) ? x_temp_12 : 32'd0;
	assign out13 = (valid == 1'b1) ? x_temp_13 : 32'd0;
	assign out14 = (valid == 1'b1) ? x_temp_14 : 32'd0;
	assign out15 = (valid == 1'b1) ? x_temp_15 : 32'd0;
	
	// Select input source for full_qround
	mux21#(32) sel_in_0		(x1	, x_temp_0_w , sel_in, in_0 );
	mux21#(32) sel_in_1		(x2	, x_temp_1_w , sel_in, in_1	);
	mux21#(32) sel_in_2		(x3	, x_temp_2_w , sel_in, in_2	);
	mux21#(32) sel_in_3		(x0	, x_temp_3_w , sel_in, in_3	);	
	mux21#(32) sel_in_4		(x6	, x_temp_4_w , sel_in, in_4	);
	mux21#(32) sel_in_5		(x7	, x_temp_5_w , sel_in, in_5	);
	mux21#(32) sel_in_6		(x4	, x_temp_6_w , sel_in, in_6	);
	mux21#(32) sel_in_7		(x5	, x_temp_7_w , sel_in, in_7	);
	mux21#(32) sel_in_8		(x11, x_temp_8_w , sel_in, in_8	);
	mux21#(32) sel_in_9		(x8	, x_temp_9_w , sel_in, in_9	);
	mux21#(32) sel_in_10	(x9	, x_temp_10_w, sel_in, in_10);
	mux21#(32) sel_in_11	(x10, x_temp_11_w, sel_in, in_11);	
	mux21#(32) sel_in_12	(x12, x_temp_12_w, sel_in, in_12);
	mux21#(32) sel_in_13	(x13, x_temp_13_w, sel_in, in_13);
	mux21#(32) sel_in_14	(x14, x_temp_14_w, sel_in, in_14);
	mux21#(32) sel_in_15	(x15, x_temp_15_w, sel_in, in_15);

	//??????????????
	//Reorder input for full_qround
	// mux21#(32) sel_order_0	 (in_6 	, in_6 	, sel_order, f_in_0	);
	// mux21#(32) sel_order_1	 (in_9 	, in_9 	, sel_order, f_in_1	);
	// mux21#(32) sel_order_2	 (in_12	, in_12 , sel_order, f_in_2	);
	// mux21#(32) sel_order_3	 (in_3 	, in_3 	, sel_order, f_in_3	);
	// mux21#(32) sel_order_4	 (in_10 , in_10 , sel_order, f_in_4	);
	// mux21#(32) sel_order_5	 (in_13	, in_13 , sel_order, f_in_5	);
	// mux21#(32) sel_order_6	 (in_0 	, in_0 	, sel_order, f_in_6	);
	// mux21#(32) sel_order_7	 (in_7 	, in_7 	, sel_order, f_in_7	);
	// mux21#(32) sel_order_8	 (in_14	, in_14	, sel_order, f_in_8	);
	// mux21#(32) sel_order_9	 (in_1 	, in_1 	, sel_order, f_in_9	);
	// mux21#(32) sel_order_10  (in_4 	, in_4 	, sel_order, f_in_10);
	// mux21#(32) sel_order_11  (in_11	, in_11	, sel_order, f_in_11);
	// mux21#(32) sel_order_12  (in_2 	, in_2	, sel_order, f_in_12);
	// mux21#(32) sel_order_13  (in_5 	, in_5	, sel_order, f_in_13);
	// mux21#(32) sel_order_14  (in_8	, in_8	, sel_order, f_in_14);
	// mux21#(32) sel_order_15  (in_15	, in_15	, sel_order, f_in_15);



	full_qround full_qround_1 (
			// ins
			.x0 	(in_6 	)		,
			.x1 	(in_9 	)		,
			.x2 	(in_12	)		,
			.x3 	(in_3 	)		,
			.x4 	(in_10 )		,
			.x5 	(in_13	)		,
			.x6 	(in_0 	)		,
			.x7 	(in_7 	)		,
			.x8 	(in_14	)		,
			.x9 	(in_1 	)		,
			.x10	(in_4 	)	,
			.x11	(in_11	)	,
			.x12	(in_2 	)	,
			.x13	(in_5 	)	,
			.x14	(in_8	)	,
			.x15	(in_15	)	,
			// outs
			.out0 	(f_out_0 )	,
			.out1 	(f_out_1 )	,
			.out2 	(f_out_2 )	,
			.out3 	(f_out_3 )	,
			.out4 	(f_out_4 )	,
			.out5 	(f_out_5 )	,
			.out6 	(f_out_6 )	,
			.out7 	(f_out_7 )	,
			.out8 	(f_out_8 )	,
			.out9 	(f_out_9 )	,
			.out10	(f_out_10)	,
			.out11	(f_out_11)	,
			.out12	(f_out_12)	,
			.out13	(f_out_13)	,
			.out14	(f_out_14)	,
			.out15	(f_out_15)
	);
	
	always @(posedge clk or negedge reset_n) begin: update_temp
		if(reset_n == 1'b0) begin
			x_temp_0  <= 32'd0;
			x_temp_1  <= 32'd0;
			x_temp_2  <= 32'd0;
			x_temp_3  <= 32'd0;
			x_temp_4  <= 32'd0;
			x_temp_5  <= 32'd0;
			x_temp_6  <= 32'd0;
			x_temp_7  <= 32'd0;
			x_temp_8  <= 32'd0;
			x_temp_9  <= 32'd0;
			x_temp_10 <= 32'd0;
			x_temp_11 <= 32'd0;
			x_temp_12 <= 32'd0;
			x_temp_13 <= 32'd0;
			x_temp_14 <= 32'd0;
			x_temp_15 <= 32'd0;
		end
		else if(write_temp == 1'b1) begin
				x_temp_0  <= f_out_0 ;
				x_temp_1  <= f_out_1 ;
				x_temp_2  <= f_out_2 ;
				x_temp_3  <= f_out_3 ;
				x_temp_4  <= f_out_4 ;
				x_temp_5  <= f_out_5 ;
				x_temp_6  <= f_out_6 ;
				x_temp_7  <= f_out_7 ;
				x_temp_8  <= f_out_8 ;
				x_temp_9  <= f_out_9 ;
				x_temp_10 <= f_out_10;
				x_temp_11 <= f_out_11;
				x_temp_12 <= f_out_12;
				x_temp_13 <= f_out_13;
				x_temp_14 <= f_out_14;
				x_temp_15 <= f_out_15;
            end
            else begin
				x_temp_0  <= x_temp_0_w ;
				x_temp_1  <= x_temp_1_w ;
				x_temp_2  <= x_temp_2_w ;
				x_temp_3  <= x_temp_3_w ;
				x_temp_4  <= x_temp_4_w ;
				x_temp_5  <= x_temp_5_w ;
				x_temp_6  <= x_temp_6_w ;
				x_temp_7  <= x_temp_7_w ;
				x_temp_8  <= x_temp_8_w ;
				x_temp_9  <= x_temp_9_w ;
				x_temp_10 <= x_temp_10_w;
				x_temp_11 <= x_temp_11_w;
				x_temp_12 <= x_temp_12_w;
				x_temp_13 <= x_temp_13_w;
				x_temp_14 <= x_temp_14_w;
				x_temp_15 <= x_temp_15_w;
            end
	end

endmodule 