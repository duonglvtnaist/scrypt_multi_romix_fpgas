module romix_dp (
		input 	wire				clk				,
		input	wire				reset_n			,
		input	wire				counter_reset_n	,
		input	wire				count_up		,
		input	wire				blockmix_en		,
		input	wire				sel_mux_0		,
		input	wire				sel_mux_1		,
		input	wire				sel_mux_2		,
		input	wire				write_en		,
		input	wire				valid			,
		input	wire	[1023:0]	in				,
		
		output	wire				blockmix_valid	,
		output	wire				first_count		,
		output	wire				end_count		,
		output	wire	[1023:0]	out
);
	// Wires
	
	wire	[1023:0] 	blockmix_out_wire	;
	wire	[1023:0]	mux_0_out_wire		;
	wire	[1023:0]	mux_1_out_wire		;
	wire	[9:0]		mux_2_out_wire		;
	wire	[1023:0]	xor_wire			;
	wire	[9:0]		counter_out_wire	;
	wire	[9:0]		addr_read_wire		;
	wire	[1023:0]	mem_out_wire		;
	
	reg		[9:0]		addr_address_reg	;
	
	assign	addr_read_wire = addr_address_reg;
	// Instances
	
	// Mux	
	mux21#(1024) mux_0(		.in0(in)					, 
							.in1(blockmix_out_wire)		,
							.sel(sel_mux_0)				,
							.out(mux_0_out_wire)
					);
	mux21#(1024) mux_1(	
							.in0(mux_0_out_wire)		,
							.in1(xor_wire)				,
							.sel(sel_mux_1)				,
							.out(mux_1_out_wire)		
					);
	mux21#(10) mux_2(		.in0(counter_out_wire)		,
							.in1(addr_read_wire)		,
							.sel(sel_mux_2)				,
							.out(mux_2_out_wire)
					);
	// Memory
	
	bram1024_core #(10, 1024, 1024) memory (
							.i_clk	(clk)				,
							.i_addr	(mux_2_out_wire)	, 
							.i_data	(mux_0_out_wire)	,
							.i_write(write_en)			,
							.o_data	(mem_out_wire)
					);	
	
	// Up counter
	up_counter_en#(10) counter(
					.clk	(clk)				,
					.RST_N	(counter_reset_n)	,
					.en		(count_up)			,
					.out	(counter_out_wire)
				);
	assign first_count = (counter_out_wire == 10'd0) ? 1'b1 : 1'b0;
	assign end_count = (counter_out_wire == 10'd1023) ? 1'b1 : 1'b0;	
	// Blockmix
	
	blockmix_dpct blockmix (
				.clk		(clk),
				.init		(blockmix_en),
				.reset_n	(reset_n),
				.in			(mux_1_out_wire),
				.out		(blockmix_out_wire),
				.valid		(blockmix_valid)
	);
	// Xor	
	assign xor_wire = blockmix_out_wire ^ mem_out_wire;
	
	assign out = (valid == 1'b1) ? blockmix_out_wire : 1024'd0;
	
	always @(posedge clk or negedge reset_n) begin
		if(reset_n == 1'b0) begin
			addr_address_reg <= 10'd0;
		end
		else begin
			addr_address_reg <= blockmix_out_wire[489:480];
		end
	end
	
endmodule
	
	
	