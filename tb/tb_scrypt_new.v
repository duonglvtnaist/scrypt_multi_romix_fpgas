`timescale 1ns/1ps
module tb_scrypt_new();
    reg                clk           ;
    reg                reset_n       ;
    reg                init          ;
    reg    [639:0]     in            ;
    wire   [255:0]     out_scrypt    ;
    wire               valid         ;

	scrypt_new	scrypt_new_ip(
				.clk       	(clk        ) ,	  // clock signal
				.reset_n   	(reset_n    ) ,   // reset negative signal
				.init      	(init       ) ,   // start signal
				.in        	(in         ) ,   // input scrypt
				.out_scrypt	(out_scrypt ) ,   // output scrypt
				.valid	    (valid      )     // scrypt done
	);
	
	// scrypt_newdp	scrypt_ip(	.clk				(clk)			, 
								// .rst_n				(reset_n)		,
								// .start				(init)			,
								// .blockheader		(in)			, 
								// .valid_in			(valid_in)		, 
								// .outScrypt			(out_scrypt)	, 
								// .scrypt_ready		(scrypt_ready)	, 
								// .valid_out			(valid_scrypt)
								// );

	parameter HALF_PERIOD_CLOCK = 10;
	integer i;
	integer start_time;
	integer display_pbdkf2 = 1;
	always @(*) 
	begin: clock_generator
		#(HALF_PERIOD_CLOCK) clk <= ~clk;
	end
	always @(clk, valid) 
	begin

		// if(valid == 1'd1 && display_pbdkf2 == 1) begin
			// display_pbdkf2 = 0;
			// $display("Output new pbdkf2_1: %x cycle: %f", out, ($time-start_time)/(HALF_PERIOD_CLOCK*2));
		// end
		// if(valid_scrypt== 1'b1) begin
		if(valid== 1'b1) begin
			$display("Output scrypt: %x cycle: %f", out_scrypt, ($time-start_time)/(HALF_PERIOD_CLOCK*2));
			$display("Test completed, time: %t!", $time);
			$stop;
		end
	end
	task init_task();
		begin
			clk  		= 1'b0;
			init 		= 1'b0;
			reset_n 	= 1'b0;
			// valid_in 	= 1'b0;
			in			= 640'h0000002056efd1943684c1fdc247d4759cc43b29afa1cac7ad14579de5f6abcbc6bdf448ee3de4c7b45e9496ab41ecde73d1a299ddbcc7a81aa52776e6c067e214233af097b6885c97df011aa004090e;
			// in			= 640'h00000020975c67de235b7be00692604a59ff878df136f4cfcff46be8185cb8fa9c2a7aee9c95a05005242718144f6a09a45d151a7da7fc662e4b4ba4159ee59bf6998cc557b6885c97df011a814cf324;
		end
	endtask
	
	task reset_task (input reg[7:0] num_delay);
		begin
			#(HALF_PERIOD_CLOCK*2*num_delay) 	reset_n <= 1'b1;
			#(HALF_PERIOD_CLOCK*2)				init <= 1'b1;
			// valid_in <= 1'b1;
			start_time = $time;
			// #(HALF_PERIOD_CLOCK*2*2)				init <= 1'b0;
		end
	endtask
	
	initial begin: main_test
		$display("Test starts!");
		init_task();
		reset_task(3'd5);
	end
		
endmodule 