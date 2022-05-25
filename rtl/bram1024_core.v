/* B-RAM */
module bram1024_core #(parameter ADDR_WIDTH = 10, DATA_WIDTH = 1024, DEPTH = 1024) (
    input wire i_clk,
    input wire [ADDR_WIDTH-1:0] i_addr, 
    input wire i_write,
//    input wire i_read,
    input wire [DATA_WIDTH-1:0] i_data,
    output wire [DATA_WIDTH-1:0] o_data
//    output reg [DATA_WIDTH-1:0] o_data
    );
    reg [DATA_WIDTH-1:0] memory_array [0:DEPTH-1];
	reg [DATA_WIDTH-1:0] o_data_reg;
	assign o_data = o_data_reg;
    always @ (posedge i_clk) begin
	    o_data_reg <= memory_array [i_addr];
//	    o_data <= memory_array [i_addr];
        if(i_write==1'b1) begin
            memory_array[i_addr] <= i_data;
        end
    end
endmodule
/* B-RAM with READ */
/* module bram1024_syn_read#(parameter ADDR_WIDTH = 10, DATA_WIDTH = 1024, DEPTH = 1024) (
    input wire i_clk,
//    input wire i_rst_n,
    input wire [ADDR_WIDTH-1:0] i_addr, 
    input wire i_write,
    input wire i_read,
    input wire [DATA_WIDTH-1:0] i_data,
    output wire [DATA_WIDTH-1:0] o_data
    );
	//temp
	wire [DATA_WIDTH-1:0]o_data_temp;
	reg  [DATA_WIDTH-1:0]o_data_reg;
	//instance
	bram1024_core#(ADDR_WIDTH, DATA_WIDTH, DEPTH) sr_core(
			i_clk,
			i_addr, i_write,
			i_data, o_data_temp
    );
	//read
	always@(posedge i_clk) begin
		if(i_read==1'b1)
			o_data_reg	<=	o_data_temp;
	end
	assign	o_data	= o_data_reg;
endmodule */