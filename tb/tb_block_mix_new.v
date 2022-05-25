`timescale 1ns/1ps
module tb_block_mix_new();
		reg				clk			;
		reg				init		;
		reg				reset_n		;
		reg		[1023:0]in			;
	// blockmix input	
	// new blockmix output	
	// old blockmix output

		wire			valid		;
		wire			new_valid	;
        

		
		parameter HALF_PERIOD_CLOCK = 10;
		

	wire [1023: 0] out;
	wire [1023: 0] new_out;
	
	blockmix_dpct bm1	(
		.clk	(clk)		,
		.init	(init)		,
		.reset_n(reset_n)	,
		.in		(in)		,
		.out	(out)		,
		.valid	(valid)
	);
    
    blockmix_dpct_new bm2	(
		.clk	(clk)		,
		.init	(init)		,
		.reset_n(reset_n)	,
		.in		(in)		,
		.out	(new_out)	,
		.valid	(new_valid)
	);
	
	

	integer i;
	integer start_time;
	integer check = 1;
	always @(*) 
	begin: clock_generator
		#(HALF_PERIOD_CLOCK) clk <= ~clk;
	end
	always @(clk, valid, new_valid) 
	begin
		if(valid == 1'd1 && check == 1) begin
			i = $time;
			check = 0;
		end
		if(valid == 1'd1 && new_valid == 1'd1) begin
			$display("Output old block mix: %x cycle: %f", out, (i-start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Output new block mix: %x cycle: %f", new_out, ($time-start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Test completed, time: %t!", $time);
			$stop;
		end
	end
	task init_task();
		begin
			clk  	= 1'b0;
			init 	= 1'b0;
			reset_n = 1'b0;
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