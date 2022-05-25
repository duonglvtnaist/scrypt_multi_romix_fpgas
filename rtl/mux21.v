module mux21(in0,in1,sel,out);
	parameter DATA_WIDTH=32;
	input [DATA_WIDTH-1:0]in0;
	input [DATA_WIDTH-1:0]in1;
	input sel;
	output reg[DATA_WIDTH-1:0] out;
always@(*)	begin
		if(sel==0)
			out = in0;
	    else if(sel==1)
			out = in1;
		else 
			out = {{DATA_WIDTH}{1'bz}};
end
endmodule
