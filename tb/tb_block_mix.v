`timescale 1ns/1ps
module tb_block_mix();
		reg				clk			;
		reg				init		;
		reg				reset_n		;
		reg		[1023:0]in			;
	// blockmix input	
		reg 	[31:0]	in0			;
		reg 	[31:0]	in1	    	;
		reg 	[31:0]	in2	    	;
		reg 	[31:0]	in3	    	;
		reg 	[31:0]	in4	    	;
		reg 	[31:0]	in5	    	;
		reg 	[31:0]	in6	    	;
		reg 	[31:0]	in7	    	;
		reg 	[31:0]	in8	    	;
		reg 	[31:0]	in9	    	;
		reg 	[31:0]	in10    	;
        reg 	[31:0]	in11    	;
        reg 	[31:0]	in12    	;
        reg 	[31:0]	in13    	;
        reg 	[31:0]	in14    	;
        reg 	[31:0]	in15    	;		
		reg 	[31:0]	in16		;
		reg 	[31:0]	in17 	   	;
		reg 	[31:0]	in18 	   	;
		reg 	[31:0]	in19 	   	;
		reg 	[31:0]	in20 	   	;
		reg 	[31:0]	in21 	   	;
		reg 	[31:0]	in22 	   	;
		reg 	[31:0]	in23 	   	;
		reg 	[31:0]	in24 	   	;
		reg 	[31:0]	in25 	   	;
		reg 	[31:0]	in26    	;
        reg 	[31:0]	in27    	;
        reg 	[31:0]	in28    	;
        reg 	[31:0]	in29    	;
        reg 	[31:0]	in30    	;
        reg 	[31:0]	in31    	;
	// new blockmix output	
	// old blockmix output
		wire 	[31:0]	old_out0   	;
        wire 	[31:0]	old_out1   	;
        wire 	[31:0]	old_out2   	;
        wire 	[31:0]	old_out3   	;
        wire 	[31:0]	old_out4   	;
        wire 	[31:0]	old_out5   	;
        wire 	[31:0]	old_out6   	;
        wire 	[31:0]	old_out7   	;
        wire 	[31:0]	old_out8   	;
        wire 	[31:0]	old_out9   	;
        wire 	[31:0]	old_out10  	;
        wire 	[31:0]	old_out11  	;
        wire 	[31:0]	old_out12  	;
        wire 	[31:0]	old_out13  	;
        wire 	[31:0]	old_out14  	;
        wire 	[31:0]	old_out15  	;       
		wire 	[31:0]	old_out16  	;
        wire 	[31:0]	old_out17  	;
        wire 	[31:0]	old_out18  	;
        wire 	[31:0]	old_out19  	;
        wire 	[31:0]	old_out20  	;
        wire 	[31:0]	old_out21  	;
        wire 	[31:0]	old_out22  	;
        wire 	[31:0]	old_out23  	;
        wire 	[31:0]	old_out24  	;
        wire 	[31:0]	old_out25  	;
        wire 	[31:0]	old_out26  	;
        wire 	[31:0]	old_out27  	;
        wire 	[31:0]	old_out28  	;
        wire 	[31:0]	old_out29  	;
        wire 	[31:0]	old_out30  	;
        wire 	[31:0]	old_out31  	;
		wire			valid		;
		wire			old_valid	;

		
		parameter HALF_PERIOD_CLOCK = 10;
		

	wire [1023: 0] out;
	wire [1023: 0] old_out;
	
	blockmix_dpct bm1	(
		.clk	(clk)		,
		.init	(init)		,
		.reset_n(reset_n)	,
		.in		(in)		,
		.out	(out)		,
		.valid	(valid)
	);
	
	blockmix_dpct_clk_3s bm2(
		.clk	(clk)		,
		.start	(init)		,
		.rst_n	(reset_n)	,
		.in0 	(in0)		, 
		.in1 	(in1)		, 
		.in2 	(in2)		, 
		.in3 	(in3)		, 
		.in4 	(in4)		, 
		.in5 	(in5)		, 
		.in6 	(in6)		, 
		.in7 	(in7)		, 
		.in8 	(in8)		, 
		.in9 	(in9)		, 
		.in10	(in10)		, 
		.in11	(in11)		, 
		.in12	(in12)		, 
		.in13	(in13)		, 
		.in14	(in14)		, 
		.in15	(in15)		,
		.in16	(in16)		, 
		.in17	(in17)		, 
		.in18	(in18)		, 
		.in19	(in19)		, 
		.in20	(in20)		, 
		.in21	(in21)		, 
		.in22	(in22)		, 
		.in23	(in23)		,
		.in24	(in24)		, 
		.in25	(in25)		, 
		.in26	(in26)		, 
		.in27	(in27)		, 
		.in28	(in28)		, 
		.in29	(in29)		, 
		.in30	(in30)		, 
		.in31	(in31)		,
		.out0 	(old_out0)	, 
		.out1 	(old_out1)	, 
		.out2 	(old_out2)	, 
		.out3 	(old_out3)	, 
		.out4 	(old_out4)	, 
		.out5 	(old_out5)	, 
		.out6 	(old_out6)	, 
		.out7 	(old_out7)	, 
		.out8 	(old_out8)	, 
		.out9 	(old_out9)	, 
		.out10	(old_out10)	, 
		.out11	(old_out11)	, 
		.out12	(old_out12)	, 
		.out13	(old_out13)	, 
		.out14	(old_out14)	, 
		.out15	(old_out15)	,
		.out16	(old_out16)	, 
		.out17	(old_out17)	, 
		.out18	(old_out18)	, 
		.out19	(old_out19)	, 
		.out20	(old_out20)	, 
		.out21	(old_out21)	, 
		.out22	(old_out22)	, 
		.out23	(old_out23)	,
		.out24	(old_out24)	, 
		.out25	(old_out25)	, 
		.out26	(old_out26)	, 
		.out27	(old_out27)	, 
		.out28	(old_out28)	, 
		.out29	(old_out29)	, 
		.out30	(old_out30)	, 
		.out31	(old_out31)	,
		.done	(old_valid)	
	);
	
	

	assign old_out = {
					old_out0 ,
					old_out1 ,
					old_out2 ,
					old_out3 ,
					old_out4 ,
					old_out5 ,
					old_out6 ,
					old_out7 ,
					old_out8 ,
					old_out9 ,
					old_out10,
					old_out11,
					old_out12,
					old_out13,
					old_out14,
					old_out15,
					old_out16,
					old_out17,
					old_out18,
					old_out19,
					old_out20,
					old_out21,
					old_out22,
					old_out23,
					old_out24,
					old_out25,
					old_out26,
					old_out27,
					old_out28,
					old_out29,
					old_out30,
					old_out31
	};
	integer i;
	integer start_time;
	integer check = 1;
	always @(*) 
	begin: clock_generator
		#(HALF_PERIOD_CLOCK) clk <= ~clk;
	end
	always @(clk, valid, old_valid) 
	begin
		if(valid == 1'd1 && check == 1) begin
			i = $time;
			check = 0;
		end
		if(valid == 1'd1 && old_valid == 1'd1) begin
			$display("Output new block mix: %x cycle: %f", out, (i-start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Output old block mix: %x cycle: %f", old_out, ($time-start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Test completed, time: %t!", $time);
			$stop;
		end
	end
	task init_task();
		begin
			clk  	= 1'b0;
			init 	= 1'b0;
			reset_n = 1'b0;
			in0	 	= 32'he9ff2138;
			in1	 	= 32'hb950b9c6;
			in2	 	= 32'h9e197995;
			in3	 	= 32'hcfee0c57;
			in4	 	= 32'hf8ebe179;
			in5	 	= 32'h8ff3599e;
			in6	 	= 32'h9b2117d9;
			in7	 	= 32'h3a797793;
			in8	 	= 32'hb1674ca3;
			in9	 	= 32'h03fb7309;
			in10  	= 32'hcea97827;
			in11  	= 32'h825d83b2;
			in12  	= 32'hd15e60cc;
			in13  	= 32'h38f6f8b6;
			in14  	= 32'he5afdc59;
			in15  	= 32'hac35c677;				
			in16 	= 32'hcffc5cfc;
			in17 	= 32'h662e0df1;
			in18 	= 32'h2d41e9c2;
			in19 	= 32'hfcf3112a;
			in20 	= 32'h3ae53e26;
			in21 	= 32'h746c2516;
			in22 	= 32'hb18a7453;
			in23 	= 32'h1e3391d9;
			in24 	= 32'hf823fa1b;
			in25 	= 32'hac62b14f;
			in26  	= 32'h79013e33;
			in27  	= 32'h21311ff8;
			in28  	= 32'h6c9c7352;
			in29  	= 32'h67cc92a8;
			in30  	= 32'hc7b61ff5;
			in31  	= 32'h35fc2dcf;	
			// in		= 1024'he9ff2138b950b9c69e197995cfee0c57f8ebe1798ff3599e9b2117d93a797793b1674ca303fb7309cea97827825d83b2d15e60cc38f6f8b6e5afdc59ac35c677cffc5cfc662e0df12d41e9c2fcf3112a3ae53e26746c2516b18a74531e3391d9f823fa1bac62b14f79013e3321311ff86c9c735267cc92a8c7b61ff535fc2dcf;	
			in		= 1024'h264b5f120a5cd734959837046aac499cba1701807e78a726a1ebcacc144a50c86788331394f1a4ebad038f73e3fe594fcfa6a26fb841b099dd2aafaf38859bc3820ac6670d9a31f29eaa2a983c594cdfdddee8091612d0815203b64de5e40141fcc6127093a003dfb3b58c5280617a72f6653bc9a91110dbc99abeb4d0d4a3d0;			
		end
	endtask
	
	task reset_task (input reg[7:0] num_delay);
		begin
			#(HALF_PERIOD_CLOCK*2*num_delay) 	reset_n <= 1'b1;
			#(HALF_PERIOD_CLOCK*2)				init <= 1'b1;
			start_time = $time;
		end
	endtask
	
	initial begin: main_test
		$display("Test starts!");
		init_task();
		reset_task(3'd5);
	end
		
endmodule 