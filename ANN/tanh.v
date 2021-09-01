`timescale 1ns/1ps


module tanh
#(
  parameter FEATURE_WIDE =4     
)(


    input                                                              clk        ,
    input                                                              rst_n      ,
    input                                                              en         ,
    input signed [ FEATURE_WIDE+4'd15:0]                               in_data    ,
    input                                                              mac_en     ,
    input                                                              choice     ,
    
    output     signed [FEATURE_WIDE+4'd15:0]                           out_data   ,
    output                                                             end_en    

);



/***************************************parameters*******************************************/


/********************************************************************************************/



/***************************************signals**********************************************/



/////////最高位为符号位，整数为3位，小数��//////////////


localparam A0=21463;//0.3275*2^16
localparam B0=71939;//1.0977*2^16
localparam C0=0    ;//0.0038*2^6
localparam A1=11076;//0.1690*2^16
localparam B1=46013;//0.7021*2^16
localparam C1=15   ;//0.2324*2^6
localparam A2=1848 ;//0.0282*2^16
localparam B2=11161;//0.1703*2^16
localparam C2=47   ;//0.7370*2^6
localparam A3=256  ;//0.0039*2^16
localparam B3=2051 ;//0.0313*2^16
localparam C3=60   ;//0.9363*2^6


reg [2*(FEATURE_WIDE+5'd16)+4'd15:0]               mult_a0     ;

reg [FEATURE_WIDE+5'd31:0]                         mult_b0     ;

reg  [6:0]                                         mult_c0     ;

reg [FEATURE_WIDE+4'd15:0]                         in_data_r   ;

reg [FEATURE_WIDE+4'd15:0]                         in_data_rr  ;

reg [8:0]                                          sum         ;

reg [8:0]                                          out_data_r  ;

reg                                                flag_ne     ;
                                                   
reg                                                flag_ne_r   ;
                                                   
reg                                                flag_ne_rr  ;

wire signed [FEATURE_WIDE+4'd15:0]                 out_data_rr ;

reg [3:0]                                          cnt_y       ;

wire signed [ FEATURE_WIDE+4'd15:0]                result_r    ;





assign out_data=(choice==1'b1)?(out_data_rr+7'd64)>>1:out_data_rr;

assign  out_data_rr={{(FEATURE_WIDE+3'd7){out_data_r[8]}},out_data_r};

assign end_en =(cnt_y==3'd3 && mac_en==1'b0)?1'b1:1'b0;

assign result_r=(choice==1'b1)?{in_data[FEATURE_WIDE+4'd15],in_data[FEATURE_WIDE+4'd15:1]}:in_data;



always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        cnt_y<=3'd0;
    end 
    else if (en==1'b1 && mac_en==1'b0)begin
        if(cnt_y==3'd3)begin
        cnt_y<=3'd3;
       end 
       else begin
        cnt_y<=cnt_y+1'b1;
      end  
    end 
    else begin
        cnt_y<=3'd0;
    end 
end 





/********************************************************************************************/


/**************************************main**************************************************/



/*******************************************************************************************/


/////////取绝对�/////////
always@(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin 
        in_data_r <={(FEATURE_WIDE+5'd16){1'b0}};
        in_data_rr<={(FEATURE_WIDE+5'd16){1'b0}};
        flag_ne   <=1'b0;
        flag_ne_rr<=1'b0;
        flag_ne_r <=1'b0;
    end
    else if(result_r[FEATURE_WIDE+4'd15]==1'b1)begin 
        in_data_r <=~result_r+1'b1;
        in_data_rr<=in_data_r;
        flag_ne   <=1'b1;
        flag_ne_r <=flag_ne;
        flag_ne_rr<=flag_ne_r;
    end
    else begin   
        in_data_r <=result_r;
        in_data_rr<=in_data_r;
        flag_ne   <=1'b0;
        flag_ne_r <=flag_ne;
        flag_ne_rr<=flag_ne_r;
    end
end


 
 always@(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        mult_a0<={(2*(FEATURE_WIDE+5'd16)+5'd16){1'b0}};
        mult_b0<={((FEATURE_WIDE+5'd16)+5'd16){1'b0}};
        mult_c0<=7'd0;
    end
    
    else if(in_data_r[FEATURE_WIDE+4'd14:6]>=0 && in_data_r[FEATURE_WIDE+4'd14:6]<1)begin 
        mult_a0<=(in_data_r*in_data_r*A0)>>22;
        mult_b0<=          (in_data_r*B0)>>16;
        mult_c0<=C0;
    end

    else if(in_data_r[FEATURE_WIDE+4'd14:6]>=1 && in_data_r[FEATURE_WIDE+4'd14:6]<2)begin 
        mult_a0<=(in_data_r*in_data_r*A1)>>22;
        mult_b0<=          (in_data_r*B1)>>16;
        mult_c0<=C1;
    end
    
    else if(in_data_r[FEATURE_WIDE+4'd14:6]>=2 && in_data_r[FEATURE_WIDE+4'd14:6]<3)begin 
        mult_a0<=(in_data_r*in_data_r*A2)>>22;
        mult_b0<=          (in_data_r*B2)>>16;
        mult_c0<=C2;
    end
    
    else if(in_data_r[FEATURE_WIDE+4'd14:6]>=3 && in_data_r[FEATURE_WIDE+4'd14:6]<4)begin 
        mult_a0<=(in_data_r*in_data_r*A3)>>22;
        mult_b0<=          (in_data_r*B3)>>16;
        mult_c0<=C3 ;
    end
end
 
always@(posedge clk or negedge rst_n)begin 
    if(!rst_n)
            sum<=9'd0;
    else if(in_data_rr[FEATURE_WIDE+4'd14:6]>=0 && in_data_rr[FEATURE_WIDE+4'd14:6]<1)
            sum<=mult_b0-mult_a0-mult_c0;
    else if(in_data_rr[FEATURE_WIDE+4'd14:6]>=1 && in_data_rr[FEATURE_WIDE+4'd14:6]<4) 
            sum<=mult_b0-mult_a0+mult_c0;
    else if(in_data_rr[FEATURE_WIDE+4'd14:6]>=4)
            sum<=9'b0_0100_0000 ;
end



////////当输入的值为负数时，运算结果要取�///////
always@(posedge clk )begin 
    if(flag_ne_rr==1'b1)
        out_data_r<=~sum+1'b1;
    else 
        out_data_r<=sum;
end



endmodule