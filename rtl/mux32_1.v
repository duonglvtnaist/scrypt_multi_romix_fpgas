module mux32_1 #(parameter DATA_WIDTH=32)(
       input    wire    [DATA_WIDTH-1:0]  in_0      ,
       input    wire    [DATA_WIDTH-1:0]  in_1      ,
       input    wire    [DATA_WIDTH-1:0]  in_2      ,
       input    wire    [DATA_WIDTH-1:0]  in_3      ,
       input    wire    [DATA_WIDTH-1:0]  in_4      ,
       input    wire    [DATA_WIDTH-1:0]  in_5      ,
       input    wire    [DATA_WIDTH-1:0]  in_6      ,
       input    wire    [DATA_WIDTH-1:0]  in_7      ,
       input    wire    [DATA_WIDTH-1:0]  in_8      ,
       input    wire    [DATA_WIDTH-1:0]  in_9      ,
       input    wire    [DATA_WIDTH-1:0]  in_10     ,
       input    wire    [DATA_WIDTH-1:0]  in_11     ,
       input    wire    [DATA_WIDTH-1:0]  in_12     ,
       input    wire    [DATA_WIDTH-1:0]  in_13     ,
       input    wire    [DATA_WIDTH-1:0]  in_14     ,
       input    wire    [DATA_WIDTH-1:0]  in_15     ,
       input    wire    [DATA_WIDTH-1:0]  in_16     ,
       input    wire    [DATA_WIDTH-1:0]  in_17     ,
       input    wire    [DATA_WIDTH-1:0]  in_18     ,
       input    wire    [DATA_WIDTH-1:0]  in_19     ,
       input    wire    [DATA_WIDTH-1:0]  in_20     ,
       input    wire    [DATA_WIDTH-1:0]  in_21     ,
       input    wire    [DATA_WIDTH-1:0]  in_22     ,
       input    wire    [DATA_WIDTH-1:0]  in_23     ,
       input    wire    [DATA_WIDTH-1:0]  in_24     ,
       input    wire    [DATA_WIDTH-1:0]  in_25     ,
       input    wire    [DATA_WIDTH-1:0]  in_26     ,
       input    wire    [DATA_WIDTH-1:0]  in_27     ,
       input    wire    [DATA_WIDTH-1:0]  in_28     ,
       input    wire    [DATA_WIDTH-1:0]  in_29     ,
       input    wire    [DATA_WIDTH-1:0]  in_30     ,
       input    wire    [DATA_WIDTH-1:0]  in_31     ,
       input    wire    [4:0]             sel       ,
       output   wire    [DATA_WIDTH-1:0]  out

);
    reg [DATA_WIDTH-1:0]  out_reg;
    assign out = out_reg;
    
    
    always@(*)
    begin
        case(sel)
            5'd0    : out_reg = in_0      ;
            5'd1    : out_reg = in_1      ;
            5'd2    : out_reg = in_2      ;
            5'd3    : out_reg = in_3      ;
            5'd4    : out_reg = in_4      ;
            5'd5    : out_reg = in_5      ;
            5'd6    : out_reg = in_6      ;
            5'd7    : out_reg = in_7      ;
            5'd8    : out_reg = in_8      ;
            5'd9    : out_reg = in_9      ;
            5'd10   : out_reg = in_10     ;
            5'd11   : out_reg = in_11     ;
            5'd12   : out_reg = in_12     ;
            5'd13   : out_reg = in_13     ;
            5'd14   : out_reg = in_14     ;
            5'd15   : out_reg = in_15     ;
            5'd16   : out_reg = in_16     ;
            5'd17   : out_reg = in_17     ;
            5'd18   : out_reg = in_18     ;
            5'd19   : out_reg = in_19     ;
            5'd20   : out_reg = in_20     ;
            5'd21   : out_reg = in_21     ;
            5'd22   : out_reg = in_22     ;
            5'd23   : out_reg = in_23     ;
            5'd24   : out_reg = in_24     ;
            5'd25   : out_reg = in_25     ;
            5'd26   : out_reg = in_26     ;
            5'd27   : out_reg = in_27     ;
            5'd28   : out_reg = in_28     ;
            5'd29   : out_reg = in_29     ;
            5'd30   : out_reg = in_30     ;
            5'd31   : out_reg = in_31     ;
            default : out_reg = 32'd0;
            
        endcase
    end
endmodule