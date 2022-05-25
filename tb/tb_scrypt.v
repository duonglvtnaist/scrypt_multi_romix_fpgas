	//tb pbk1st
	`timescale 1ns/1ps
	module tb_scrypt;
		parameter	WIDTH_IN		= 640;
		parameter	WIDTH_OUT		= 256;
		parameter	NUM_TESTCASE	= 3;
		parameter	CLK_PULSE		= 5;
	// port of design
		reg								clk, rst_n, start;
		wire 							valid_out, scrypt_ready;
		reg		[WIDTH_IN - 1 :0]		blockheader;
		//reg		[(WIDTH_IN/2) - 1 :0]	block_piece;
		reg								valid_in, out_ready;
		wire 	[WIDTH_OUT - 1:0] 		out;
	// captured data
		reg 	[WIDTH_IN - 1:0]		SCRYPT_IN		[0:NUM_TESTCASE-1];
		reg 	[WIDTH_OUT - 1:0]		SCRYPT_OUT		[0:NUM_TESTCASE-1];
		integer 						out_count		=	0;
		integer 						num_error		=	0;
		integer 						in_count		=	0;
		integer 						clk_count		=	0;
		integer 						done_count 		= 	0;
		integer 						correct_case 	= 	0;
		//reg								data_in;
		//wire							data_change;
	// clock generation
	initial
		#0 clk = 1'b0;
	initial forever	#(CLK_PULSE) clk = ~clk;
	// datait value
	initial begin
		#0 start =1'b0;
		#0 out_ready =1'b0;
		#0 valid_in = 1'b0;
		//#0 block[0]	= [319:0] SCRYPT_IN [0];
		//#0 block[1]	= [639:320] SCRYPT_IN [0];
		//#10 data = SCRYPT_IN[0];
		#0 	rst_n	=	1'b0;
		#250 	rst_n	=	1'b1;	
		#0 	out_ready	=	1'b1;	
		#0 		start	=	1'b1;	
		in_count <= 0;
			num_error <= 0;
			out_count <= 0;
			done_count <= 0;
			correct_case <= 0;
			clk_count <= 0;
			valid_in <= 0;
	end
	// read file

	 initial begin
		$readmemh("D:/Proposed Litecoin_20_6/Proposed Litecoin_20_6/Testcases/BlockHeader.txt", SCRYPT_IN);
		$readmemh("D:/Proposed Litecoin_20_6/Proposed Litecoin_20_6/Testcases/ScryptOut.txt", SCRYPT_OUT);
	end
	// 319:0 639:320
	// assign to ports = data from file
	always@(posedge clk) begin
		if(rst_n == 1'b0) begin
			in_count <= 0;
			num_error <= 0;
			out_count <= 0;
			done_count <= 0;
			correct_case <= 0;
			clk_count <= 0;
			valid_in <= 0;
		end
		else if (scrypt_ready == 1'b1) begin
			blockheader <= SCRYPT_IN[in_count];
			valid_in <= 1'b1;
			in_count <= in_count + 1;
		end	
		else	
			valid_in <= 1'b0;
	end

	// compare
	always@(valid_out) begin
		if(valid_out == 1'b1) begin
			done_count 	<= 	done_count 	+ 	1;
			if (done_count == NUM_TESTCASE )
				begin
					#1 $finish;
				end
		end		
	end

	always @(posedge valid_out) 
	begin
		#2 $display("\n T=%g | rst=%b | clock=%b | start=%b | valid_out=%b",$time,rst_n,clk,start,valid_out);
		$display("VERILOG_Out= \n%h \n MATLAB_Out=\n%h",out,SCRYPT_OUT[out_count]);
		if (out != SCRYPT_OUT[out_count])
			begin 
				num_error=num_error+1;
				$display("\t\t --Error--");
			end
		else if (out == SCRYPT_OUT[out_count])
			begin 
				correct_case=correct_case+1;
				$display("\t\t --Correct--");
			end
		out_count=out_count+1;
		if ((out_count==NUM_TESTCASE)&&(num_error==0)) 
			begin
				correct_case = done_count + 1;
				$display("\n-------------------------------------- SIMULATION REPORT ----------------------------------------------------");
				$display("\n--- Correct Cases %d of %d. \t Fail Cases : %d \t No fail case found ---",correct_case,NUM_TESTCASE,num_error);
				$display("\n--- Number of cycle: %d                                                ---",clk_count);
				$display("\n------------------------------------- ALL DATA ARE CORRECT --------------------------------------------------");
			end
		else if ((out_count==NUM_TESTCASE)&&(num_error>0)) 
			begin
				$display("\n-------------------------------------- SIMULATION REPORT ----------------------------------------------------");
				$display("\n---  Correct Cases %d of %d . \t Fail Cases : %d \t Fail case found  ---",correct_case,NUM_TESTCASE,num_error);
				$display("\n------------------------------------- ERROR WAS FOUND -------------------------------------------------------");
			end
		clk_count=0;	
	end
	// clock counter
	always @(posedge clk) begin
		if(start!=1)
			clk_count=0;
		else
			clk_count=clk_count+1;
	end
	// design under test
	scrypt_ipcore	dut(clk, rst_n, blockheader, valid_in, out_ready, scrypt_ready, out, valid_out);
	//scrypt_newdp	dut(clk, rst_n, start, valid_in, scrypt_ready, valid_out,  blockheader, out);
	//scrypt_newdp	dut(clk, rst_n, start, done, data, out);
	//scrypt_newdp	dut(clk, rst_n, start, data_in, data_request0, data_request1, data_change, done,  block_piece, out);
	endmodule 