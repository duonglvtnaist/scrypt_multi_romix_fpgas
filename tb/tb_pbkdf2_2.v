`timescale 1ns/1ps
module tb_pbkdf2_2();
		reg					clk			;
		reg					init		;
		reg					reset_n		;
		reg		[1023:0]	in_pbdkf2	;
		reg		[639:0]		in			;
		reg					valid_in	;
		reg		[255:0]		ixor_hash	;
		reg		[255:0]		oxor_hash	;
		wire	[255:0]		out			;
		wire				valid		;
		wire				out_ready	;
		wire				scrypt_ready;
		wire	[255:0]		out_scrypt	;
		wire				valid_scrypt;

	pbkdf2_2	pbdkf2_2_ip(
				.clk			(clk)			,	// clock signal
				.reset_n		(reset_n)		,   // reset negative signal
				.init			(init)			,   // start signal
				.in				(in_pbdkf2)		,   // input pbkdf2_1
				.ixor_hash		(ixor_hash)		,
				.oxor_hash		(oxor_hash)		,
				.out			(out)			,   // output pbkdf2_1
				.valid			(valid)
	);
	
	scrypt_newdp	scrypt_ip(	.clk				(clk)			, 
								.rst_n				(reset_n)		,
								.start				(init)			,
								.blockheader		(in)			, 
								.valid_in			(valid_in)		, 
								.outScrypt			(out_scrypt)	, 
								.scrypt_ready		(scrypt_ready)	, 
								.valid_out			(valid_scrypt)
								);

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

		if(valid == 1'd1 && display_pbdkf2 == 1) begin
			display_pbdkf2 = 0;
			$display("Output new pbdkf2_2: %x cycle: %f", out, ($time-start_time)/(HALF_PERIOD_CLOCK*2));
		end
		if(valid_scrypt == 1'b1) begin
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
			valid_in 	= 1'b0;
			in			= 640'h0000002056efd1943684c1fdc247d4759cc43b29afa1cac7ad14579de5f6abcbc6bdf448ee3de4c7b45e9496ab41ecde73d1a299ddbcc7a81aa52776e6c067e214233af097b6885c97df011aa004090e;
			in_pbdkf2	= 1024'hb2b80d34d1cfc24db605fe2dd5917248f25b11c9c405d57e351dc2bd970d48b9bce3857be5b0e22a3b1d96a4fc28526596dd0221be6e62ecd4b969fa7eb1fbf0dd1e05258b7558e7e67f25f273a542cf67fa30f882e9c6bc8cb7aa11c4444cab5dfafa619c852b84166923039d5c7a72147088739af4be67433e7197134ef52b;
			ixor_hash	= 256'ha7190a1a27dee7ca5496ee5bf27e931ed7c65573bee86d2353d8dc7dfa7c81ef;
			oxor_hash	= 256'h6bcf609bdf4a0747f175297285f68df58cc357d87eff39d1cfe477b97736cee3;
		end
	endtask
	
	task reset_task (input reg[7:0] num_delay);
		begin
			#(HALF_PERIOD_CLOCK*2*num_delay) 	reset_n <= 1'b1;
			#(HALF_PERIOD_CLOCK*2)				init <= 1'b1;
			valid_in <= 1'b1;
			start_time = $time;
			#(HALF_PERIOD_CLOCK*2*2)				init <= 1'b0;
		end
	endtask
	
	initial begin: main_test
		$display("Test starts!");
		init_task();
		reset_task(3'd5);
	end
		
endmodule 