module class_result_con
#(
  parameter NUM          =3  ,
  parameter CLASS_NUM    =6  ,
  parameter FEATURE_WIDE =4  ,
  parameter K            =7  , 
  parameter LEN          =12     
)(
    input                                     clk              ,     
    input                                     rst_n            ,
    input                                     flag             ,
    input  [K*(2*LEN+FEATURE_WIDE)-1'b1:0]    ocandidate       ,
    input  [K*(2*LEN+FEATURE_WIDE)-1'b1:0]    ecandidate       ,
    input  [K*NUM-1'b1:0]                     lab_e            ,
    input  [K*NUM-1'b1:0]                     lab_o            ,

    output [NUM-1'b1:0]                       lab
 

);



wire [NUM-1'b1:0]           lab0          ;
                                        
wire [NUM-1'b1:0]           lab1          ;
                                          
wire [NUM-1'b1:0]           lab2          ;
                                         
wire [NUM-1'b1:0]           lab3          ;
                                         
wire [NUM-1'b1:0]           lab4          ;
                                         
wire [NUM-1'b1:0]           lab5          ;
                                          
wire [NUM-1'b1:0]           lab6          ;
                                          
wire [NUM-1'b1:0]           lab7          ;
                                          
wire [NUM-1'b1:0]           lab8          ;
                                          
wire [NUM-1'b1:0]           lab9          ;
                                        
wire [NUM-1'b1:0]           lab10         ;
                                         
wire [NUM-1'b1:0]           lab11         ;
                                         
wire [NUM-1'b1:0]           lab12         ;
                                          
wire [NUM-1'b1:0]           lab13         ;
                                          
wire [NUM-1'b1:0]           lab14         ;
                                          
wire [NUM-1'b1:0]           lab15         ;
                            
reg [4:0]                   cnt           ;
                                        
reg [3:0]                   cnt_r         ;
                                        
reg [4:0]                   cnt_0         ;
                                        
reg [4:0]                   cnt_1         ;
                                        
reg [4:0]                   cnt_2         ;
                                        
reg [4:0]                   cnt_3         ;
                                        
reg [4:0]                   cnt_4         ;
                                        
reg [4:0]                   cnt_5         ;
                                        
reg [4:0]                   cnt_6         ;
                                        
reg [4:0]                   cnt_7         ;
                                        
reg [4:0]                   cnt_8         ;
                                        
reg [4:0]                   cnt_9         ;
                                        
reg [4:0]                   cnt_10        ;
                                        
reg [4:0]                   cnt_11        ;
                                        
reg [4:0]                   cnt_12        ;
                                        
reg [4:0]                   cnt_13        ;
                                        
reg [4:0]                   cnt_14        ;
                                        
reg [4:0]                   cnt_15        ;
                                        
wire                        flag_0        ;
                                        
wire                        flag_1        ;
                                        
wire                        flag_2        ;
                                        
wire                        flag_3        ;
                                        
wire                        flag_4        ;
                                        
wire                        flag_5        ;
                                        
wire                        flag_6        ;
                                        
wire                        flag_7        ;
                                        
wire                        flag_8        ;
                                        
wire                        flag_9        ;
                                        
wire                        flag_10       ;
                                        
wire                        flag_11       ;
                                        
wire                        flag_12       ;
                                        
wire                        flag_13       ;
                                        
wire                        flag_14       ;
                                        
wire                        flag_15       ;
                            
reg                         flag_out      ;
                            
reg [4:0]                   result_r      ;
                            
reg [NUM-1:0]               lab_r         ;
                            
wire                        en            ;



 


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt<=5'd0;
    end
    else if (cnt==K)begin
        cnt<=K;

    end 
    else if (en==1'b1)begin
        cnt<=cnt+1'b1;
    end 
end 


assign flag_0 =(CLASS_NUM>=1'b1 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==1'b1 && cnt==5'd0 || lab1 ==1'b1 && cnt==5'd1 || lab2 ==1'b1 && cnt==5'd2 
              || lab3 ==1'b1 && cnt==5'd3 || lab4 ==1'b1 && cnt==5'd4 || lab5 ==1'b1 && cnt==5'd5 || lab6 ==1'b1 && cnt==5'd6 || lab7 ==1'b1 && cnt==5'd7 
              || lab8 ==1'b1 && cnt==5'd8 || lab9 ==1'b1 && cnt==5'd9 || lab10==1'b1 && cnt==5'd10|| lab11==1'b1 && cnt==5'd11|| lab12==1'b1 && cnt==5'd12 
              || lab13==1'b1 && cnt==5'd13|| lab14==1'b1 && cnt==5'd14|| lab15==1'b1 && cnt==5'd15)?1'b1:1'b0:1'b0; 
              
assign flag_1 =(CLASS_NUM>=2'd2 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==2'd2 && cnt==5'd0 || lab1 ==2'd2 && cnt==5'd1 || lab2 ==2'd2 && cnt==5'd2 
              || lab3 ==2'd2 && cnt==5'd3 || lab4 ==2'd2 && cnt==5'd4 || lab5 ==2'd2 && cnt==5'd5 || lab6 ==2'd2 && cnt==5'd6 || lab7 ==2'd2 && cnt==5'd7
              || lab8 ==2'd2 && cnt==5'd8 || lab9 ==2'd2 && cnt==5'd9 || lab10==2'd2 && cnt==5'd10|| lab11==2'd2 && cnt==5'd11|| lab12==2'd2 && cnt==5'd12 
              || lab13==2'd2 && cnt==5'd13|| lab14==2'd2 && cnt==5'd14|| lab15==2'd2 && cnt==5'd15)?1'b1:1'b0:1'b0;       
             
assign flag_2 =(CLASS_NUM>=2'd3 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==2'd3 && cnt==5'd0 || lab1 ==2'd3 && cnt==5'd1 || lab2 ==2'd3 && cnt==5'd2 
              || lab3 ==2'd3 && cnt==5'd3 || lab4 ==2'd3 && cnt==5'd4 || lab5 ==2'd3 && cnt==5'd5 || lab6 ==2'd3 && cnt==5'd6 || lab7 ==2'd3 && cnt==5'd7
              || lab8 ==2'd3 && cnt==5'd8 || lab9 ==2'd3 && cnt==5'd9 || lab10==2'd3 && cnt==5'd10|| lab11==2'd3 && cnt==5'd11|| lab12==2'd3 && cnt==5'd12 
              || lab13==2'd3 && cnt==5'd13|| lab14==2'd3 && cnt==5'd14|| lab15==2'd3 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_3 =(CLASS_NUM>=3'd4 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==3'd4 && cnt==5'd0 || lab1 ==3'd4 && cnt==5'd1 || lab2 ==3'd4 && cnt==5'd2 
              || lab3 ==3'd4 && cnt==5'd3 || lab4 ==3'd4 && cnt==5'd4 || lab5 ==3'd4 && cnt==5'd5 || lab6 ==3'd4 && cnt==5'd6 || lab7 ==3'd4 && cnt==5'd7
              || lab8 ==3'd4 && cnt==5'd8 || lab9 ==3'd4 && cnt==5'd9 || lab10==3'd4 && cnt==5'd10|| lab11==3'd4 && cnt==5'd11|| lab12==3'd4 && cnt==5'd12 
              || lab13==3'd4 && cnt==5'd13|| lab14==3'd4 && cnt==5'd14|| lab15==3'd4 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_4 =(CLASS_NUM>=3'd5 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==3'd5 && cnt==5'd0 || lab1 ==3'd5 && cnt==5'd1 || lab2 ==3'd5 && cnt==5'd2 
              || lab3 ==3'd5 && cnt==5'd3 || lab4 ==3'd5 && cnt==5'd4 || lab5 ==3'd5 && cnt==5'd5 || lab6 ==3'd5 && cnt==5'd6 || lab7 ==3'd5 && cnt==5'd7
              || lab8 ==3'd5 && cnt==5'd8 || lab9 ==3'd5 && cnt==5'd9 || lab10==3'd5 && cnt==5'd10|| lab11==3'd5 && cnt==5'd11|| lab12==3'd5 && cnt==5'd12 
              || lab13==3'd5 && cnt==5'd13|| lab14==3'd5 && cnt==5'd14|| lab15==3'd5 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_5 =(CLASS_NUM>=3'd6 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==3'd6 && cnt==5'd0 || lab1 ==3'd6 && cnt==5'd1 || lab2 ==3'd6 && cnt==5'd2 
              || lab3 ==3'd6 && cnt==5'd3 || lab4 ==3'd6 && cnt==5'd4 || lab5 ==3'd6 && cnt==5'd5 || lab6 ==3'd6 && cnt==5'd6 || lab7 ==3'd6 && cnt==5'd7
              || lab8 ==3'd6 && cnt==5'd8 || lab9 ==3'd6 && cnt==5'd9 || lab10==3'd6 && cnt==5'd10|| lab11==3'd6 && cnt==5'd11|| lab12==3'd6 && cnt==5'd12 
              || lab13==3'd6 && cnt==5'd13|| lab14==3'd6 && cnt==5'd14|| lab15==3'd6 && cnt==5'd15)?1'b1:1'b0:1'b0;
             
assign flag_6 =(CLASS_NUM>=3'd7 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==3'd7 && cnt==5'd0 || lab1 ==3'd7 && cnt==5'd1 || lab2 ==3'd7 && cnt==5'd2 
              || lab3 ==3'd7 && cnt==5'd3 || lab4 ==3'd7 && cnt==5'd4 || lab5 ==3'd7 && cnt==5'd5 || lab6 ==3'd7 && cnt==5'd6 || lab7 ==3'd7 && cnt==5'd7
              || lab8 ==3'd7 && cnt==5'd8 || lab9 ==3'd7 && cnt==5'd9 || lab10==3'd7 && cnt==5'd10|| lab11==3'd7 && cnt==5'd11|| lab12==3'd7 && cnt==5'd12 
              || lab13==3'd7 && cnt==5'd13|| lab14==3'd7 && cnt==5'd14|| lab15==3'd7 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_7 =(CLASS_NUM>=4'd8 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==4'd8 && cnt==5'd0 || lab1 ==4'd8 && cnt==5'd1 || lab2 ==4'd8 && cnt==5'd2 
              || lab3 ==4'd8 && cnt==5'd3 || lab4 ==4'd8 && cnt==5'd4 || lab5 ==4'd8 && cnt==5'd5 || lab6 ==4'd8 && cnt==5'd6 || lab7 ==4'd8 && cnt==5'd7
              || lab8 ==4'd8 && cnt==5'd8 || lab9 ==4'd8 && cnt==5'd9 || lab10==4'd8 && cnt==5'd10|| lab11==4'd8 && cnt==5'd11|| lab12==4'd8 && cnt==5'd12 
              || lab13==4'd8 && cnt==5'd13|| lab14==4'd8 && cnt==5'd14|| lab15==4'd8 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_8 =(CLASS_NUM>=4'd9 && en==1'b1 && cnt<=K-1'b1)?            (lab0 ==4'd9 && cnt==5'd0 || lab1 ==4'd9 && cnt==5'd1 || lab2 ==4'd9 && cnt==5'd2 
              || lab3 ==4'd9 && cnt==5'd3 || lab4 ==4'd9 && cnt==5'd4 || lab5 ==4'd9 && cnt==5'd5 || lab6 ==4'd9 && cnt==5'd6 || lab7 ==4'd9 && cnt==5'd7
              || lab8 ==4'd9 && cnt==5'd8 || lab9 ==4'd9 && cnt==5'd9 || lab10==4'd9 && cnt==5'd10|| lab11==4'd9 && cnt==5'd11|| lab12==4'd9 && cnt==5'd12 
              || lab13==4'd9 && cnt==5'd13|| lab14==4'd9 && cnt==5'd14|| lab15==4'd9 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_9 =(CLASS_NUM>=4'd10&& en==1'b1 && cnt<=K-1'b1)?              (lab0 ==4'd10 && cnt==5'd0 || lab1 ==4'd10 && cnt==5'd1 || lab2 ==4'd10 && cnt==5'd2 
              || lab3 ==4'd10 && cnt==5'd3 || lab4 ==4'd10 && cnt==5'd4 || lab5 ==4'd10 && cnt==5'd5 || lab6 ==4'd10 && cnt==5'd6 || lab7 ==4'd10 && cnt==5'd7
              || lab8 ==4'd10 && cnt==5'd8 || lab9 ==4'd10 && cnt==5'd9 || lab10==4'd10 && cnt==5'd10|| lab11==4'd10 && cnt==5'd11|| lab12==4'd10 && cnt==5'd12 
              || lab13==4'd10 && cnt==5'd13|| lab14==4'd10 && cnt==5'd14|| lab15==4'd10 && cnt==5'd15)?1'b1:1'b0:1'b0;
             
assign flag_10=(CLASS_NUM>=4'd11&& en==1'b1 && cnt<=K-1'b1)?              (lab0 ==4'd11 && cnt==5'd0 || lab1 ==4'd11 && cnt==5'd1 || lab2 ==4'd11 && cnt==5'd2 
              || lab3 ==4'd11 && cnt==5'd3 || lab4 ==4'd11 && cnt==5'd4 || lab5 ==4'd11 && cnt==5'd5 || lab6 ==4'd11 && cnt==5'd6 || lab7 ==4'd11 && cnt==5'd7
              || lab8 ==4'd11 && cnt==5'd8 || lab9 ==4'd11 && cnt==5'd9 || lab10==4'd11 && cnt==5'd10|| lab11==4'd11 && cnt==5'd11|| lab12==4'd11 && cnt==5'd12 
              || lab13==4'd11 && cnt==5'd13|| lab14==4'd11 && cnt==5'd14|| lab15==4'd11 && cnt==5'd15)?1'b1:1'b0:1'b0;
             
assign flag_11=(CLASS_NUM>=4'd12&& en==1'b1 && cnt<=K-1'b1)?              (lab0 ==4'd12 && cnt==5'd0 || lab1 ==4'd12 && cnt==5'd1 || lab2 ==4'd12 && cnt==5'd2 
              || lab3 ==4'd12 && cnt==5'd3 || lab4 ==4'd12 && cnt==5'd4 || lab5 ==4'd12 && cnt==5'd5 || lab6 ==4'd12 && cnt==5'd6 || lab7 ==4'd12 && cnt==5'd7
              || lab8 ==4'd12 && cnt==5'd8 || lab9 ==4'd12 && cnt==5'd9 || lab10==4'd12 && cnt==5'd10|| lab11==4'd12 && cnt==5'd11|| lab12==4'd12 && cnt==5'd12 
              || lab13==4'd12 && cnt==5'd13|| lab14==4'd12 && cnt==5'd14|| lab15==4'd12 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_12=(CLASS_NUM>=4'd13&& en==1'b1 && cnt<=K-1'b1)?              (lab0 ==4'd13 && cnt==5'd0 || lab1 ==4'd13 && cnt==5'd1 || lab2 ==4'd13 && cnt==5'd2 
              || lab3 ==4'd13 && cnt==5'd3 || lab4 ==4'd13 && cnt==5'd4 || lab5 ==4'd13 && cnt==5'd5 || lab6 ==4'd13 && cnt==5'd6 || lab7 ==4'd13 && cnt==5'd7
              || lab8 ==4'd13 && cnt==5'd8 || lab9 ==4'd13 && cnt==5'd9 || lab10==4'd13 && cnt==5'd10|| lab11==4'd13 && cnt==5'd11|| lab12==4'd13 && cnt==5'd12 
              || lab13==4'd13 && cnt==5'd13|| lab14==4'd13 && cnt==5'd14|| lab15==4'd13 && cnt==5'd15)?1'b1:1'b0:1'b0;
              
assign flag_13=(CLASS_NUM>=4'd14&& en==1'b1 && cnt<=K-1'b1)?              (lab0 ==4'd14 && cnt==5'd0 || lab1 ==4'd14 && cnt==5'd1 || lab2 ==4'd14 && cnt==5'd2 
              || lab3 ==4'd14 && cnt==5'd3 || lab4 ==4'd14 && cnt==5'd4 || lab5 ==4'd14 && cnt==5'd5 || lab6 ==4'd14 && cnt==5'd6 || lab7 ==4'd14 && cnt==5'd7
              || lab8 ==4'd14 && cnt==5'd8 || lab9 ==4'd14 && cnt==5'd9 || lab10==4'd14 && cnt==5'd10|| lab11==4'd14 && cnt==5'd11|| lab12==4'd14 && cnt==5'd12 
              || lab13==4'd14 && cnt==5'd13|| lab14==4'd14 && cnt==5'd14|| lab15==4'd14 && cnt==5'd15)?1'b1:1'b0:1'b0;  
             
assign flag_14=(CLASS_NUM>=4'd15&& en==1'b1 && cnt<=K-1'b1)?              (lab0 ==4'd15 && cnt==5'd0 || lab1 ==4'd15 && cnt==5'd1 || lab2 ==4'd15 && cnt==5'd2 
              || lab3 ==4'd15 && cnt==5'd3 || lab4 ==4'd15 && cnt==5'd4 || lab5 ==4'd15 && cnt==5'd5 || lab6 ==4'd15 && cnt==5'd6 || lab7 ==4'd15 && cnt==5'd7
              || lab8 ==4'd15 && cnt==5'd8 || lab9 ==4'd15 && cnt==5'd9 || lab10==4'd15 && cnt==5'd10|| lab11==4'd15 && cnt==5'd11|| lab12==4'd15 && cnt==5'd12 
              || lab13==4'd15 && cnt==5'd13|| lab14==4'd15 && cnt==5'd14|| lab15==4'd15 && cnt==5'd15)?1'b1:1'b0:1'b0;

assign flag_15=(CLASS_NUM>=5'd16&& en==1'b1 && cnt<=K-1'b1)?              (lab0 ==5'd16 && cnt==5'd0 || lab1 ==5'd16 && cnt==5'd1 || lab2 ==5'd16 && cnt==5'd2 
              || lab3 ==5'd16 && cnt==5'd3 || lab4 ==5'd16 && cnt==5'd4 || lab5 ==5'd16 && cnt==5'd5 || lab6 ==5'd16 && cnt==5'd6 || lab7 ==5'd16 && cnt==5'd7
              || lab8 ==5'd16 && cnt==5'd8 || lab9 ==5'd16 && cnt==5'd9 || lab10==5'd16 && cnt==5'd10|| lab11==5'd16 && cnt==5'd11|| lab12==5'd16 && cnt==5'd12 
              || lab13==5'd16 && cnt==5'd13|| lab14==5'd16 && cnt==5'd14|| lab15==5'd16 && cnt==5'd15)?1'b1:1'b0:1'b0;            
              





always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_0<=0;
    end
    else if (flag_0==1'b1)begin
        cnt_0<=cnt_0+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_1<=0;
    end
    else if (flag_1==1'b1)begin
        cnt_1<=cnt_1+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_2<=0;
    end
    else if (flag_2==1'b1)begin
        cnt_2<=cnt_2+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_3<=0;
    end
    else if (flag_3==1'b1)begin
        cnt_3<=cnt_3+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_4<=0;
    end
    else if (flag_4==1'b1 )begin
        cnt_4<=cnt_4+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_5<=0;
    end
    else if (flag_5==1'b1)begin
        cnt_5<=cnt_5+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_6<=0;
    end
    else if (flag_6==1'b1)begin
        cnt_6<=cnt_6+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_7<=0;
    end
    else if (flag_7==1'b1)begin
        cnt_7<=cnt_7+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_8<=0;
    end
    else if (flag_8==1'b1)begin
        cnt_8<=cnt_8+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_9<=0;
    end
    else if (flag_9==1'b1)begin
        cnt_9<=cnt_9+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_10<=0;
    end
    else if (flag_10==1'b1)begin
        cnt_10<=cnt_10+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_11<=0;
    end
    else if (flag_11==1'b1)begin
        cnt_11<=cnt_11+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_12<=0;
    end
    else if (flag_12==1'b1)begin
        cnt_12<=cnt_12+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_13<=0;
    end
    else if (flag_13==1'b1)begin
        cnt_13<=cnt_13+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_14<=0;
    end
    else if (flag_14==1'b1)begin
        cnt_14<=cnt_14+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_15<=0;
    end
    else if (flag_15==1'b1)begin
        cnt_15<=cnt_15+1'b1;
    end 
end 


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_r<=0;
        flag_out<=0;
    end
    else if (cnt_r==CLASS_NUM-2)begin
        cnt_r<=CLASS_NUM-2;
        flag_out<=1'b1;
    end 
    else if (cnt==K)begin
        cnt_r<=cnt_r+1'b1;
    end 
end 

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        result_r<=0;
        lab_r<=0;
    end
    else if (cnt==K)begin
     case(cnt_r)
     4'd0:begin
          if(CLASS_NUM>=2 && cnt_0<cnt_1)begin
            result_r<=cnt_1;
            lab_r<=2;
          end 
          else begin
            result_r<=cnt_0;
            lab_r<=1;
          end
     end 
     4'd1:begin
          if(CLASS_NUM>=3 && result_r<cnt_2)begin
            result_r<=cnt_2;
            lab_r<=3;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd2:begin
          if(CLASS_NUM>=4 && result_r<cnt_3)begin
            result_r<=cnt_3;
            lab_r<=4;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd3:begin
          if(CLASS_NUM>=5 && result_r<cnt_4)begin
            result_r<=cnt_4;
            lab_r<=5;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end 
      4'd4:begin
          if(CLASS_NUM>=6 && result_r<cnt_5)begin
            result_r<=cnt_5;
            lab_r<=6;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd5:begin
          if(CLASS_NUM>=7 && result_r<cnt_6)begin
            result_r<=cnt_6;
            lab_r<=7;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd6:begin
          if(CLASS_NUM>=8 && result_r<cnt_7)begin
            result_r<=cnt_7;
            lab_r<=8;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd7:begin
          if(CLASS_NUM>=9 && result_r<cnt_8)begin
            result_r<=cnt_8;
            lab_r<=9;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd8:begin
          if(CLASS_NUM>=10 && result_r<cnt_9)begin
            result_r<=cnt_9;
            lab_r<=10;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd9:begin
          if(CLASS_NUM>=11 && result_r<cnt_10)begin
            result_r<=cnt_10;
            lab_r<=11;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd10:begin
          if(CLASS_NUM>=12 && result_r<cnt_11)begin
            result_r<=cnt_11;
            lab_r<=12;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end 
      end
      4'd11:begin
          if(CLASS_NUM>=13 && result_r<cnt_12)begin
            result_r<=cnt_12;
            lab_r<=13;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd12:begin
          if(CLASS_NUM>=14 && result_r<cnt_13)begin
            result_r<=cnt_13;
            lab_r<=14;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd13:begin
          if(CLASS_NUM>=15 && result_r<cnt_14)begin
            result_r<=cnt_14;
            lab_r<=15;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      4'd14:begin
          if(CLASS_NUM>=16 && result_r<cnt_15)begin
            result_r<=cnt_15;
            lab_r<=16;
          end 
          else begin
            result_r<=result_r;
            lab_r<=lab_r;
          end
      end
      default:begin
            result_r<=0;
            lab_r<=0;
      end
      endcase
 end 
     else begin
        result_r<=0;
        lab_r<=0;
     end
end 

assign lab=(flag_out==1'b1)?lab_r:0;



rank_candidate
#(
  .NUM         (NUM                   ),
  .K           (K                     ), 
  .FEATURE_WIDE(FEATURE_WIDE          ),
  .LEN         (LEN                   )    
)
u_rank_candidate(
    .clk              (clk           ),     
    .rst_n            (rst_n         ),
    .flag             (flag          ),
    .in_candidate0    (ocandidate    ),
    .in_candidate1    (ecandidate    ),
    .in_lab0          (lab_o         ),
    .in_lab1          (lab_e         ),
                                     
    .en               (en            ),
    .lab0             (lab0          ),
    .lab1             (lab1          ),
    .lab2             (lab2          ),
    .lab3             (lab3          ),
    .lab4             (lab4          ),
    .lab5             (lab5          ),
    .lab6             (lab6          ),
    .lab7             (lab7          ),
    .lab8             (lab8          ),
    .lab9             (lab9          ),
    .lab10            (lab10         ),
    .lab11            (lab11         ),
    .lab12            (lab12         ),
    .lab13            (lab13         ),
    .lab14            (lab14         ),
    .lab15            (lab15         )
);






endmodule