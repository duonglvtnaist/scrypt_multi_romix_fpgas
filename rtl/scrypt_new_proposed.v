module scrypt_new_proposed(
    input    wire                clk           ,   // clock signal
    input    wire                reset_n       ,   // reset negative signal
    input    wire                init          ,   // start signal
    input    wire    [639:0]     in            ,   // input scrypt
    output   wire    [255:0]     out_scrypt    ,   // output scrypt   
    output   wire                ready_in      ,               
    output   wire                valid
);

    //p1 declaration
    wire    [1023 : 0]         out_p1    ;
    wire    [255  : 0]         ixor_hash ;
    wire    [255  : 0]         oxor_hash ;
    wire    [1023 : 0]         out_p1_cvt;
    wire                       valid_p1  ;
    //rm declaration
    wire    [1023 : 0]         out_rm_0     ;    
    wire    [1023 : 0]         out_rm_1     ;    
    wire    [1023 : 0]         out_rm_2     ;    
    wire    [1023 : 0]         out_rm_3     ;
    wire    [1023 : 0]         out_rm_4     ;    
    wire    [1023 : 0]         out_rm_5     ;    
    wire    [1023 : 0]         out_rm_6     ;    
    wire    [1023 : 0]         out_rm_7     ; 
    wire    [1023 : 0]         out_rm_8     ;    
    wire    [1023 : 0]         out_rm_9     ;    
    wire    [1023 : 0]         out_rm_10    ;    
    wire    [1023 : 0]         out_rm_11    ;
    wire    [1023 : 0]         out_rm_12    ;    
    wire    [1023 : 0]         out_rm_13    ;    
    wire    [1023 : 0]         out_rm_14    ;    
    wire    [1023 : 0]         out_rm_15    ; 
    wire    [1023 : 0]         out_rm_16    ;    
    wire    [1023 : 0]         out_rm_17    ;    
    wire    [1023 : 0]         out_rm_18    ;    
    wire    [1023 : 0]         out_rm_19    ;
    wire    [1023 : 0]         out_rm_20    ;    
    wire    [1023 : 0]         out_rm_21    ;    
    wire    [1023 : 0]         out_rm_22    ;    
    wire    [1023 : 0]         out_rm_23    ; 
    wire    [1023 : 0]         out_rm_24    ;    
    wire    [1023 : 0]         out_rm_25    ;    
    wire    [1023 : 0]         out_rm_26    ;    
    wire    [1023 : 0]         out_rm_27    ;
    wire    [1023 : 0]         out_rm_28    ;    
    wire    [1023 : 0]         out_rm_29    ;    
    wire    [1023 : 0]         out_rm_30    ;    
    wire    [1023 : 0]         out_rm_31    ;    
    wire                       valid_rm_0   ; 
    wire                       valid_rm_1   ; 
    wire                       valid_rm_2   ; 
    wire                       valid_rm_3   ;  
    wire                       valid_rm_4   ; 
    wire                       valid_rm_5   ; 
    wire                       valid_rm_6   ; 
    wire                       valid_rm_7   ;    
    wire                       valid_rm_8   ; 
    wire                       valid_rm_9   ; 
    wire                       valid_rm_10  ; 
    wire                       valid_rm_11  ;    
    wire                       valid_rm_12  ; 
    wire                       valid_rm_13  ; 
    wire                       valid_rm_14  ; 
    wire                       valid_rm_15  ;    
    wire                       valid_rm_16  ; 
    wire                       valid_rm_17  ; 
    wire                       valid_rm_18  ; 
    wire                       valid_rm_19  ;    
    wire                       valid_rm_20  ; 
    wire                       valid_rm_21  ; 
    wire                       valid_rm_22  ; 
    wire                       valid_rm_23  ;    
    wire                       valid_rm_24  ; 
    wire                       valid_rm_25  ; 
    wire                       valid_rm_26  ; 
    wire                       valid_rm_27  ;    
    wire                       valid_rm_28  ; 
    wire                       valid_rm_29  ; 
    wire                       valid_rm_30  ; 
    wire                       valid_rm_31  ; 
    wire    [1023 : 0]         out_rm_cvt_0 ;    
    wire    [1023 : 0]         out_rm_cvt_1 ;    
    wire    [1023 : 0]         out_rm_cvt_2 ;    
    wire    [1023 : 0]         out_rm_cvt_3 ;  
    wire    [1023 : 0]         out_rm_cvt_4 ;    
    wire    [1023 : 0]         out_rm_cvt_5 ;    
    wire    [1023 : 0]         out_rm_cvt_6 ;    
    wire    [1023 : 0]         out_rm_cvt_7 ; 
    wire    [1023 : 0]         out_rm_cvt_8 ;    
    wire    [1023 : 0]         out_rm_cvt_9 ;    
    wire    [1023 : 0]         out_rm_cvt_10;    
    wire    [1023 : 0]         out_rm_cvt_11;  
    wire    [1023 : 0]         out_rm_cvt_12;    
    wire    [1023 : 0]         out_rm_cvt_13;    
    wire    [1023 : 0]         out_rm_cvt_14;    
    wire    [1023 : 0]         out_rm_cvt_15; 
    wire    [1023 : 0]         out_rm_cvt_16;    
    wire    [1023 : 0]         out_rm_cvt_17;    
    wire    [1023 : 0]         out_rm_cvt_18;    
    wire    [1023 : 0]         out_rm_cvt_19;  
    wire    [1023 : 0]         out_rm_cvt_20;    
    wire    [1023 : 0]         out_rm_cvt_21;    
    wire    [1023 : 0]         out_rm_cvt_22;    
    wire    [1023 : 0]         out_rm_cvt_23; 
    wire    [1023 : 0]         out_rm_cvt_24;    
    wire    [1023 : 0]         out_rm_cvt_25;    
    wire    [1023 : 0]         out_rm_cvt_26;    
    wire    [1023 : 0]         out_rm_cvt_27;  
    wire    [1023 : 0]         out_rm_cvt_28;    
    wire    [1023 : 0]         out_rm_cvt_29;    
    wire    [1023 : 0]         out_rm_cvt_30;    
    wire    [1023 : 0]         out_rm_cvt_31;
    wire    [255  : 0]         ixor_hash_0  ;
    wire    [255  : 0]         ixor_hash_1  ;
    wire    [255  : 0]         ixor_hash_2  ;
    wire    [255  : 0]         ixor_hash_3  ;
    wire    [255  : 0]         ixor_hash_4  ;
    wire    [255  : 0]         ixor_hash_5  ;
    wire    [255  : 0]         ixor_hash_6  ;
    wire    [255  : 0]         ixor_hash_7  ;
    wire    [255  : 0]         ixor_hash_8  ;
    wire    [255  : 0]         ixor_hash_9  ;
    wire    [255  : 0]         ixor_hash_10 ;
    wire    [255  : 0]         ixor_hash_11 ;
    wire    [255  : 0]         ixor_hash_12 ;
    wire    [255  : 0]         ixor_hash_13 ;
    wire    [255  : 0]         ixor_hash_14 ;
    wire    [255  : 0]         ixor_hash_15 ;
    wire    [255  : 0]         ixor_hash_16 ;
    wire    [255  : 0]         ixor_hash_17 ;
    wire    [255  : 0]         ixor_hash_18 ;
    wire    [255  : 0]         ixor_hash_19 ;
    wire    [255  : 0]         ixor_hash_20 ;
    wire    [255  : 0]         ixor_hash_21 ;
    wire    [255  : 0]         ixor_hash_22 ;
    wire    [255  : 0]         ixor_hash_23 ;
    wire    [255  : 0]         ixor_hash_24 ;
    wire    [255  : 0]         ixor_hash_25 ;
    wire    [255  : 0]         ixor_hash_26 ;
    wire    [255  : 0]         ixor_hash_27 ;
    wire    [255  : 0]         ixor_hash_28 ;
    wire    [255  : 0]         ixor_hash_29 ;
    wire    [255  : 0]         ixor_hash_30 ;
    wire    [255  : 0]         ixor_hash_31 ;
    wire    [255  : 0]         oxor_hash_0  ;
    wire    [255  : 0]         oxor_hash_1  ;
    wire    [255  : 0]         oxor_hash_2  ;
    wire    [255  : 0]         oxor_hash_3  ;
    wire    [255  : 0]         oxor_hash_4  ;
    wire    [255  : 0]         oxor_hash_5  ;
    wire    [255  : 0]         oxor_hash_6  ;
    wire    [255  : 0]         oxor_hash_7  ;
    wire    [255  : 0]         oxor_hash_8  ;
    wire    [255  : 0]         oxor_hash_9  ;
    wire    [255  : 0]         oxor_hash_10 ;
    wire    [255  : 0]         oxor_hash_11 ;
    wire    [255  : 0]         oxor_hash_12 ;
    wire    [255  : 0]         oxor_hash_13 ;
    wire    [255  : 0]         oxor_hash_14 ;
    wire    [255  : 0]         oxor_hash_15 ;
    wire    [255  : 0]         oxor_hash_16 ;
    wire    [255  : 0]         oxor_hash_17 ;
    wire    [255  : 0]         oxor_hash_18 ;
    wire    [255  : 0]         oxor_hash_19 ;
    wire    [255  : 0]         oxor_hash_20 ;
    wire    [255  : 0]         oxor_hash_21 ;
    wire    [255  : 0]         oxor_hash_22 ;
    wire    [255  : 0]         oxor_hash_23 ;
    wire    [255  : 0]         oxor_hash_24 ;
    wire    [255  : 0]         oxor_hash_25 ;
    wire    [255  : 0]         oxor_hash_26 ;
    wire    [255  : 0]         oxor_hash_27 ;
    wire    [255  : 0]         oxor_hash_28 ;
    wire    [255  : 0]         oxor_hash_29 ;
    wire    [255  : 0]         oxor_hash_30 ;
    wire    [255  : 0]         oxor_hash_31 ;

    
    //counter regs
    wire     [4:0]               first_counter      ;
    wire     [4:0]               second_counter     ;
    
    // start romix
    wire    [31:0]              romix_init_wire     ;
    wire                        ready_wires [0:31]  ;
    wire                        valid_rm            ;
    wire    [1023:0]            out_rm_cvt          ;
    wire    [255:0]             ixor_romix          ;
    wire    [255:0]             oxor_romix          ;
    
    // Assignments
assign valid_rm = valid_rm_0  | valid_rm_1  | valid_rm_2  | valid_rm_3  | valid_rm_4  | valid_rm_5  | valid_rm_6  | valid_rm_7  | valid_rm_8  | valid_rm_9  | valid_rm_10 | valid_rm_11 | valid_rm_12 | valid_rm_13 | valid_rm_14 | valid_rm_15 | valid_rm_16 | valid_rm_17 | valid_rm_18 | valid_rm_19 | valid_rm_20 | valid_rm_21 | valid_rm_22 | valid_rm_23 | valid_rm_24 | valid_rm_25 | valid_rm_26 | valid_rm_27 | valid_rm_28 | valid_rm_29 | valid_rm_30 | valid_rm_31 ;

    assign ready_in = valid_p1 & ready_wires[first_counter] ;
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

    first_up_counter_for_romix first_counter_ip(
        .clk        (clk            ),
        .reset_n    (reset_n        ),
        .en         (ready_in       ),
        .out        (first_counter  )
    );
    
    decoder_5_bit decoder_init(
        .en     (ready_in)          ,
        .sel    (first_counter)     ,
        .out    (romix_init_wire)
    );
    
    romix_new rm_0(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[0] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[0]     ),
        .ixor_out   (ixor_hash_0        ),
        .oxor_out   (oxor_hash_0        ),
        .out        (out_rm_0           ),       
        .valid      (valid_rm_0         )
    );
    
    endianCvt rm_out_0(
    .in             (out_rm_0     ),
    .out            (out_rm_cvt_0 )
    );

    romix_new rm_1(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[1] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[1]     ),
        .ixor_out   (ixor_hash_1        ),
        .oxor_out   (oxor_hash_1        ),
        .out        (out_rm_1           ),       
        .valid      (valid_rm_1         )
    );
    
    endianCvt rm_out_1(
    .in             (out_rm_1     ),
    .out            (out_rm_cvt_1 )
    );
    
    romix_new rm_2(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[2] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[2]     ),
        .ixor_out   (ixor_hash_2        ),
        .oxor_out   (oxor_hash_2        ),
        .out        (out_rm_2           ),       
        .valid      (valid_rm_2         )
    );
        
    endianCvt rm_out_2(
    .in             (out_rm_2     ),
    .out            (out_rm_cvt_2 )
    );
    
    romix_new rm_3(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[3] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[3]     ),
        .ixor_out   (ixor_hash_3        ),
        .oxor_out   (oxor_hash_3        ),
        .out        (out_rm_3           ),       
        .valid      (valid_rm_3         )
    );
        
    endianCvt rm_out_3(
    .in             (out_rm_3     ),
    .out            (out_rm_cvt_3 )
    );
    
    romix_new rm_4(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[4] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[4]     ),
        .ixor_out   (ixor_hash_4        ),
        .oxor_out   (oxor_hash_4        ),
        .out        (out_rm_4           ),       
        .valid      (valid_rm_4         )
    );
        
    endianCvt rm_out_4(
    .in             (out_rm_4     ),
    .out            (out_rm_cvt_4 )
    );
    
    romix_new rm_5(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[5] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[5]     ),
        .ixor_out   (ixor_hash_5        ),
        .oxor_out   (oxor_hash_5        ),
        .out        (out_rm_5           ),       
        .valid      (valid_rm_5         )
    );
        
    endianCvt rm_out_5(
    .in             (out_rm_5     ),
    .out            (out_rm_cvt_5 )
    );
    
    romix_new rm_6(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[6] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[6]     ),
        .ixor_out   (ixor_hash_6        ),
        .oxor_out   (oxor_hash_6        ),
        .out        (out_rm_6           ),       
        .valid      (valid_rm_6         )
    );
        
    endianCvt rm_out_6(
    .in             (out_rm_6     ),
    .out            (out_rm_cvt_6 )
    );
    
    romix_new rm_7(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[7] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[7]     ),
        .ixor_out   (ixor_hash_7        ),
        .oxor_out   (oxor_hash_7        ),
        .out        (out_rm_7           ),       
        .valid      (valid_rm_7         )
    );
        
    endianCvt rm_out_7(
    .in             (out_rm_7     ),
    .out            (out_rm_cvt_7 )
    );
    
    romix_new rm_8(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[8] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[8]     ),
        .ixor_out   (ixor_hash_8        ),
        .oxor_out   (oxor_hash_8        ),
        .out        (out_rm_8           ),       
        .valid      (valid_rm_8         )
    );
        
    endianCvt rm_out_8(
    .in             (out_rm_8     ),
    .out            (out_rm_cvt_8 )
    );
    
    romix_new rm_9(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[9] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[9]     ),
        .ixor_out   (ixor_hash_9        ),
        .oxor_out   (oxor_hash_9        ),
        .out        (out_rm_9           ),       
        .valid      (valid_rm_9         )
    );
        
    endianCvt rm_out_9(
    .in             (out_rm_9     ),
    .out            (out_rm_cvt_9 )
    );
    
    romix_new rm_10(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[10] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[10]     ),
        .ixor_out   (ixor_hash_10        ),
        .oxor_out   (oxor_hash_10        ),
        .out        (out_rm_10           ),       
        .valid      (valid_rm_10         )
    );
        
    endianCvt rm_out_10(
    .in             (out_rm_10     ),
    .out            (out_rm_cvt_10 )
    );
    
    romix_new rm_11(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[11] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[11]     ),
        .ixor_out   (ixor_hash_11        ),
        .oxor_out   (oxor_hash_11        ),
        .out        (out_rm_11           ),       
        .valid      (valid_rm_11         )
    );
        
    endianCvt rm_out_11(
    .in             (out_rm_11     ),
    .out            (out_rm_cvt_11 )
    );
    
    romix_new rm_12(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[12] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[12]     ),
        .ixor_out   (ixor_hash_12        ),
        .oxor_out   (oxor_hash_12        ),
        .out        (out_rm_12           ),       
        .valid      (valid_rm_12         )
    );
        
    endianCvt rm_out_12(
    .in             (out_rm_12     ),
    .out            (out_rm_cvt_12 )
    );
    
    romix_new rm_13(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[13] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[13]     ),
        .ixor_out   (ixor_hash_13        ),
        .oxor_out   (oxor_hash_13        ),
        .out        (out_rm_13           ),       
        .valid      (valid_rm_13         )
    );
        
    endianCvt rm_out_13(
    .in             (out_rm_13     ),
    .out            (out_rm_cvt_13 )
    );
    
    romix_new rm_14(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[14] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[14]     ),
        .ixor_out   (ixor_hash_14        ),
        .oxor_out   (oxor_hash_14        ),
        .out        (out_rm_14           ),       
        .valid      (valid_rm_14         )
    );
        
    endianCvt rm_out_14(
    .in             (out_rm_14     ),
    .out            (out_rm_cvt_14 )
    );
    
    romix_new rm_15(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[15] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[15]     ),
        .ixor_out   (ixor_hash_15        ),
        .oxor_out   (oxor_hash_15        ),
        .out        (out_rm_15           ),       
        .valid      (valid_rm_15         )
    );
        
    endianCvt rm_out_15(
    .in             (out_rm_15     ),
    .out            (out_rm_cvt_15 )
    );
    
    romix_new rm_16(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[16] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[16]     ),
        .ixor_out   (ixor_hash_16        ),
        .oxor_out   (oxor_hash_16        ),
        .out        (out_rm_16           ),       
        .valid      (valid_rm_16         )
    );
        
    endianCvt rm_out_16(
    .in             (out_rm_16     ),
    .out            (out_rm_cvt_16 )
    );
    
    romix_new rm_17(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[17] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[17]     ),
        .ixor_out   (ixor_hash_17        ),
        .oxor_out   (oxor_hash_17        ),
        .out        (out_rm_17           ),       
        .valid      (valid_rm_17         )
    );
        
    endianCvt rm_out_17(
    .in             (out_rm_17     ),
    .out            (out_rm_cvt_17 )
    );
    
    romix_new rm_18(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[18] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[18]     ),
        .ixor_out   (ixor_hash_18        ),
        .oxor_out   (oxor_hash_18        ),
        .out        (out_rm_18           ),       
        .valid      (valid_rm_18         )
    );
        
    endianCvt rm_out_18(
    .in             (out_rm_18     ),
    .out            (out_rm_cvt_18 )
    );
    
    romix_new rm_19(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[19] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[19]     ),
        .ixor_out   (ixor_hash_19        ),
        .oxor_out   (oxor_hash_19        ),
        .out        (out_rm_19           ),       
        .valid      (valid_rm_19         )
    );
        
    endianCvt rm_out_19(
    .in             (out_rm_19     ),
    .out            (out_rm_cvt_19 )
    );
    
    romix_new rm_20(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[20] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[20]     ),
        .ixor_out   (ixor_hash_20        ),
        .oxor_out   (oxor_hash_20        ),
        .out        (out_rm_20           ),       
        .valid      (valid_rm_20         )
    );
        
    endianCvt rm_out_20(
    .in             (out_rm_20     ),
    .out            (out_rm_cvt_20 )
    );
    
    romix_new rm_21(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[21] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[21]     ),
        .ixor_out   (ixor_hash_21        ),
        .oxor_out   (oxor_hash_21        ),
        .out        (out_rm_21           ),       
        .valid      (valid_rm_21         )
    );
        
    endianCvt rm_out_21(
    .in             (out_rm_21     ),
    .out            (out_rm_cvt_21 )
    );
    
    romix_new rm_22(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[22] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[22]     ),
        .ixor_out   (ixor_hash_22        ),
        .oxor_out   (oxor_hash_22        ),
        .out        (out_rm_22           ),       
        .valid      (valid_rm_22         )
    );
        
    endianCvt rm_out_22(
    .in             (out_rm_22     ),
    .out            (out_rm_cvt_22 )
    );
    
    romix_new rm_23(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[23] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[23]     ),
        .ixor_out   (ixor_hash_23        ),
        .oxor_out   (oxor_hash_23        ),
        .out        (out_rm_23           ),       
        .valid      (valid_rm_23         )
    );
        
    endianCvt rm_out_23(
    .in             (out_rm_23     ),
    .out            (out_rm_cvt_23 )
    );
    
    romix_new rm_24(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[24] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[24]     ),
        .ixor_out   (ixor_hash_24        ),
        .oxor_out   (oxor_hash_24        ),
        .out        (out_rm_24           ),       
        .valid      (valid_rm_24         )
    );
        
    endianCvt rm_out_24(
    .in             (out_rm_24     ),
    .out            (out_rm_cvt_24 )
    );
    
    romix_new rm_25(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[25] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[25]     ),
        .ixor_out   (ixor_hash_25        ),
        .oxor_out   (oxor_hash_25        ),
        .out        (out_rm_25           ),       
        .valid      (valid_rm_25         )
    );
        
    endianCvt rm_out_25(
    .in             (out_rm_25     ),
    .out            (out_rm_cvt_25 )
    );
    
    romix_new rm_26(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[26] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[26]     ),
        .ixor_out   (ixor_hash_26        ),
        .oxor_out   (oxor_hash_26        ),
        .out        (out_rm_26           ),       
        .valid      (valid_rm_26         )
    );
        
    endianCvt rm_out_26(
    .in             (out_rm_26     ),
    .out            (out_rm_cvt_26 )
    );
    
    romix_new rm_27(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[27] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[27]     ),
        .ixor_out   (ixor_hash_27        ),
        .oxor_out   (oxor_hash_27        ),
        .out        (out_rm_27           ),       
        .valid      (valid_rm_27         )
    );
        
    endianCvt rm_out_27(
    .in             (out_rm_27     ),
    .out            (out_rm_cvt_27 )
    );
    
    romix_new rm_28(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[28] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[28]     ),
        .ixor_out   (ixor_hash_28        ),
        .oxor_out   (oxor_hash_28        ),
        .out        (out_rm_28           ),       
        .valid      (valid_rm_28         )
    );
        
    endianCvt rm_out_28(
    .in             (out_rm_28     ),
    .out            (out_rm_cvt_28 )
    );
    
    romix_new rm_29(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[29] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[29]     ),
        .ixor_out   (ixor_hash_29        ),
        .oxor_out   (oxor_hash_29        ),
        .out        (out_rm_29           ),       
        .valid      (valid_rm_29         )
    );
        
    endianCvt rm_out_29(
    .in             (out_rm_29     ),
    .out            (out_rm_cvt_29 )
    );
    
    romix_new rm_30(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[30] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[30]     ),
        .ixor_out   (ixor_hash_30        ),
        .oxor_out   (oxor_hash_30        ),
        .out        (out_rm_30           ),       
        .valid      (valid_rm_30         )
    );
        
    endianCvt rm_out_30(
    .in             (out_rm_30     ),
    .out            (out_rm_cvt_30 )
    );
    
    romix_new rm_31(
        //input
        .clk        (clk                ),
        .reset_n    (reset_n            ),                
        .init       (romix_init_wire[31] ),
        .ixor       (ixor_hash          ),
        .oxor       (oxor_hash          ),
        .in         (out_p1_cvt         ),
        //output
        .ready      (ready_wires[31]     ),
        .ixor_out   (ixor_hash_31        ),
        .oxor_out   (oxor_hash_31        ),
        .out        (out_rm_31           ),       
        .valid      (valid_rm_31         )
    );
      
    endianCvt rm_out_31(
    .in             (out_rm_31     ),
    .out            (out_rm_cvt_31 )
    );
    
    
    mux32_1 #(256) mux_ixor(
        .in_0   (ixor_hash_0 )   ,
        .in_1   (ixor_hash_1 )   ,
        .in_2   (ixor_hash_2 )   ,
        .in_3   (ixor_hash_3 )   ,
        .in_4   (ixor_hash_4 )   ,
        .in_5   (ixor_hash_5 )   ,
        .in_6   (ixor_hash_6 )   ,
        .in_7   (ixor_hash_7 )   ,
        .in_8   (ixor_hash_8 )   ,
        .in_9   (ixor_hash_9 )   ,
        .in_10  (ixor_hash_10)   ,
        .in_11  (ixor_hash_11)   ,
        .in_12  (ixor_hash_12)   ,
        .in_13  (ixor_hash_13)   ,
        .in_14  (ixor_hash_14)   ,
        .in_15  (ixor_hash_15)   ,
        .in_16  (ixor_hash_16)   ,
        .in_17  (ixor_hash_17)   ,
        .in_18  (ixor_hash_18)   ,
        .in_19  (ixor_hash_19)   ,
        .in_20  (ixor_hash_20)   ,
        .in_21  (ixor_hash_21)   ,
        .in_22  (ixor_hash_22)   ,
        .in_23  (ixor_hash_23)   ,
        .in_24  (ixor_hash_24)   ,
        .in_25  (ixor_hash_25)   ,
        .in_26  (ixor_hash_26)   ,
        .in_27  (ixor_hash_27)   ,
        .in_28  (ixor_hash_28)   ,
        .in_29  (ixor_hash_29)   ,
        .in_30  (ixor_hash_30)   ,
        .in_31  (ixor_hash_31)   ,
        .sel    (second_counter) ,
        .out    (ixor_romix)     
    );
    
    mux32_1 #(256) mux_oxor(
        .in_0   (oxor_hash_0 )   ,
        .in_1   (oxor_hash_1 )   ,
        .in_2   (oxor_hash_2 )   ,
        .in_3   (oxor_hash_3 )   ,
        .in_4   (oxor_hash_4 )   ,
        .in_5   (oxor_hash_5 )   ,
        .in_6   (oxor_hash_6 )   ,
        .in_7   (oxor_hash_7 )   ,
        .in_8   (oxor_hash_8 )   ,
        .in_9   (oxor_hash_9 )   ,
        .in_10  (oxor_hash_10)   ,
        .in_11  (oxor_hash_11)   ,
        .in_12  (oxor_hash_12)   ,
        .in_13  (oxor_hash_13)   ,
        .in_14  (oxor_hash_14)   ,
        .in_15  (oxor_hash_15)   ,
        .in_16  (oxor_hash_16)   ,
        .in_17  (oxor_hash_17)   ,
        .in_18  (oxor_hash_18)   ,
        .in_19  (oxor_hash_19)   ,
        .in_20  (oxor_hash_20)   ,
        .in_21  (oxor_hash_21)   ,
        .in_22  (oxor_hash_22)   ,
        .in_23  (oxor_hash_23)   ,
        .in_24  (oxor_hash_24)   ,
        .in_25  (oxor_hash_25)   ,
        .in_26  (oxor_hash_26)   ,
        .in_27  (oxor_hash_27)   ,
        .in_28  (oxor_hash_28)   ,
        .in_29  (oxor_hash_29)   ,
        .in_30  (oxor_hash_30)   ,
        .in_31  (oxor_hash_31)   ,
        .sel    (second_counter) ,
        .out    (oxor_romix)      
    );
    
    mux32_1 #(1024) mux_out_rm_cvt(
        .in_0   (out_rm_cvt_0 )   ,
        .in_1   (out_rm_cvt_1 )   ,
        .in_2   (out_rm_cvt_2 )   ,
        .in_3   (out_rm_cvt_3 )   ,
        .in_4   (out_rm_cvt_4 )   ,
        .in_5   (out_rm_cvt_5 )   ,
        .in_6   (out_rm_cvt_6 )   ,
        .in_7   (out_rm_cvt_7 )   ,
        .in_8   (out_rm_cvt_8 )   ,
        .in_9   (out_rm_cvt_9 )   ,
        .in_10  (out_rm_cvt_10)   ,
        .in_11  (out_rm_cvt_11)   ,
        .in_12  (out_rm_cvt_12)   ,
        .in_13  (out_rm_cvt_13)   ,
        .in_14  (out_rm_cvt_14)   ,
        .in_15  (out_rm_cvt_15)   ,
        .in_16  (out_rm_cvt_16)   ,
        .in_17  (out_rm_cvt_17)   ,
        .in_18  (out_rm_cvt_18)   ,
        .in_19  (out_rm_cvt_19)   ,
        .in_20  (out_rm_cvt_20)   ,
        .in_21  (out_rm_cvt_21)   ,
        .in_22  (out_rm_cvt_22)   ,
        .in_23  (out_rm_cvt_23)   ,
        .in_24  (out_rm_cvt_24)   ,
        .in_25  (out_rm_cvt_25)   ,
        .in_26  (out_rm_cvt_26)   ,
        .in_27  (out_rm_cvt_27)   ,
        .in_28  (out_rm_cvt_28)   ,
        .in_29  (out_rm_cvt_29)   ,
        .in_30  (out_rm_cvt_30)   ,
        .in_31  (out_rm_cvt_31)   ,
        .sel    (second_counter)  ,
        .out    (out_rm_cvt)      
    );
    up_counter_for_romix second_counter_ip(
        .clk        (clk                ),
        .reset_n    (reset_n            ),
        .en         (valid_rm           ),
        .out        (second_counter     )
    );
    pbkdf2_2 p2(
        //input
        .clk        (clk         ),
        .reset_n    (reset_n     ),
        .init       (valid_rm    ),
        .in         (out_rm_cvt  ),
        .ixor_hash  (ixor_romix  ),
        .oxor_hash  (oxor_romix  ),
        //output
        .out        (out_scrypt  ),
        .valid      (valid       )
    );
 
    
endmodule