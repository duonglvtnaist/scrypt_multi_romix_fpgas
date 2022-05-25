module romix_new(
		input 	wire	clk				        ,	// clock signal
		input	wire	reset_n			        ,   // reset negative signal
		input	wire	init			        ,   // start signal
		input	wire	[1023:0]	in	        ,	// input romix
        input   wire    [255:0]     ixor        ,
        input   wire    [255:0]     oxor        ,
        output  wire                ready       ,   // ready for new input
        output  wire    [255:0]     ixor_out    ,
        output  wire    [255:0]     oxor_out    ,
		output	wire	[1023:0]	out	        ,	// output romix
		output	wire	valid
);

	wire		blockmix_en		    ;
	wire		sel_mux_0		    ;
	wire		sel_mux_1		    ;
	wire		sel_mux_2		    ;
	wire		write_en		    ;
	wire		blockmix_valid	    ;
	wire		counter_reset_n	    ;
	wire		count_up		    ;
	wire		first_count		    ;
	wire		end_count		    ;
    wire        update_ixor_oxor    ;
	
	romix_new_dp datapath(
		// general inputs
		.clk			    (clk)				,
		.reset_n		    (reset_n)			,
		// inputs	    
		.counter_reset_n    (counter_reset_n)	, // reset counter signal
		.count_up		    (count_up)			,
		.blockmix_en	    (blockmix_en)		,
		.sel_mux_0		    (sel_mux_0)			, // select input source for mux 1
		.sel_mux_1		    (sel_mux_1)			, // select input source for mux 2
		.sel_mux_2		    (sel_mux_2)			, // select input source for blocmix
		.write_en		    (write_en)			,
		.valid			    (valid)				, // output valids
        .ixor               (ixor)              ,
        .oxor               (oxor)              ,
        .update_ixor_oxor   (update_ixor_oxor)  ,
		.in				    (in)				, // input string
		// outputs
		.blockmix_valid	    (blockmix_valid)	,
		.first_count	    (first_count)		,
		.end_count		    (end_count)			, // stop when the counter finishes its work
        .ixor_out           (ixor_out)          ,
        .oxor_out           (oxor_out)          ,
		.out			    (out)			
	);
	
	romix_new_ct	controller(
		// general inputs
		.clk			    (clk)				,
		.init			    (init)				,
		.reset_n		    (reset_n)			,
		// inputs	    
		.blockmix_valid	    (blockmix_valid)	,
		.first_count	    (first_count)		,
		.end_count		    (end_count)			, // stop when the counter finishes its work
		// outputs	
        .ready              (ready)             ,
		.update_ixor_oxor   (update_ixor_oxor)  ,
		.counter_reset_n    (counter_reset_n)	, // reset counter signal
		.count_up		    (count_up)			,
		.blockmix_en	    (blockmix_en)		,
		.sel_mux_0		    (sel_mux_0)			, // select input source for mux 1
		.sel_mux_1		    (sel_mux_1)			, // select input source for mux 2
		.sel_mux_2		    (sel_mux_2)			, // select input source for blocmix
		.write_en		    (write_en)			,
		.valid			    (valid)				  // output valids
	);

endmodule