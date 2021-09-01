


module mux
#(
     parameter FEATURE_WIDE =7                         ,  //input feature Intege bit width
     parameter FEATURE_NUM  =16                          

)(
    input                                              clk      ,
    input                                              rst_n    ,
    input signed [FEATURE_WIDE+3'd5:0]                 feature  ,
    input signed [12:0]                                weight   ,
    input                                              en       ,
    
    
    output signed  [FEATURE_NUM+2*FEATURE_WIDE+3'd5:0] sigma    



);


reg signed [FEATURE_NUM+FEATURE_WIDE+5'd21:0]    result;

assign  sigma=result>>6;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        result<={(FEATURE_NUM+FEATURE_WIDE+4'd8){1'b0}};
    end 
    else if (en==1'b1)begin
        result<=result+feature*weight;
    end
    else begin
        result<={(FEATURE_NUM+FEATURE_WIDE+4'd8){1'b0}};
    end 
end 



endmodule 