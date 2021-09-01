module  relu
#(
  parameter FEATURE_WIDE =4    
)(

    input                                                              clk        ,
    input                                                              rst_n      ,
    input                                                              en         ,
    input signed  [ FEATURE_WIDE+5'd15 :0]                             in_data    ,
    input                                                              mac_en     ,

     
    output reg signed [FEATURE_WIDE+4'd15:0]                           out_data   ,
    output                                                             end_en    

);


reg                   end_en_r;

assign end_en=(end_en_r==1'b1 && mac_en==1'b0)?1'b1:1'b0;


always@(posedge clk )begin
    end_en_r<=en;

end 

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_data<={(FEATURE_WIDE+5'd16){1'b0}};
    end 
    else if (in_data[FEATURE_WIDE+4'd15]==1'b0)begin
       out_data<=in_data;
    end 
    else begin 
       out_data<={(FEATURE_WIDE+5'd16){1'b0}};
        end 

end 




endmodule 
