module mux41(in0,in1,in2,in3,sel,out);
	
	parameter DATA_WIDTH = 32;
	
	input	wire	[DATA_WIDTH - 1:0]	in0,in1,in2,in3;
	input	wire	[1:0]	sel;
	output	wire	[DATA_WIDTH - 1:0]	out;
	
	reg		[DATA_WIDTH - 1:0]	temp;
	
	assign	out	= temp;
	
always@(*)
begin
	case(sel)
		2'd0:	temp = in0;
		2'd1:	temp = in1;
		2'd2:	temp = in2;
		2'd3:	temp = in3;	
	endcase
end

endmodule
	