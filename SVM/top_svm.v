

module top_svm
#(
  parameter FUNCTION     =0                         ,  //0 is classification 1 is regression
  parameter CLASS_WIDE   =2                         ,    
  parameter SVM_NUM      =1024                      ,  //<=8(2048),>8(1300)
  parameter FEATURE_WIDE =7                         ,  //input feature Intege bit width
  parameter FEATURE_NUM  =11                            //Number of input feature,up to 16
)
(

    input                                                          clk       ,
    input                                                          rst_n     ,
    input signed [FEATURE_WIDE+3'd5:0]                             feature   ,

    output signed [CLASS_WIDE-1'b1:0]                              result     ,
    output wire                                                    en_end      
);


reg [1:0]                                              cnt0_1        ;

reg [4:0]                                              cnt           ;
                                                    
reg  [16*(FEATURE_WIDE+3'd6) -1'b1:0]                  feature_sum   ;

reg  signed [8*(FEATURE_WIDE+3'd6) -1'b1:0]            feature_sum0  ;
                                                    
wire                                                   in_en         ;
                                                    
reg                                                    in_en_r       ;                                                                  

wire                                                   en_change     ;

reg  [10:0]                                            address       ;

reg  [10:0]                                            address_bias  ;

assign in_en=(cnt==FEATURE_NUM )?1'b1:1'b0;

assign en_change=(cnt0_1!=2'd0)?1'b1:1'b0;




always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt<=5'd0;
    end
    else if(cnt==FEATURE_NUM)begin
        cnt<=FEATURE_NUM;
    end 
    else begin
        cnt<=cnt+1'b1;
   end 
end 

always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt0_1<=2'd0;
    end
    else if(cnt>=FEATURE_NUM-1'b1)begin
        if(FEATURE_NUM<=4'd8)begin
            if (cnt0_1==2'd1)begin
                cnt0_1<=2'd0;
            end 
            else begin
                cnt0_1<=cnt0_1+1'b1;
            end 
        end 
      else begin
            if (cnt0_1==2'd2)begin
                cnt0_1<=2'd0;
            end 
            else begin
                cnt0_1<=cnt0_1+1'b1;
            end 
        end 
   end 
   else begin
         cnt0_1<=2'd0;
    end 
end 


always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        feature_sum<={16*(FEATURE_WIDE+3'd6){1'b0}};
    end
    else if(cnt<=FEATURE_NUM-1'b1 )begin
        feature_sum<={feature_sum[15*(FEATURE_WIDE+3'd6)-1'b1:0],feature};
    end
    else begin
        feature_sum<=feature_sum;
    end
end


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        feature_sum0<={8*(FEATURE_WIDE+3'd6){1'b0}};
    end 
    else if (in_en==1'b1)begin 
        if (FEATURE_NUM<=4'd8 )begin
            feature_sum0<=feature_sum;
        end 
        else begin
        case (cnt0_1) 
            2'd0:feature_sum0<={8*(FEATURE_WIDE+3'd6){1'b0}};
            2'd1:feature_sum0<=feature_sum[8*(FEATURE_WIDE+3'd6) -1'b1:0];
            2'd2:feature_sum0<=feature_sum[16*(FEATURE_WIDE+3'd6) -1'b1:8*(FEATURE_WIDE+3'd6)];
        default :feature_sum0<={8*(FEATURE_WIDE+3'd6){1'b0}};
        endcase 
        end 
    end 
    else begin
        feature_sum0<={8*(FEATURE_WIDE+3'd6){1'b0}};
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        address<=11'd0;
    end 
    else if(en_change==1'b1)begin
       address<=address+1'b1;
    end 
    else begin
        address<=address;
    end 
end  


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        address_bias<=11'd0;
    end 
    else if(en_change==1'b0 && in_en==1'b1)begin
       address_bias<=address_bias+1'b1;
    end 
    else begin
        address_bias<=address_bias;
    end 
end  


always@(posedge clk )begin

    in_en_r<=in_en;

end 


SVM
#(
  .FUNCTION     (FUNCTION           ),  //0 is classification 1 is regression 
  .SVM_NUM      (SVM_NUM            ),  //Number of neurons in output layer,up to 8
  .FEATURE_WIDE (FEATURE_WIDE       ),  //input feature Intege bit width
  .CLASS_WIDE   (CLASS_WIDE         ),
  .FEATURE_NUM  (FEATURE_NUM        )   //Number of input feature,up to 16

)
SVM(
   .clk         (clk           ),
   .rst_n       (in_en_r       ),
   .address     (address       ),
   .address_bias(address_bias  ),
   .feature     (feature_sum0  ),
   .en_change   (en_change     ),
   
   .result      (result        ),
   .en_end      (en_end        )

);



endmodule 