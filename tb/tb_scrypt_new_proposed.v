`timescale 1ns/1ps
module tb_scrypt_new_proposed();
    reg                             clk                                 ;
    reg                             reset_n                             ;
    reg                             init                                ;
    reg    [639:0]                  in                                  ;
    wire   [255:0]                  out_scrypt                          ;
    wire                            valid                               ;
    wire                            ready_in                            ;

    integer                         count_in = 0                        ;       
    parameter	WIDTH_IN		= 640;
    parameter	WIDTH_OUT		= 256;
    parameter	NUM_TESTCASE	= 40;
    reg 	[WIDTH_IN - 1:0]		SCRYPT_IN		[0:NUM_TESTCASE-1]  ;
    reg 	[WIDTH_OUT - 1:0]		SCRYPT_OUT		[0:NUM_TESTCASE-1]  ;
    
	scrypt_new_proposed	scrypt_new_ip(
				.clk       	(clk        ) ,	  // clock signal
				.reset_n   	(reset_n    ) ,   // reset negative signal
				.init      	(init       ) ,   // start signal
				.in        	(in         ) ,   // input scrypt
				.out_scrypt	(out_scrypt ) ,   // output scrypt
                .ready_in   (ready_in   ) ,
				.valid	    (valid      )     // scrypt done
	);
	
	initial begin
		$readmemh("E:/Projects/scrypt_155MHz_9037reg_9583LUT_29BRAM/Testcases/BlockHeader.txt", SCRYPT_IN);
		$readmemh("E:/Projects/scrypt_155MHz_9037reg_9583LUT_29BRAM/Testcases/ScryptOut.txt", SCRYPT_OUT);
	end
    integer num_valid = 0;
	parameter HALF_PERIOD_CLOCK = 10;
	integer i;
	integer start_time;
	integer display_pbdkf2 = 1;
	always @(*) 
	begin: clock_generator
		#(HALF_PERIOD_CLOCK) clk <= ~clk;
	end
	always @(posedge valid) 
	begin
		if(valid== 1'b1) begin
            $display("Time: %t", $time);
            $display("Test cases: %d", num_valid);
			$display("Output scrypt: %x cycle: %f", out_scrypt, ($time-start_time)/(HALF_PERIOD_CLOCK*2));
            $display("Golden out:   %x", SCRYPT_OUT[num_valid]);
            if(num_valid == NUM_TESTCASE - 1) begin
                $display("Test completed, time: %t!", $time);
               $stop;
            end
            num_valid = num_valid + 1;
		end
	end
	task init_task();
		begin
			clk  		=   1'b0                ;
			init 		=   1'b0                ;
			reset_n 	=   1'b0                ;
            in          =   SCRYPT_IN[count_in] ;
		end
	endtask
	
	task reset_task (input reg[7:0] num_delay);
		begin
			#(HALF_PERIOD_CLOCK*2*num_delay) 	    reset_n = 1'b1;
			#(HALF_PERIOD_CLOCK*2)				init    = 1'b1;
			start_time = $time;
		end
	endtask
    
	always @(posedge ready_in) begin
        if(count_in < NUM_TESTCASE) begin
            count_in <= count_in + 1    ;
        end
        else begin
            count_in <= count_in        ;
        end
        init  <=   1'b0                  ;
        in    <=   SCRYPT_IN[count_in + 1]   ;
        #(HALF_PERIOD_CLOCK*2*2)
        init  <=   1'b1                  ;
    end
    
	initial begin: main_test
		$display("Test starts!");
		init_task();
		reset_task(3'd5);
	end
		
endmodule 