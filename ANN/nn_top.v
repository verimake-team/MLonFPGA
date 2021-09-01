
//        decimal digits  6

module nn_top
#(
  parameter CLASS_NUM    =1                         ,  //Number of neurons in output layer,up to 16
  parameter FEATURE_WIDE =7                         ,  //input feature Intege bit width
  parameter FEATURE_NUM  =7                         ,  //Number of input feature,up to 16
  parameter LAYER_NUM    =2                         ,  //Number of hidden layers,up to 4
  parameter FUNCTION     ={2'd3,2'd3,2'd3,2'd3,2'd1},  //Activation functions for the hidden layer and output layer,1 is RELU,2 is tanh ,3 is sigmiod,
  parameter NEU_NUM      ={4'd8,4'd8,4'd8,4'd8}        //Number of hidden layer neurons({layer 4,layer 3,layer 2,layer 1})
)(

    input                                                          clk       ,
    input                                                          rst_n     ,
    input signed [FEATURE_WIDE+3'd5:0]                             feature   ,
    input                                                          en        ,
                       
    output signed[FEATURE_WIDE+4'd15:0]                            lab       
);

reg [4:0]                                           cnt           ;
                                                    
reg  [FEATURE_NUM*(FEATURE_WIDE+3'd6) -1'b1:0]      feature_sum   ;

wire signed [FEATURE_WIDE+3'd5:0]                   feature_sum0  ;
                                                    
wire                                                in_en         ;
                                                                  


always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt<=5'd0;
    end
    else if(cnt==FEATURE_NUM)begin
        cnt<=FEATURE_NUM;
    end 
    else if(en==1'b1)begin
        cnt<=cnt+1'b1;
   end 
end 



always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        feature_sum<={FEATURE_NUM*(FEATURE_WIDE+3'd6){1'b0}};
    end
    else if(cnt<=FEATURE_NUM-1'b1 && en ==1'b1)begin
        feature_sum<=(FEATURE_NUM>=2)?{feature,feature_sum[FEATURE_NUM*(FEATURE_WIDE+3'd6)-1'b1:FEATURE_WIDE+3'd6]}:feature;
    end
    else begin
        feature_sum<=(FEATURE_NUM>=2)?{feature_sum[FEATURE_WIDE+3'd5:0],feature_sum[FEATURE_NUM*(FEATURE_WIDE+3'd6)-1'b1:FEATURE_WIDE+3'd6]}:feature;
    end
end

assign feature_sum0=(cnt==FEATURE_NUM)?feature_sum[FEATURE_WIDE+3'd5:0]:{(FEATURE_WIDE+3'd6){1'b0}};
assign in_en=(cnt==FEATURE_NUM)?1'b1:1'b0;





nn
#(

  .CLASS_NUM    (CLASS_NUM    ),
  .FEATURE_WIDE (FEATURE_WIDE ),
  .FEATURE_NUM  (FEATURE_NUM  ),     
  .LAYER_NUM    (LAYER_NUM    ),     
  .FUNCTION     (FUNCTION     ),
  .NEU_NUM      (NEU_NUM      )     
)
u_nn(

    .clk      (clk           ),
    .rst_n    (rst_n         ),
    .feature  (feature_sum0  ),
    .en       (in_en         ),
    
    .lab      (lab           )
);







endmodule 