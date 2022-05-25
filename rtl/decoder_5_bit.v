module decoder_5_bit(
       input    wire            en  ,
       input    wire    [4:0]   sel ,
       output   wire    [31:0]  out

);
    parameter out_1 = 32'd1;
    reg [31:0]  out_reg;
    assign out = (en == 1'b1) ? out_reg: 32'd0;
    
    
    always@(sel)
    begin
        case(sel)
            5'd0    : out_reg = out_1           ;
            5'd1    : out_reg = out_1  <<  1    ;
            5'd2    : out_reg = out_1  <<  2    ;
            5'd3    : out_reg = out_1  <<  3    ;
            5'd4    : out_reg = out_1  <<  4    ;
            5'd5    : out_reg = out_1  <<  5    ;
            5'd6    : out_reg = out_1  <<  6    ;
            5'd7    : out_reg = out_1  <<  7    ;
            5'd8    : out_reg = out_1  <<  8    ;
            5'd9    : out_reg = out_1  <<  9    ;
            5'd10   : out_reg = out_1  <<  10   ;
            5'd11   : out_reg = out_1  <<  11   ;
            5'd12   : out_reg = out_1  <<  12   ;
            5'd13   : out_reg = out_1  <<  13   ;
            5'd14   : out_reg = out_1  <<  14   ;
            5'd15   : out_reg = out_1  <<  15   ;
            5'd16   : out_reg = out_1  <<  16   ;
            5'd17   : out_reg = out_1  <<  17   ;
            5'd18   : out_reg = out_1  <<  18   ;
            5'd19   : out_reg = out_1  <<  19   ;
            5'd20   : out_reg = out_1  <<  20   ;
            5'd21   : out_reg = out_1  <<  21   ;
            5'd22   : out_reg = out_1  <<  22   ;
            5'd23   : out_reg = out_1  <<  23   ;
            5'd24   : out_reg = out_1  <<  24   ;
            5'd25   : out_reg = out_1  <<  25   ;
            5'd26   : out_reg = out_1  <<  26   ;
            5'd27   : out_reg = out_1  <<  27   ;
            5'd28   : out_reg = out_1  <<  28   ;
            5'd29   : out_reg = out_1  <<  29   ;
            5'd30   : out_reg = out_1  <<  30   ;
            5'd31   : out_reg = out_1  <<  31   ;
            default : out_reg = 32'd0;
            
        endcase
    end
endmodule