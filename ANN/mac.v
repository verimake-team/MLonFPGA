

module  mac 
#(
  parameter FEATURE_WIDE =4,   
  parameter CLASS_NUM    =8  
)(

    input                                               clk        ,
    input                                               rst_n      ,
    input                                               en         ,
    input signed [FEATURE_WIDE+4'd15:0]                 feature    ,
    input        [127:0]                                w          ,
    input [4:0]                                         n_num      ,
    input [4:0]                                         f_num      ,
    input                                               flag_end   ,
    
    output                                              flag_begin ,
    output           [8*(FEATURE_WIDE+5'd16)-1:0]       result     ,
    output   reg                                        en_end     ,
    output                                              en_addr   
);


reg  [3:0]                                       cnt_x     ;
                                                         
reg  [4:0]                                       cnt_y     ;

reg signed  [FEATURE_WIDE+5'd25:0]               result0   ;    

reg signed  [FEATURE_WIDE+5'd25:0]               result1   ;   

reg signed  [FEATURE_WIDE+5'd25:0]               result2   ;   

reg signed  [FEATURE_WIDE+5'd25:0]               result3   ;   

reg signed  [FEATURE_WIDE+5'd25:0]               result4   ;   

reg signed  [FEATURE_WIDE+5'd25:0]               result5   ;   

reg signed  [FEATURE_WIDE+5'd25:0]               result6   ;   

reg signed  [FEATURE_WIDE+5'd25:0]               result7   ; 

wire signed  [FEATURE_WIDE+5'd25:0]              result0r  ;    
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result1r  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result2r  ;   
                                             
wire signed  [FEATURE_WIDE+5'd25:0]              result3r  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result4r  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result5r  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result6r  ;   
                                          
wire signed  [FEATURE_WIDE+5'd25:0]              result7r  ;

wire signed  [FEATURE_WIDE+5'd25:0]              result00  ;    
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result11  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result22  ;   
                                             
wire signed  [FEATURE_WIDE+5'd25:0]              result33  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result44  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result55  ;   
                                            
wire signed  [FEATURE_WIDE+5'd25:0]              result66  ;   
                                          
wire signed  [FEATURE_WIDE+5'd25:0]              result77  ;

wire signed  [FEATURE_WIDE+3'd5:0]               b0        ;     

wire signed  [FEATURE_WIDE+3'd5:0]               b1        ;   
                                                  
wire signed  [FEATURE_WIDE+3'd5:0]               b2        ;   
                                              
wire signed  [FEATURE_WIDE+3'd5:0]               b3        ;   
                                              
wire signed  [FEATURE_WIDE+3'd5:0]               b4        ;   
                                           
wire signed  [FEATURE_WIDE+3'd5:0]               b5        ;   
                                           
wire signed  [FEATURE_WIDE+3'd5:0]               b6        ;   
                                             
wire signed  [FEATURE_WIDE+3'd5:0]               b7        ;  
                                                
wire signed  [FEATURE_WIDE+3'd5:0]               w0        ;    
           
wire signed  [FEATURE_WIDE+3'd5:0]               w1        ;   
                                            
wire signed  [FEATURE_WIDE+3'd5:0]               w2        ;   
                                              
wire signed  [FEATURE_WIDE+3'd5:0]               w3        ;   
                                             
wire signed  [FEATURE_WIDE+3'd5:0]               w4        ;   
                                              
wire signed  [FEATURE_WIDE+3'd5:0]               w5        ;   
                                               
wire signed  [FEATURE_WIDE+3'd5:0]               w6        ;   
                                              
wire signed  [FEATURE_WIDE+3'd5:0]               w7        ; 

reg                                              en_r      ;

reg                                              en_rr     ;

reg signed [FEATURE_WIDE+4'd15:0]                feature_r ;

reg signed [FEATURE_WIDE+4'd15:0]                feature_rr;

reg [4:0]                                        n_num_r   ;

reg [4:0]                                        n_num_rr  ;

wire                                             en_end_r  ;

reg                                              en_end_rr ;

reg                                              en_end_rrr;

reg                                              flag      ;







assign result={result7[FEATURE_WIDE+4'd15:0],result6[FEATURE_WIDE+4'd15:0],result5[FEATURE_WIDE+4'd15:0]
            ,result4[FEATURE_WIDE+4'd15:0],result3[FEATURE_WIDE+4'd15:0],result2[FEATURE_WIDE+4'd15:0]
            ,result1[FEATURE_WIDE+4'd15:0],result0[FEATURE_WIDE+4'd15:0]};

assign w0=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[ 15:  0]:{(FEATURE_WIDE+3'd5){1'b0}};
assign w1=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[ 31: 16]:{(FEATURE_WIDE+3'd5){1'b0}};
assign w2=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[ 47: 32]:{(FEATURE_WIDE+3'd5){1'b0}};
assign w3=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[ 63: 48]:{(FEATURE_WIDE+3'd5){1'b0}};
assign w4=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[ 79: 64]:{(FEATURE_WIDE+3'd5){1'b0}};
assign w5=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[ 95: 80]:{(FEATURE_WIDE+3'd5){1'b0}};
assign w6=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[111: 96]:{(FEATURE_WIDE+3'd5){1'b0}};
assign w7=(en_end_rrr==1'b0 || (cnt_x!=f_num && flag_end==1'b1))?w[127:112]:{(FEATURE_WIDE+3'd5){1'b0}};

assign b0=(en_end_rrr==1'b1 || cnt_x==f_num )?w[ 15:  0]:{(FEATURE_WIDE+3'd5){1'b0}};
assign b1=(en_end_rrr==1'b1 || cnt_x==f_num )?w[ 31: 16]:{(FEATURE_WIDE+3'd5){1'b0}};
assign b2=(en_end_rrr==1'b1 || cnt_x==f_num )?w[ 47: 32]:{(FEATURE_WIDE+3'd5){1'b0}};
assign b3=(en_end_rrr==1'b1 || cnt_x==f_num )?w[ 63: 48]:{(FEATURE_WIDE+3'd5){1'b0}};
assign b4=(en_end_rrr==1'b1 || cnt_x==f_num )?w[ 79: 64]:{(FEATURE_WIDE+3'd5){1'b0}};
assign b5=(en_end_rrr==1'b1 || cnt_x==f_num )?w[ 95: 80]:{(FEATURE_WIDE+3'd5){1'b0}};
assign b6=(en_end_rrr==1'b1 || cnt_x==f_num )?w[111: 96]:{(FEATURE_WIDE+3'd5){1'b0}};
assign b7=(en_end_rrr==1'b1 || cnt_x==f_num )?w[127:112]:{(FEATURE_WIDE+3'd5){1'b0}};


assign result00=(w0 * feature_rr)>>6;
assign result11=(w1 * feature_rr)>>6;
assign result22=(w2 * feature_rr)>>6;
assign result33=(w3 * feature_rr)>>6;
assign result44=(w4 * feature_rr)>>6;
assign result55=(w5 * feature_rr)>>6;
assign result66=(w6 * feature_rr)>>6;
assign result77=(w7 * feature_rr)>>6;


assign result0r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result0;
assign result1r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result1;
assign result2r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result2;
assign result3r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result3;
assign result4r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result4;
assign result5r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result5;
assign result6r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result6;
assign result7r=(cnt_x==4'd0 && flag_end==1'b1)?{(FEATURE_WIDE+5'd26){1'b0}}:result7;


assign en_end_r=(en==1'b1 && cnt_y==f_num)?1'b1:1'b0;

assign en_addr=((flag==1'b0 && en==1'b1 ) || flag_end==1'b1 )?1'b1:1'b0;

assign flag_begin=(cnt_x==4'd0 && flag_end==1'b1)?1'b1:1'b0;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        flag<=1'b0;
    end    
    else if(en ==1'b0)begin
        flag<=1'b0;
    end 
    else if (en_end_r==1'b1)begin
        flag<=1'b1;
    end
end 

always@(posedge clk )begin
    en_r<=en;
    en_rr<=en_r;
    feature_r<=feature;
    feature_rr<=feature_r;
    n_num_r<=n_num;
    n_num_rr<=n_num_r;
    en_end_rr<=en_end_r;
    en_end_rrr<=en_end_rr;
    en_end<=en_end_rrr;
end 

always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt_x<=4'd0;
    end
    else if(cnt_x==f_num)begin
         cnt_x<=4'd0;
    end
    else if(flag_end==1'b1 && en_rr==1'b1)begin
        cnt_x<=cnt_x+1'b1;
        end
end
 

always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt_y<=5'd0;

    end
    else if (en==1'b1)begin
        if(cnt_y==f_num+1'b1)begin
            cnt_y<=f_num+1'b1;
        end
        else begin
        cnt_y<=cnt_y+1'b1;
        end
    end
    else begin
        cnt_y<=5'd0;
    end 
end  


always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
         result0 <={(FEATURE_WIDE+5'd26){1'b0}};
         result1 <={(FEATURE_WIDE+5'd26){1'b0}};
         result2 <={(FEATURE_WIDE+5'd26){1'b0}};
         result3 <={(FEATURE_WIDE+5'd26){1'b0}};
         result4 <={(FEATURE_WIDE+5'd26){1'b0}};
         result5 <={(FEATURE_WIDE+5'd26){1'b0}};
         result6 <={(FEATURE_WIDE+5'd26){1'b0}};
         result7 <={(FEATURE_WIDE+5'd26){1'b0}};
    end 
    else if (en_rr==1'b1)begin
         result0 <=(n_num_rr>=4'd1)? result0r+{{6{result00[FEATURE_WIDE+5'd19]}},result00[FEATURE_WIDE+5'd19:0]}+b0:{(FEATURE_WIDE+5'd26){1'b0}};
         result1 <=(n_num_rr>=4'd2)? result1r+{{6{result11[FEATURE_WIDE+5'd19]}},result11[FEATURE_WIDE+5'd19:0]}+b1:{(FEATURE_WIDE+5'd26){1'b0}};
         result2 <=(n_num_rr>=4'd3)? result2r+{{6{result22[FEATURE_WIDE+5'd19]}},result22[FEATURE_WIDE+5'd19:0]}+b2:{(FEATURE_WIDE+5'd26){1'b0}};
         result3 <=(n_num_rr>=4'd4)? result3r+{{6{result33[FEATURE_WIDE+5'd19]}},result33[FEATURE_WIDE+5'd19:0]}+b3:{(FEATURE_WIDE+5'd26){1'b0}};
         result4 <=(n_num_rr>=4'd5)? result4r+{{6{result44[FEATURE_WIDE+5'd19]}},result44[FEATURE_WIDE+5'd19:0]}+b4:{(FEATURE_WIDE+5'd26){1'b0}};
         result5 <=(n_num_rr>=4'd6)? result5r+{{6{result55[FEATURE_WIDE+5'd19]}},result55[FEATURE_WIDE+5'd19:0]}+b5:{(FEATURE_WIDE+5'd26){1'b0}};
         result6 <=(n_num_rr>=4'd7)? result6r+{{6{result66[FEATURE_WIDE+5'd19]}},result66[FEATURE_WIDE+5'd19:0]}+b6:{(FEATURE_WIDE+5'd26){1'b0}};
         result7 <=(n_num_rr>=4'd8)? result7r+{{6{result77[FEATURE_WIDE+5'd19]}},result77[FEATURE_WIDE+5'd19:0]}+b7:{(FEATURE_WIDE+5'd26){1'b0}};
    end 
    else begin
         result0 <={(FEATURE_WIDE+5'd26){1'b0}};
         result1 <={(FEATURE_WIDE+5'd26){1'b0}};
         result2 <={(FEATURE_WIDE+5'd26){1'b0}};
         result3 <={(FEATURE_WIDE+5'd26){1'b0}};
         result4 <={(FEATURE_WIDE+5'd26){1'b0}};
         result5 <={(FEATURE_WIDE+5'd26){1'b0}};
         result6 <={(FEATURE_WIDE+5'd26){1'b0}};
         result7 <={(FEATURE_WIDE+5'd26){1'b0}};

    end 

end 





endmodule 