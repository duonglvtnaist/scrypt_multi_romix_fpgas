module first_up_counter_for_romix(
    input   wire            clk     ,
    input   wire            reset_n ,
    input   wire            en      ,
    output   wire    [4:0]   out

);

	wire    [4:0]   counter_up_wire;
	reg     [4:0]   counter_up;
    assign counter_up_wire  = counter_up + 5'd1 ;
    assign out              = counter_up        ;
    // up counter
    always@ (posedge clk or negedge reset_n)begin
        if(reset_n == 1'b0)
            counter_up <= 5'd0;
        else if(en == 1'b1)
            counter_up <= counter_up_wire;
    end

endmodule
