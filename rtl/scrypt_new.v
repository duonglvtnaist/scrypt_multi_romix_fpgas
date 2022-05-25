module scrypt_new(
    input    wire                clk           ,   // clock signal
    input    wire                reset_n       ,   // reset negative signal
    input    wire                init          ,   // start signal
    input    wire    [639:0]     in            ,   // input scrypt
    output   wire    [255:0]     out_scrypt    ,   // output scrypt
    output   wire                valid
);

    //p1 declaration
    wire    [1023 : 0]        out_p1    ;
    wire    [255  : 0]        ixor_hash ;
    wire    [255  : 0]        oxor_hash ;
    wire                      valid_p1  ;
    wire    [1023 : 0]        out_p1_cvt;

    //rm declaration
    wire    [1023 : 0]         out_rm    ;  
    // wire                       keep_input;    
    wire                       valid_rm  ; 
    wire    [1023 : 0]         out_rm_cvt;    

    // instantation
    pbkdf2_1 p1(
    //input
    .clk        (clk        ),
    .reset_n    (reset_n    ),
    .init       (init       ),
    .in         (in         ),
    //output
    .out        (out_p1     ),
    .ixor_hash  (ixor_hash  ),
    .oxor_hash  (oxor_hash  ),
    .valid      (valid_p1   )
    );

    endianCvt rm_in(
    .in         (out_p1     ),
    .out        (out_p1_cvt )
    );

    romix rm(
    //input
    .clk        (clk        ),
    .reset_n    (reset_n    ),                
    .init       (valid_p1   ),        
    .in         (out_p1_cvt ),
    //output
    .out        (out_rm     ),
    // .keep_input (keep_input ),        
    .valid      (valid_rm   )
    );

    endianCvt rm_out(
    .in         (out_rm     ),
    .out        (out_rm_cvt )
    );

    pbkdf2_2 p2(
    //input
    .clk        (clk        ),
    .reset_n    (reset_n    ),
    .init       (valid_rm   ),
    .in         (out_rm_cvt ),
    .ixor_hash  (ixor_hash  ),
    .oxor_hash  (oxor_hash  ),
    //output
    .out        (out_scrypt ),
    .valid      (valid      )
    );
endmodule