module up_counter_en(
	clk,
	RST_N,
	en,
	out
);
	parameter SIZE=5;
	input wire 	clk, RST_N, en;
	output wire [SIZE-1:0] out;
	wire [SIZE-1:0] counter_up_wire;
    reg [SIZE-1:0] counter_up;
    assign counter_up_wire = counter_up + 1'd1;

// up counter
always@ (posedge clk or negedge RST_N)begin
	if(RST_N == 1'b0)
		counter_up <= {{SIZE}{1'b0}};
	else if(en == 1'b1)
		counter_up <= counter_up_wire;
end

assign out = counter_up;

endmodule
