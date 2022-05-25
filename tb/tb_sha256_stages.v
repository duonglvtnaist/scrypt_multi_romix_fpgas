`timescale 1ns/1ns
module tb_sha256_stages();
		reg 			tb_clk;
		reg				tb_reset_n;
		reg				tb_init;
		reg [511:0]		tb_block_in;

		wire			tb_2_stage_digest_valid;
		wire [255:0]	tb_2_stage_digest;				
        wire			tb_3_stage_digest_valid;
		wire [255:0]	tb_3_stage_digest;		
		wire			tb_standard_digest_valid;
		wire [255:0]	tb_standard_digest;
		parameter START_GET_W = 4'd16;
		localparam BLOCK = 512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
		reg [31:0]		block_pieces 	[0:15];
		integer i;
		parameter HALF_PERIOD = 10;
		
		// Instances
		sha256_core_standard	standard_core(
						.clk(tb_clk),
						.reset_n(tb_reset_n),
						.init(tb_init),
						.block_in(tb_block_in),
						.prev_digest(256'd0),
						.first_block(1'b1),
						.digest_valid(tb_standard_digest_valid),
						.digest(tb_standard_digest)
						);		
        sha256_core_2_stage	core_2_stage(
						.clk(tb_clk),
						.reset_n(tb_reset_n),
						.init(tb_init),
						.block_in(tb_block_in),
						.prev_digest(256'd0),
						.first_block(1'b1),
						.digest_valid(tb_2_stage_digest_valid),
						.digest(tb_2_stage_digest)
						);
        sha256_core_3_stage	core_3_stage(
                .clk(tb_clk),
                .reset_n(tb_reset_n),
                .init(tb_init),
                .block_in(tb_block_in),
                .prev_digest(256'd0),
                .first_block(1'b1),
                .digest_valid(tb_3_stage_digest_valid),
                .digest(tb_3_stage_digest)
                );
// Clock generator	
	initial begin
		#0 tb_clk <= 1'b0;
		tb_block_in <= BLOCK;
	end
	integer start_time;
	integer first_done = 0;
	integer second_done = 0;

	always@(*) begin
		#(HALF_PERIOD) tb_clk <= ~tb_clk;
	end
	always@(*) begin
		if(tb_standard_digest_valid == 1'b1 && first_done == 0) begin
            $display("Standard core result: \t\t\t\t%x. Cycles: %f", tb_standard_digest, ($time - start_time)/(2*HALF_PERIOD));
			first_done = 1;
		end		
        if(tb_2_stage_digest_valid == 1'b1 && second_done == 0) begin
            $display("New 2 stage core result:  \t\t\t\t%x. Cycles: %f", tb_2_stage_digest, ($time - start_time)/(2*HALF_PERIOD));
			second_done = 1;
		end
		if(tb_3_stage_digest_valid == 1'b1 && tb_standard_digest_valid == 1'b1 && tb_2_stage_digest_valid == 1'b1) begin
			$display("New core 3 stage result: \t\t\t\t%x. Cycles: %f", tb_3_stage_digest, ($time - start_time)/(2*HALF_PERIOD));
            $display("Test completed!!!");
			$stop;
		end
	end
	task test();
		begin
			#0					tb_init <= 1'b0;
			#(2*HALF_PERIOD) 	tb_reset_n <= 1'b0;
			#(4*HALF_PERIOD) 	tb_reset_n <= 1'b1;
			#(6*HALF_PERIOD) 	tb_init <= 1'b1;
			start_time = $time;
		end
	endtask

	initial begin: main_test
		test();
	end
endmodule