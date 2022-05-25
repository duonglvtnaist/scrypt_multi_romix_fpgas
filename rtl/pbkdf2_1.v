module pbkdf2_1(
	input	wire				clk			,	// clock signal
	input	wire				reset_n		,   // reset negative signal
	input	wire				init		,   // start signal
	input	wire	[639:0]		in			,   // input pbkdf2_1
	output	wire	[1023:0]	out			,   // output pbkdf2_1
	output	wire	[255:0]		ixor_hash	,
	output	wire	[255:0]		oxor_hash	,
	output	wire				valid
);

	wire			sha256_init				;
	wire			sha256_first_block		;
	wire	[1:0]	sel_block_in_i_hash		;
	wire			sel_block_in_o_hash		;
	wire			sel_block_in			;
	wire	[1:0]	sel_prev_hash			;
	wire			update_mem_0			;
	wire			update_mem_1			;
	wire			update_out_4			;
	wire			update_out_3			;
	wire			update_out_2			;
	wire			update_out_1			;
	wire	[2:0]	index					;
	
	pbkdf2_1_dp datapath(
	// inputs
		.clk					(clk)						,
		.reset_n				(reset_n)					,
		.sha256_init			(sha256_init)				,
		.sha256_first_block		(sha256_first_block)		,
		.sel_block_in_i_hash	(sel_block_in_i_hash)		,
		.sel_block_in_o_hash	(sel_block_in_o_hash)		,
		.sel_block_in			(sel_block_in)				,
		.sel_prev_hash			(sel_prev_hash)				,
		.update_mem_0			(update_mem_0)				,
		.update_mem_1			(update_mem_1)				,
		.update_ixor_mem		(update_ixor_mem)			,
		.update_oxor_mem		(update_oxor_mem)			,
		.update_out_4			(update_out_4)				,
		.update_out_3			(update_out_3)				,
		.update_out_2			(update_out_2)				,
		.update_out_1			(update_out_1)				,
		.index					(index)						,
		.in						(in)						,
	// outputs	
		.out					(out)						,
		.ixor_hash				(ixor_hash)					,
		.oxor_hash				(oxor_hash)					,
		.sha256_digest_valid	(sha256_digest_valid)		
	);
	
	pbkdf2_1_ct	controller(
	// inputs
		.clk					(clk)						,
		.reset_n				(reset_n)					,
		.init					(init)						,
		.sha256_digest_valid	(sha256_digest_valid)		,
	// outputs	
		.sha256_init			(sha256_init)				,
		.sha256_first_block		(sha256_first_block)		,
		.sel_block_in_i_hash	(sel_block_in_i_hash)		,
		.sel_block_in_o_hash	(sel_block_in_o_hash)		,
		.sel_block_in			(sel_block_in)				,
		.sel_prev_hash			(sel_prev_hash)				,
		.update_mem_0			(update_mem_0)				,
		.update_mem_1			(update_mem_1)				,
		.update_ixor_mem		(update_ixor_mem)			,
		.update_oxor_mem		(update_oxor_mem)			,
		.update_out_4			(update_out_4)				,
        .update_out_3			(update_out_3)				,
        .update_out_2			(update_out_2)				,
        .update_out_1			(update_out_1)				,
		.index					(index)						,
		.valid					(valid)		
	);
endmodule