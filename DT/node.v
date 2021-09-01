module node
#(
  parameter FEATURE_WIDE =7                           //input feature Intege bit width

)(
    input                             clk       ,
    input                             rst_n     ,
    input    [FEATURE_WIDE-1'b1:0]    feature   ,//4位整数8位小数
    input    [FEATURE_WIDE-1'b1:0]    train     ,//4位整数8位小数

    output reg [1:0]                  en_end      
);



always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        en_end<=2'd0;
    end 
    else if (feature<=train)begin
        en_end<=2'd1;
    end 
    else begin
       en_end<=2'd2;
    end 
end 












endmodule 