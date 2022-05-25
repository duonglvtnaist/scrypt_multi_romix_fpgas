//`include "../rtl/endianCvt32.v"
//`define IDX(x) (((x)+(1))*(32)-(1)):((x)*(32))	//index
module endianCvt(in, out);
	input	wire	[1023:0]in;
	output	wire	[1023:0]out;
	// ins
genvar i;
generate for (i = 0 ; i < 32 ; i = i + 1) begin: GEN_ENDIAN
	endianCvt32 en(
				in [((i+1)*(32)-1):((i)*(32))],
				out[((i+1)*(32)-1):((i)*(32))]
				);
	end
endgenerate

endmodule
	