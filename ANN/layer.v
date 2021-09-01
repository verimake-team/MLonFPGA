


module layer 
#(
  parameter FEATURE_WIDE =4     ,
  parameter NEU_NUM      =12  
)(
                                                             
    input                                                    clk        ,
    input                                                    rst_n      ,
    input                                                    en         ,
    input signed [NEU_NUM*(FEATURE_WIDE+5'd16)-1'b1:0]       feature    ,




    
    output reg signed[ FEATURE_WIDE+4'd15:0]                 result    , 

    output reg                                               en_end     
);


reg                                               en_r      ;

wire  [NEU_NUM*(FEATURE_WIDE+5'd16)-1'b1:0]       result_r  ; 

reg [3:0]                                         cnt_x     ;
 
reg                                               en_rr     ;

assign result_r=(en_end==1'b0)?feature:result_r;


always@(posedge clk )begin
    en_r<=en;
    en_end<=en_rr;
end 

always@(*)begin
    if (!rst_n)begin
        en_rr =1'b0;
    end
    else if (en==1'b1 && en_r==1'b0)  begin
        en_rr =1'b1;
     end 
    else begin
        en_rr =en_rr;
    end
end    

always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt_x<=4'd0;
    end
    else if(cnt_x==NEU_NUM)begin
        cnt_x<=4'd0;
    end 
    else if(en_rr==1'b1) begin 
        cnt_x<=cnt_x+1'b1;
    end     
end 

 
always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        result<={(FEATURE_WIDE+5'd16){1'b0}};
    end 
    else if (en_rr==1'b1 )begin
        case (cnt_x)
        4'd0:result<=(NEU_NUM>=1)?result_r[FEATURE_WIDE+4'd15:0]:{(FEATURE_WIDE+5'd16){1'b0}};
        4'd1:result<=(NEU_NUM>=2)?result_r[2*(FEATURE_WIDE+5'd16)-1'b1:  (FEATURE_WIDE+5'd16)]:{(FEATURE_WIDE+5'd16){1'b0}};
        4'd2:result<=(NEU_NUM>=3)?result_r[3*(FEATURE_WIDE+5'd16)-1'b1:2*(FEATURE_WIDE+5'd16)]:{(FEATURE_WIDE+5'd16){1'b0}};
        4'd3:result<=(NEU_NUM>=4)?result_r[4*(FEATURE_WIDE+5'd16)-1'b1:3*(FEATURE_WIDE+5'd16)]:{(FEATURE_WIDE+5'd16){1'b0}};
        4'd4:result<=(NEU_NUM>=5)?result_r[5*(FEATURE_WIDE+5'd16)-1'b1:4*(FEATURE_WIDE+5'd16)]:{(FEATURE_WIDE+5'd16){1'b0}};
        4'd5:result<=(NEU_NUM>=6)?result_r[6*(FEATURE_WIDE+5'd16)-1'b1:5*(FEATURE_WIDE+5'd16)]:{(FEATURE_WIDE+5'd16){1'b0}};
        4'd6:result<=(NEU_NUM>=7)?result_r[7*(FEATURE_WIDE+5'd16)-1'b1:6*(FEATURE_WIDE+5'd16)]:{(FEATURE_WIDE+5'd16){1'b0}};
        4'd7:result<=(NEU_NUM>=8)?result_r[8*(FEATURE_WIDE+5'd16)-1'b1:7*(FEATURE_WIDE+5'd16)]:{(FEATURE_WIDE+5'd16){1'b0}};
        default:result<={(FEATURE_WIDE+5'd16){1'b0}};
        endcase 
    end
    else begin
        result<={(FEATURE_WIDE+5'd16){1'b0}};
    end 

end

  


endmodule 