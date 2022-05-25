module pbkdf2_2(
	input	wire				clk			,	// clock signal
	input	wire				reset_n		,   // reset negative signal
	input	wire				init		,   // start signal
	input	wire	[1023:0]	in			,   // input pbkdf2_1
	input	wire	[255:0]		ixor_hash	,
	input	wire	[255:0]		oxor_hash	,
	output	wire	[255:0]		out			,   // output pbkdf2_1
	output	wire				valid
);

	wire			sha256_init				;
	wire			sha256_first_block		;
	wire	[1:0]	sel_block_in			;
	wire	[1:0]	sel_prev_hash			;
	wire			update_mem_0			;
    wire            store_i_o_hash          ;
	
	pbkdf2_2_dp datapath(
	// inputs
		.clk					(clk)						,
		.reset_n				(reset_n)					,
		.sha256_init			(sha256_init)				,
		.sha256_first_block		(sha256_first_block)		,
		.sel_block_in			(sel_block_in)				,
		.sel_prev_hash			(sel_prev_hash)				,
		.update_mem_0			(update_mem_0)				,
        .store_i_o_hash         (store_i_o_hash)            ,
		.in						(in)						,
		.ixor_hash				(ixor_hash)					,
		.oxor_hash				(oxor_hash)					,
	// outputs	
		.out					(out)						,
		.sha256_digest_valid	(sha256_digest_valid)		
	);
	
	pbkdf2_2_ct	controller(
	// inputs
		.clk					(clk)						,
		.reset_n				(reset_n)					,
		.init					(init)						,
		.sha256_digest_valid	(sha256_digest_valid)		,
	// outputs	
		.sha256_init			(sha256_init)				,
		.sha256_first_block		(sha256_first_block)		,
		.sel_block_in			(sel_block_in)				,
		.sel_prev_hash			(sel_prev_hash)				,
		.update_mem_0			(update_mem_0)				,
        .store_i_o_hash         (store_i_o_hash)            ,
		.valid					(valid)		
	);
endmodule