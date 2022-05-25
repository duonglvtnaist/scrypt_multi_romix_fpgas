`timescale 1ns/1ps
module tb_romix();
		reg					clk			;
		reg					init		;
		reg					reset_n		;

	// romix input	
		reg		[1023:0] 	in			;
	// new romix output	
	// old romix output

		
	parameter HALF_PERIOD_CLOCK = 10;
		
	wire					keep_input	;
	wire 	[1023: 0] 		out			;	
	wire 	[1023: 0] 		old_out		;
	wire					valid		;
	wire					old_valid	;
	wire					pbk_en		;
	wire					w_done		;
	wire					r_done		;
	romix	new_romix(
		.clk			(clk)				,
		.init			(init)				,
		.reset_n		(reset_n)			,
		.in				(in)				,
		.out			(out)				,
		.keep_input		(keep_input) 		,
		.valid			(valid)
	);
	
	romix_dpct_1m	old_romix(
		.in				(in)				, 
		.out			(old_out)			, 
		.rm_clock		(clk)				, 
		.RST_N			(reset_n)			,
		.rm_start		(init)				, 
		.rm_done		(old_valid)			,
		.pbk_en			(pbk_en)			,
		.w_start		(1'b1)				, 
		.r_start		(1'b1)				, 
		.w_done			(w_done)			, 
		.r_done			(r_done)
	);
	

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
			$display("Output new romix: %x cycle: %f", out, (i-start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Output old romix: %x cycle: %f", old_out, ($time-start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Test completed, time: %t!", $time);
			$stop;
		end
	end
	task init_task();
		begin
			clk  	= 1'b0;
			init 	= 1'b0;
			reset_n = 1'b0;
			in		= 1024'he9ff2138b950b9c69e197995cfee0c57f8ebe1798ff3599e9b2117d93a797793b1674ca303fb7309cea97827825d83b2d15e60cc38f6f8b6e5afdc59ac35c677cffc5cfc662e0df12d41e9c2fcf3112a3ae53e26746c2516b18a74531e3391d9f823fa1bac62b14f79013e3321311ff86c9c735267cc92a8c7b61ff535fc2dcf;		// RANDOM
			// in		= 1024'hc4517112904d6c8fefb4612eabfe490c0b16f42be0455eff285c3b95de694605d223c7ad0fee8367d609a1db08f81c83d41d5da3e5075f584f9d268dea50f0d324c8338d1dca035733215f58b022d2c100b97fb70bccf2c39e48cf82b3a06b479b99ea48cae83a6ad9a5eda92bd49c74a5bb6110304983013b419955c7a26a8a;		// SCRYPT	
			// in		= 1024'h1d7eb0a27b805cae3e5657433e0201c4b882f060d400b4e4d22529aa98d4d70cdd83a76e56e1ff65e309ddfc83e1cde90c1a98f3ce4e5cdad1e20afdad67445e1387707717dd3c78273c3e5ab7c426a552f42cdc43fe8eaf3dc8ca023af99a7264133b0dfc83243cb1584f64f858bfa050160b4c49dcc3db4ed1ead30a257c1b;
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