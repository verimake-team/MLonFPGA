

module   nn
#(

  parameter CLASS_NUM    =6                         ,
  parameter FEATURE_WIDE =4                         ,
  parameter FEATURE_NUM  =4                         ,     //up to 16
  parameter LAYER_NUM    =4                         ,     
  parameter FUNCTION     ={2'd2,2'd1,2'd3,2'd2,2'd1}, 
  parameter NEU_NUM      ={4'd8,4'd8,4'd8,4'd8}       //每一层神经元8位，然后从低到高位第一层隐藏层到最后一层隐藏层
)(

    input                                      clk       ,
    input                                      rst_n     ,
    input signed [FEATURE_WIDE+3'd5:0]         feature   ,
    input                                      en        ,
                       
    output signed[(FEATURE_WIDE+4'd15):0]      lab       ,
    output                                     out_end 
);



reg [9:0]                                          address     ;

reg                                                mac_en      ;

reg signed [(FEATURE_WIDE+4'd15):0]                in_feature  ;
                                                   
reg [4:0]                                          n_num       ;


reg [4:0]                                          f_num       ;
                                                   
wire [3:0]                                         f_num0      ;

wire  [8*(FEATURE_WIDE+5'd16)-1'b1:0]              result      ;
                                                   
wire                                               en_end      ;

wire signed [(FEATURE_WIDE+4'd15):0]               result0     ;

wire                                               en_end0     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result1     ;
                                                   
wire                                               en_end1     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result2     ;

wire                                               en_end2     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result3     ;
                                                   
wire                                               en_end3     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result4     ;

wire                                               en_end4     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result5     ;
                                                   
wire                                               en_end5     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result6     ;

wire                                               en_end6     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result7     ;
                                                   
wire                                               en_end7     ;

wire signed [(FEATURE_WIDE+4'd15):0]               result8     ;
                                                   
wire                                               en_end8     ;

reg                                                en_end_fr   ;
                                                   
reg  signed [(FEATURE_WIDE+4'd15):0]               result_fr   ;

reg                                                en_end_ft   ;
                                                   
reg  signed [(FEATURE_WIDE+4'd15):0]               result_ft   ;

wire                                               en_end_r    ;
                                                               
wire  signed [(FEATURE_WIDE+4'd15):0]              result_r    ;
                                                               
wire                                               en_end_t    ;
                                                               
wire  signed [(FEATURE_WIDE+4'd15):0]              result_t    ;

reg                                                flag_end    ;                                                               

wire                                               out_en      ;

wire                                               out_en0     ;

wire         [127:0]                               w           ;

wire                                               rden        ;

reg                                                en_flag     ;
 
reg   [3:0 ]                                       test        ;

reg   [3:0 ]                                       test_r      ;

reg                                                choice      ;

wire                                               flag_begin  ;

wire   [FEATURE_WIDE+4'd15:0]                      out_result  ;


assign out_en=(LAYER_NUM==1)?en_end1:(LAYER_NUM==2)?en_end3:(LAYER_NUM==3)?en_end5
                                     :(LAYER_NUM==4)?en_end7:1'b0;
                                     
assign out_result=(LAYER_NUM==1)?result1:(LAYER_NUM==2)?result3:(LAYER_NUM==3)?result5
                                     :(LAYER_NUM==4)?result7:{(FEATURE_WIDE+5'd16){1'b0}};
                                     
assign out_en0=(LAYER_NUM==1)?en_end0:(LAYER_NUM==2)?en_end2:(LAYER_NUM==3)?en_end4
                                     :(LAYER_NUM==4)?en_end6:1'b0;
                                     
assign f_num0=(LAYER_NUM==1)?NEU_NUM[3:0]:(LAYER_NUM==2)?NEU_NUM[7:4]:(LAYER_NUM==3)?NEU_NUM[11:8]
                                     :(LAYER_NUM==4)?NEU_NUM[15:12]:4'd0; 
                                     
                                     
                                     
assign result1=(en_end0==1'b1)?((FUNCTION[1:0]==2'd1)?result_r
              :(FUNCTION[1:0]==2'd2 || FUNCTION[1:0]==2'd3)?result_t:{(FEATURE_WIDE+5'd16){1'b0}})
              :{(FEATURE_WIDE+5'd16){1'b0}};

assign en_end1=(en_end0==1'b1)?((FUNCTION[1:0]==2'd1)?en_end_r
              :(FUNCTION[1:0]==2'd2 || FUNCTION[1:0]==2'd3)?en_end_t:1'b0):1'b0;
              
assign result3=(en_end2==1'b1)?((FUNCTION[3:2]==2'd1)?result_r
              :(FUNCTION[3:2]==2'd2 ||FUNCTION[3:2]==2'd3)?result_t:{(FEATURE_WIDE+5'd16){1'b0}})
              :{(FEATURE_WIDE+5'd16){1'b0}};

assign en_end3=(en_end2==1'b1)?((FUNCTION[3:2]==2'd1)?en_end_r
              :(FUNCTION[3:2]==2'd2 || FUNCTION[3:2]==2'd3)?en_end_t:1'b0):1'b0;          
              
assign result5=(en_end4==1'b1)?((FUNCTION[5:4]==2'd1)?result_r
              :(FUNCTION[5:4]==2'd2 || FUNCTION[5:4]==2'd3)?result_t:{(FEATURE_WIDE+5'd16){1'b0}})
              :{(FEATURE_WIDE+5'd16){1'b0}};

assign en_end5=(en_end4==1'b1)?((FUNCTION[5:4]==2'd1)?en_end_r
              :(FUNCTION[5:4]==2'd2 || FUNCTION[5:4]==2'd3)?en_end_t:1'b0):1'b0;
              
assign result7=(en_end6==1'b1)?((FUNCTION[7:6]==2'd1)?result_r
              :(FUNCTION[7:6]==2'd2 || FUNCTION[7:6]==2'd3)?result_t:{(FEATURE_WIDE+5'd16){1'b0}})
              :{(FEATURE_WIDE+5'd16){1'b0}};

assign en_end7=(en_end6==1'b1)?((FUNCTION[7:6]==2'd1)?en_end_r
              :(FUNCTION[7:6]==2'd2 || FUNCTION[7:6]==2'd3)?en_end_t:1'b0):1'b0;      

assign lab=(en_end8==1'b1)?(FUNCTION[9:8]==2'd1)?result_r:(FUNCTION[9:8]==2'd2 || FUNCTION[9:8]==2'd3)?result_t:{(FEATURE_WIDE+5'd16){1'b0}}:{(FEATURE_WIDE+5'd16){1'b0}};

assign out_end=(FUNCTION[9:8]==2'd1)?en_end_r:(FUNCTION[9:8]==2'd2 || FUNCTION[9:8]==2'd3)?en_end_t:1'b0;  
              

always @(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        mac_en      <=1'd0;
        in_feature  <={(FEATURE_WIDE+5'd16){1'b0}};
        n_num       <=5'd0;
        f_num       <=5'd0;  
        test<=4'd0;        
    end
    else if(en_end8==1'b1 )begin
        test<=4'd6; 
        mac_en      <=1'b1         ;
        in_feature  <=out_result      ;
        f_num       <=f_num0          ;
        n_num       <=CLASS_NUM       ; 
    end  
    else if (out_en0==1'b1    )begin
        mac_en      <=out_en         ;
        in_feature  <=out_result      ;
        f_num       <=f_num0          ;
        n_num       <=CLASS_NUM       ; 
        test<=4'd5; 
    end 
    else if (en_end4==1'b1 && LAYER_NUM>=4)begin
        mac_en      <=en_end5;
        in_feature  <=result5;
        f_num       <=NEU_NUM[11:8]  ;
        n_num       <=NEU_NUM[15:12]  ; 
        test<=4'd4; 
    end 
    else if (en_end2==1'b1 && LAYER_NUM>=3)begin
        mac_en      <=en_end3;
        in_feature  <=result3;
        f_num       <=NEU_NUM[7:4]  ;
        n_num       <=NEU_NUM[11:8]; 
        test<=4'd3; 
    end 
    else if (en_end0==1'b1 && LAYER_NUM>=2)begin
        mac_en     <=en_end1;
        in_feature <=result1;
        f_num      <=NEU_NUM[3:0];
        n_num      <=NEU_NUM[7:4]; 
        test<=4'd2; 
    end 
    else if (en==1'b1 && LAYER_NUM>=1)begin
        mac_en      <=en;
        in_feature  <=feature;
        f_num       <=FEATURE_NUM ;
        n_num       <=NEU_NUM[3:0]; 
        test<=4'd1; 
    end 
    else begin
        mac_en      <=1'd0;
        in_feature  <={(FEATURE_WIDE+5'd16){1'b0}};
        n_num       <=5'd0;
        f_num       <=5'd0;  
        test<=4'd0; 
    end 

end 

always@(posedge clk )begin

    test_r<=test;
    
end 


always@(*)begin
    if(!rst_n)begin
        en_flag =1'b0;
    end 
    else begin
    case(test_r)
        4'd1:       en_flag=en_end0;
        4'd2:       en_flag=en_end2;
        4'd3:       en_flag=en_end4;
        4'd4:       en_flag=en_end6;
        4'd5:       en_flag=en_end8;
        4'd6:       en_flag=1'b0;
        default :   en_flag=1'b0;
    endcase
    end 
    
    


end 




always @(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
         choice    <= 1'b0;
         en_end_fr <= 1'b0;
         result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
         en_end_ft <= 1'b0;
         result_ft <= {(FEATURE_WIDE+5'd16){1'b0}};

    end
    else if (en_end8==1'b1)begin

       case (FUNCTION[9:8])
        2'd1:begin
          choice    <= 1'b0;
          en_end_fr <= en_end8;
          result_fr <= result8;
          en_end_ft <= 1'b0;
          result_ft <= {(FEATURE_WIDE+5'd16){1'b0}};
        end 
       2'd2:begin
          choice    <= 1'b0;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end8;
          result_ft <= result8;
  
        end 
       2'd3:begin        
          choice    <= 1'b1;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end8;
          result_ft <= result8;
        end 
        endcase
    end 
    else if (en_end6==1'b1)begin

       case (FUNCTION[7:6])
        2'd1:begin
          choice    <= 1'b0;
          en_end_fr <= en_end6;
          result_fr <= result6;
          en_end_ft <= 1'b0;
          result_ft <= {(FEATURE_WIDE+5'd16){1'b0}};
        end 
       2'd2:begin
          choice    <= 1'b0;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end6;
          result_ft <= result6;
        end 
       2'd3:begin        
          choice    <= 1'b1;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end6;
          result_ft <= result6;
        end 
        endcase
    end 
    else if (en_end4==1'b1)begin
       case (FUNCTION[5:4])
        2'd1:begin
          choice    <= 1'b0;
          en_end_fr <= en_end4;
          result_fr <= result4;
          en_end_ft <= 1'b0;
          result_ft <= {(FEATURE_WIDE+5'd16){1'b0}};
        end 
       2'd2:begin
          choice    <= 1'b0;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end4;
          result_ft <= result4;

        end 
       2'd3:begin        
          choice    <= 1'b1;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end4;
          result_ft <= result4;
        end 
        endcase
    end 
    else if (en_end2==1'b1)begin

       case (FUNCTION[3:2])
        2'd1:begin
          choice    <= 1'b0;
          en_end_fr <= en_end2;
          result_fr <= result2;
          en_end_ft <= 1'b0;
          result_ft <= {(FEATURE_WIDE+5'd16){1'b0}};
        end 
       2'd2:begin
          choice    <= 1'b0;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end2;
          result_ft <= result2;
        end 
       2'd3:begin        
          choice    <= 1'b1;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end2;
          result_ft <= result2;
        end 
        endcase
    end 
    else if (en_end0==1'b1)begin

       case (FUNCTION[1:0])
        2'd1:begin
          choice    <= 1'b0;
          en_end_fr <= en_end0;
          result_fr <= result0;
          en_end_ft <= 1'b0;
          result_ft <= {(FEATURE_WIDE+5'd16){1'b0}};
        end 
       2'd2:begin
          choice    <= 1'b0;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end0;
          result_ft <= result0;
        end 
       2'd3:begin        
          choice    <= 1'b1;
          en_end_fr <= 1'b0;
          result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
          en_end_ft <= en_end0;
          result_ft <= result0;

        end 
        endcase
    end 
    else begin
         choice    <= 1'b0;
         en_end_fr <= 1'b0;
         result_fr <= {(FEATURE_WIDE+5'd16){1'b0}};
         en_end_ft <= 1'b0;
         result_ft <= {(FEATURE_WIDE+5'd16){1'b0}};
 end 

end 




 always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        address<=10'd0;
    end 
    else if (rden==1'b1)begin
       address<=address+1'b1;
    end 
    else begin
       address<=address;
    
    end 

end  


always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        flag_end<=1'b0;
    end 
    else if (CLASS_NUM>=4'd9 && mac_en==1'b1 && test>=3'd5)begin
        flag_end<=1'b1;
    end 
    else begin
        flag_end<=1'b0;
    end 

end  




/* data  data(
    .address(address                ),
    .clock  (clk                    ),
    .rden   (rden                   ),
    
    .q      (w                      )
);

 */


rom   data(
    .addr  (address                ),
 
    .data    (w                      )
);




mac 
#(
  .FEATURE_WIDE      (FEATURE_WIDE    ),
  .CLASS_NUM         (CLASS_NUM       )    
)
u_max(

    .clk       (clk                ),
    .rst_n     (rst_n              ),
    .en        (mac_en             ),
    .feature   (in_feature         ),
    .w         (w                  ),
    .n_num     (n_num              ),
    .f_num     (f_num              ),
    .flag_end  (flag_end           ),

    .flag_begin(flag_begin         ),
    .result    (result             ),
    .en_end    (en_end             ),
    .en_addr   (rden               )
);


 relu
#(
  .FEATURE_WIDE (FEATURE_WIDE      )
)
u_relu(


    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .en        (en_end_fr ),
    .in_data   (result_fr ),
    .mac_en    (en_flag   ),

    .out_data  (result_r  ),
    .end_en    (en_end_r  )

); 


 tanh
#(
  .FEATURE_WIDE (FEATURE_WIDE      )
)
u_tanh(

    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .en        (en_end_ft ),
    .in_data   (result_ft ),
    .mac_en    (en_flag   ),
    .choice    (choice    ),
    
    .out_data  (result_t  ),
    .end_en    (en_end_t  )

);




layer 
#(
  .FEATURE_WIDE     (FEATURE_WIDE     ),
  .NEU_NUM          (NEU_NUM[3:0]     )      
)
u_layer0(

    .clk       (clk                    ),
    .rst_n     (rst_n && LAYER_NUM>=1  ),
    .feature   (result                 ),
    .en        (en &&  en_end          ),

                                      
    .result    (result0                ),

    .en_end    (en_end0                )
);



layer 
#(
  .FEATURE_WIDE     (FEATURE_WIDE     ),
  .NEU_NUM          (NEU_NUM[7:4]     )      
)
u_layer1(

    .clk       (clk                    ),
    .rst_n     (rst_n && LAYER_NUM>=2  ),
    .feature   (result                 ),
    .en        (en_end1 &&  en_end     ),

                                      
    .result    (result2                ),
    .en_end    (en_end2                )
);




 layer 
#(
  .FEATURE_WIDE     (FEATURE_WIDE     ),
  .NEU_NUM          (NEU_NUM[11:8]   )      
)
u_layer2(

    .clk       (clk                    ),
    .rst_n     (rst_n && LAYER_NUM>=3  ),
    .feature   (result                 ),
    .en        (en_end3 &&  en_end     ),


    .result    (result4                ),
    .en_end    (en_end4                )
);



 layer 
#(
  .FEATURE_WIDE     (FEATURE_WIDE     ),
  .NEU_NUM          (NEU_NUM[15:12]   )      
)
u_layer3(

    .clk       (clk                    ),
    .rst_n     (rst_n && LAYER_NUM>=4  ),
    .feature   (result                 ),
    .en        (en_end5 &&  en_end     ),

                                      
    .result    (result6                ),
    .en_end    (en_end6                )
);



 out_layer 
#(
  .FEATURE_WIDE     (FEATURE_WIDE     ),
  .NEU_NUM          (CLASS_NUM        )      
)
out_lay(

    .clk       (clk                    ),
    .rst_n     (rst_n                  ),
    .feature   (result                 ),
    .en        (en_end && out_en       ),
    .flag_begin(flag_begin             ),
                                      
    .result    (result8                ),
    .en_end    (en_end8                )
);




endmodule 