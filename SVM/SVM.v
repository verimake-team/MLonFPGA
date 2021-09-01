module SVM
#(
  parameter FUNCTION     =0                         ,  //0 is classification 1 is regression 
  parameter CLASS_WIDE   =2                         ,  
  parameter SVM_NUM      =800                       ,  //Number of neurons in output layer,up to 8
  parameter FEATURE_WIDE =7                         ,  //input feature Intege bit width
  parameter FEATURE_NUM  =16                           //Number of input feature,up to 16

)(
    input                                        clk         ,
    input                                        rst_n       ,
    input                                        en_change   ,
    input    [8*(FEATURE_WIDE+3'd6)-1'b1:0]      feature     ,
    input    [10:0]                              address     ,
    input    [10:0]                              address_bias,

    output signed [CLASS_WIDE-1'b1:0]            result      ,
    output reg                                   en_end      

);

reg     [8*(FEATURE_WIDE+3'd6)-1'b1:0]             feature_r   ;

wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma0      ;
                                                               
wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma1      ;
                                                               
wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma2      ;
                                                               
wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma3      ;
                                                               
wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma4      ;
                                                               
wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma5      ;
                                                               
wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma6      ;
                                                               
wire signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0]   sigma7      ;
                                                               
wire  [107:0]                                      weight      ;
                                                               
reg signed  [FEATURE_NUM+2*FEATURE_WIDE+4'd9:0]    result0     ;
                                                               
reg [10:0]                                         cnt         ;
                                                               
wire signed [12:0]                                 bias        ;

wire signed [1:0]                                  result_r    ;
                                                               
wire                                               flag_n      ;
                                                               
reg                                                en_change_r ;

reg                                                en_change_rr;

wire                                               en_end_r    ;

reg                                                en          ;



assign en_end_r=!en_change_rr && en;

assign result  =(FUNCTION==1'b0)?result_r:result0;

assign result_r=(en_end==1'b1)?(flag_n==1'b1)?2'd1:-2'd1:2'd0;

assign flag_n  =(result0[FEATURE_NUM+2*FEATURE_WIDE+4'd9]==1'b0 && result0!={(FEATURE_NUM+2*FEATURE_WIDE+4'd10){1'b0}})?1'b1:1'b0;





always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        result0<={(FEATURE_NUM+2*FEATURE_WIDE+4'd10){1'b0}};
    end 
    else begin
        result0<=sigma0+sigma1+sigma2+sigma3+sigma4+sigma5+sigma6+sigma7+bias;
    end
end




always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        cnt<=11'd0;
    end 
    else if (cnt==SVM_NUM)begin
        cnt<=SVM_NUM;
    end 
    else if(en_change_rr==1'b0)begin
        cnt<=cnt+1'b1;
    end 
end 







always@(posedge clk )begin

    feature_r<=feature;
    en_change_r<=en_change;
    en_change_rr<=en_change_r;
    en_end<=en_end_r;
    en<=rst_n;
end 







data  data(
    .address(address                ),
    .clock  (clk                    ),
    
    .q      (weight                 )
);

data_bias  data_bias(
    .address  (address_bias),
    .clock    (clk         ),
    .q        (bias        )
);


mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux0(                                                
    .clk      (clk                                        ),
    .rst_n    (rst_n                                      ),
    .feature  (feature_r[FEATURE_WIDE+3'd5:0]             ),
    .weight   (weight[12:0]                               ),
    .en       (en_change_rr                               ),
    
    .sigma    (sigma0                                     )
);

mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux1(
    .clk      (clk                                                    ),
    .rst_n    (rst_n                                                  ),
    .feature  (feature_r[2*(FEATURE_WIDE+3'd6)-1'b1:FEATURE_WIDE+3'd6]),
    .weight   (weight[25:13]                                          ),
    .en       (en_change_rr                                           ),
                                                                     
    .sigma    (sigma1                                                 )
);



mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux2(                                                                
    .clk      (clk                                                        ),
    .rst_n    (rst_n                                                      ),
    .feature  (feature_r[3*(FEATURE_WIDE+3'd6)-1'b1:2*(FEATURE_WIDE+3'd6)]),
    .weight   (weight[38:26]                                              ),
    .en       (en_change_rr                                               ),
                                                                         
    .sigma    (sigma2                                                     )
);



mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux3(
    .clk      (clk                                                        ),
    .rst_n    (rst_n                                                      ),
    .feature  (feature_r[4*(FEATURE_WIDE+3'd6)-1'b1:3*(FEATURE_WIDE+3'd6)]),
    .weight   (weight[51:39]                                              ),
    .en       (en_change_rr                                               ),
                                                                         
    .sigma    (sigma3                                                     )
);


mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux4(
    .clk      (clk                                                        ),
    .rst_n    (rst_n                                                      ),
    .feature  (feature_r[5*(FEATURE_WIDE+3'd6)-1'b1:4*(FEATURE_WIDE+3'd6)]),
    .weight   (weight[64:52]                                              ),
    .en       (en_change_rr                                               ),
                                                                         
    .sigma    (sigma4                                                     )
);


mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux5(
    .clk      (clk                                                        ),
    .rst_n    (rst_n                                                      ),
    .feature  (feature_r[6*(FEATURE_WIDE+3'd6)-1'b1:5*(FEATURE_WIDE+3'd6)]),
    .weight   (weight[77:65]                                              ),
    .en       (en_change_rr                                               ),
                                                                         
    .sigma    (sigma5                                                     )
);



mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux6(
    .clk      (clk                                                        ),
    .rst_n    (rst_n                                                      ),
    .feature  (feature_r[7*(FEATURE_WIDE+3'd6)-1'b1:6*(FEATURE_WIDE+3'd6)]),
    .weight   (weight[90:78]                                             ),
    .en       (en_change_rr                                               ),
                                                                         
    .sigma    (sigma6                                                     )
);



mux  
#(
    .FEATURE_WIDE (FEATURE_WIDE ),
    .FEATURE_NUM  (FEATURE_NUM  )


)int_mux7(                                                               
    .clk      (clk                                                        ),
    .rst_n    (rst_n                                                      ),
    .feature  (feature_r[8*(FEATURE_WIDE+3'd6)-1'b1:7*(FEATURE_WIDE+3'd6)]),
    .weight   (weight[103:91]                                             ),
    .en       (en_change_rr                                               ),
                                                                          
    .sigma    (sigma7                                                     )
);


endmodule 