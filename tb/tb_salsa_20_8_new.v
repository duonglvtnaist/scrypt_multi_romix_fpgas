`timescale 1ns/1ps
module tb_salsa_20_8_new();
		reg				clk			;
		reg				init		;
		reg				reset_n		;
		reg 	[31:0]	x0			;
		reg 	[31:0]	x1	    	;
		reg 	[31:0]	x2	    	;
		reg 	[31:0]	x3	    	;
		reg 	[31:0]	x4	    	;
		reg 	[31:0]	x5	    	;
		reg 	[31:0]	x6	    	;
		reg 	[31:0]	x7	    	;
		reg 	[31:0]	x8	    	;
		reg 	[31:0]	x9	    	;
		reg 	[31:0]	x10	    	;
        reg 	[31:0]	x11	    	;
        reg 	[31:0]	x12	    	;
        reg 	[31:0]	x13	    	;
        reg 	[31:0]	x14	    	;
        reg 	[31:0]	x15	    	;
		reg 	[31:0]	f_x0		;
		reg 	[31:0]	f_x1	   	;
		reg 	[31:0]	f_x2	   	;
		reg 	[31:0]	f_x3	   	;
		reg 	[31:0]	f_x4	   	;
		reg 	[31:0]	f_x5	   	;
		reg 	[31:0]	f_x6	   	;
		reg 	[31:0]	f_x7	   	;
		reg 	[31:0]	f_x8	   	;
		reg 	[31:0]	f_x9	   	;
		reg 	[31:0]	f_x10	   	;
        reg 	[31:0]	f_x11	   	;
        reg 	[31:0]	f_x12	   	;
        reg 	[31:0]	f_x13	   	;
        reg 	[31:0]	f_x14	   	;
        reg 	[31:0]	f_x15	   	;
        wire 	[31:0]	out0    	;
        wire 	[31:0]	out1    	;
        wire 	[31:0]	out2    	;
        wire 	[31:0]	out3    	;
        wire 	[31:0]	out4    	;
        wire 	[31:0]	out5    	;
        wire 	[31:0]	out6    	;
        wire 	[31:0]	out7    	;
        wire 	[31:0]	out8    	;
        wire 	[31:0]	out9    	;
        wire 	[31:0]	out10   	;
        wire 	[31:0]	out11   	;
        wire 	[31:0]	out12   	;
        wire 	[31:0]	out13   	;
        wire 	[31:0]	out14   	;
        wire 	[31:0]	out15   	;
		wire 	[31:0]	f_out0    	;
        wire 	[31:0]	f_out1    	;
        wire 	[31:0]	f_out2    	;
        wire 	[31:0]	f_out3    	;
        wire 	[31:0]	f_out4    	;
        wire 	[31:0]	f_out5    	;
        wire 	[31:0]	f_out6    	;
        wire 	[31:0]	f_out7    	;
        wire 	[31:0]	f_out8    	;
        wire 	[31:0]	f_out9    	;
        wire 	[31:0]	f_out10   	;
        wire 	[31:0]	f_out11   	;
        wire 	[31:0]	f_out12   	;
        wire 	[31:0]	f_out13   	;
        wire 	[31:0]	f_out14   	;
        wire 	[31:0]	f_out15   	;
		wire			valid		;
		wire			new_valid	;
		
		parameter HALF_PERIOD_CLOCK = 10;
		
	salsa_20_8 salsa_20_8 (
		.clk(clk)			,
		.init(init)			,
		.reset_n(reset_n)	,
		.x0		(x0	)		,
		.x1		(x1	)		,
		.x2		(x2	)		,
		.x3		(x3	)		,
		.x4		(x4	)		,
		.x5		(x5	)		,
		.x6		(x6	)		,
		.x7		(x7	)		,
		.x8		(x8	)		,
		.x9		(x9	)		,
		.x10	(x10)		,
		.x11	(x11)		,
		.x12	(x12)		,
		.x13	(x13)		,
		.x14	(x14)		,
		.x15	(x15)		,	
		.out0	(out0)		,
		.out1	(out1)		,
		.out2	(out2)		,
		.out3	(out3)		,
		.out4	(out4)		,
		.out5	(out5)		,
		.out6	(out6)		,
		.out7	(out7)		,
		.out8	(out8)		,
		.out9	(out9)		,
		.out10	(out10)		,
		.out11	(out11)		,
		.out12	(out12)		,
		.out13	(out13)		,
		.out14	(out14)		,
		.out15	(out15)		,
		.valid	(valid)
	);
	
	salsa_20_8_new salsa_new (
		.clk    (clk)           ,
		.init   (init)          ,
		.reset_n(reset_n)       ,
		.x0	    (f_x0	)		,
		.x1	    (f_x1	)		,
		.x2	    (f_x2	)		,
		.x3	    (f_x3	)		,
		.x4	    (f_x4	)		,
		.x5	    (f_x5	)		,
		.x6	    (f_x6	)		,
		.x7	    (f_x7	)		,
		.x8	    (f_x8	)		,
		.x9	    (f_x9	)		,
		.x10	(f_x10	)		,
		.x11	(f_x11	)		,
		.x12	(f_x12	)		,
		.x13	(f_x13	)		,
		.x14	(f_x14	)		,
		.x15	(f_x15	)		,
		.out0	(f_out0	)		,
		.out1	(f_out1	)		,
		.out2	(f_out2	)		,
		.out3	(f_out3	)		,
		.out4	(f_out4	)		,
		.out5	(f_out5	)		,
		.out6	(f_out6	)		,
		.out7	(f_out7	)		,
		.out8	(f_out8	)		,
		.out9	(f_out9	)		,
		.out10	(f_out10)		,
		.out11	(f_out11)		,
		.out12	(f_out12)		,
		.out13	(f_out13)		,
		.out14	(f_out14)		,
		.out15	(f_out15)		,
        .valid  (new_valid)     
	);
	wire [511: 0] out;
	wire [511: 0] f_out;
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
		out15
	};
	
	assign f_out = {
		f_out0 ,
		f_out1 ,
		f_out2 ,
		f_out3 ,
		f_out4 ,
		f_out5 ,
		f_out6 ,
		f_out7 ,
		f_out8 ,
		f_out9 ,
		f_out10,
		f_out11,
		f_out12,
		f_out13,
		f_out14,
		f_out15
	};
	integer time1;
	integer update_time1 = 1;
	always @(*) 
	begin: clock_generator
		if(valid == 1'd1 && update_time1 == 1) begin
			update_time1 = 0;
			time1 = $time;
		end
		if(valid == 1'd1 && new_valid == 1'b1)begin
			$display("Test completed!");
			$display("Output salsa_20_8: %x cycle: %f.0", out, (time1 - start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Output four_dround_dpct: %x cycle: %f.0", f_out, ($time - start_time)/(HALF_PERIOD_CLOCK*2));
			$stop;
		end
		#(HALF_PERIOD_CLOCK) clk <= ~clk;
	end
	task init_task();
		begin
			clk  	= 1'b0;
			init 	= 1'b0;
			reset_n = 1'b0;
			x0	 	= 32'hae042d63;
			x1	 	= 32'hc3823f85;
			x2	 	= 32'h2d0a38cd;
			x3	 	= 32'h7af25f75;
			x4	 	= 32'hae042d63;
			x5	 	= 32'hc3823f85;
			x6	 	= 32'h2d0a38cd;
			x7	 	= 32'h7af25f75;
			x8	 	= 32'hae042d63;
			x9	 	= 32'hc3823f85;
			x10  	= 32'h2d0a38cd;
			x11  	= 32'h7af25f75;
			x12  	= 32'hae042d63;
			x13  	= 32'hc3823f85;
			x14  	= 32'h2d0a38cd;
			x15  	= 32'h7af25f75;		
			f_x0	= 32'hae042d63;
			f_x1	= 32'hc3823f85;
			f_x2	= 32'h2d0a38cd;
			f_x3	= 32'h7af25f75;
			f_x4	= 32'hae042d63;
			f_x5	= 32'hc3823f85;
			f_x6	= 32'h2d0a38cd;
			f_x7	= 32'h7af25f75;
			f_x8	= 32'hae042d63;
			f_x9	= 32'hc3823f85;
			f_x10  	= 32'h2d0a38cd;
			f_x11  	= 32'h7af25f75;
			f_x12  	= 32'hae042d63;
			f_x13  	= 32'hc3823f85;
			f_x14  	= 32'h2d0a38cd;
			f_x15  	= 32'h7af25f75;
		end
	endtask
	integer start_time;
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