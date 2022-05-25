module sha256_core_standard
	(
					input	wire 				clk,
					input	wire 				reset_n,
					input	wire 				init,
					input	wire	[511:0]		block_in,
					input	wire	[255:0]		prev_digest,
					input	wire 				first_block,
					output 	wire				digest_valid,
					output	wire 	[255:0]		digest
	);

	wire		t_ctr_init;
	wire		t_ctr_next;
	wire		digest_init;
	wire		loop_init;
	wire		loop_next;
	wire		w_init;
	wire		w_next;
	wire		stage_0;
	wire		stage_1;
	wire		stage_2;
	wire		stage_3;
	wire [31:0]	digest_0; 
	wire [31:0]	digest_1; 
	wire [31:0]	digest_2; 
	wire [31:0]	digest_3; 
	wire [31:0]	digest_4; 
	wire [31:0]	digest_5; 
	wire [31:0]	digest_6; 
	wire [31:0]	digest_7;
	wire 		t_ctr_last;
	reg	 [255:0] digest_reg;
	//Instances
		sha256_core_standard_fsm controller(
								.clk(clk)					,
								.reset_n(reset_n)			,
								.init(init)					,
								.t_ctr_last(t_ctr_last)		,
								.t_ctr_init(t_ctr_init)		,
								.t_ctr_next(t_ctr_next)		,
								.digest_init(digest_init)	,
								.loop_init(loop_init)		,
								.loop_next(loop_next)		,
								.w_init(w_init)				,
								.w_next(w_next)				,						
								.digest_valid(digest_valid)	
								);
		sha256_core_standard_datapath datapath(
								.clk(clk)					,
								.block_in(block_in)			,
								.first_block(first_block)	,
								.prev_digest(prev_digest)	,
								.t_ctr_init(t_ctr_init)		,
								.t_ctr_next(t_ctr_next)		,
								.digest_init(digest_init)	,
								.loop_init(loop_init)		,
								.loop_next(loop_next)		,
								.w_init(w_init)				,
								.w_next(w_next)				,
								.t_ctr_last(t_ctr_last)		,
								.digest_0(digest_0)			,
								.digest_1(digest_1)			,
								.digest_2(digest_2)			,
								.digest_3(digest_3)			,
								.digest_4(digest_4)			,
								.digest_5(digest_5)			,
								.digest_6(digest_6)			,
								.digest_7(digest_7)
		);
	assign digest = {digest_0, digest_1, digest_2, digest_3, digest_4, digest_5, digest_6, digest_7};
endmodule