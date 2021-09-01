module rank_candidate
#(
  parameter NUM          =3  ,
  parameter K            =7  , 
  parameter FEATURE_WIDE =4  ,
  parameter LEN          =12     
)(
    input                                     clk              ,     
    input                                     rst_n            ,
    input                                     flag             ,
    input  [K*(2*LEN+FEATURE_WIDE)-1'b1:0]    in_candidate0    ,
    input  [K*(2*LEN+FEATURE_WIDE)-1'b1:0]    in_candidate1    ,
    input  [K*NUM-1'b1:0]                     in_lab0          ,
    input  [K*NUM-1'b1:0]                     in_lab1          ,
             
    output reg                                en               ,
    output reg [NUM-1'b1:0]                   lab0             ,
    output reg [NUM-1'b1:0]                   lab1             ,
    output reg [NUM-1'b1:0]                   lab2             ,
    output reg [NUM-1'b1:0]                   lab3             ,
    output reg [NUM-1'b1:0]                   lab4             ,
    output reg [NUM-1'b1:0]                   lab5             ,
    output reg [NUM-1'b1:0]                   lab6             ,
    output reg [NUM-1'b1:0]                   lab7             ,
    output reg [NUM-1'b1:0]                   lab8             ,
    output reg [NUM-1'b1:0]                   lab9             ,
    output reg [NUM-1'b1:0]                   lab10            ,
    output reg [NUM-1'b1:0]                   lab11            ,
    output reg [NUM-1'b1:0]                   lab12            , 
    output reg [NUM-1'b1:0]                   lab13            , 
    output reg [NUM-1'b1:0]                   lab14            ,
    output reg [NUM-1'b1:0]                   lab15            

 

);

reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate0    ;
                          
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate1    ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate2    ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate3    ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate4    ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate5    ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate6    ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate7    ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate8    ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate9    ;
                          
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate10   ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate11   ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate12   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate13   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate14   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]     candidate15   ;

reg [4:0]                           cnt_rank      ;
                                                  
reg                                 flag_r        ;
                                                  
wire                                en_r          ;
                                                  
reg [NUM-1'b1:0]                    com_lab       ;
                                                  
reg [2*LEN+FEATURE_WIDE-1'b1:0]     com_result    ;
                                                  
reg [4:0]                           location      ;
                                                  
reg                                 en_rr         ;



always@(posedge clk )begin

    flag_r<=flag;
    en_rr <=en_r; 
    en   <=en_rr; 
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin 
        cnt_rank<=5'd0;
    end
    else if (cnt_rank==2*K-1'b1)begin
        cnt_rank<=2*K-1'b1;
    end 
    else if(flag==1'b1)begin
        cnt_rank<=cnt_rank+1'b1;
    end 
end 


always@(posedge clk )begin
    if(!rst_n)begin
        com_result<={(2*LEN+FEATURE_WIDE){1'b1}};
        com_lab   <={NUM{1'b0}}      ;
    end 
    else if(flag==1'b1)begin
       case (cnt_rank)
           5'd0:begin
              com_result<=(K>=1)?in_candidate0[((2*LEN+FEATURE_WIDE)-1'b1):0]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=1)?in_lab0[NUM-1:0]          :{NUM{1'b0}}      ;
            end 
           5'd1:begin
              com_result<=(K>=1)?in_candidate1[((2*LEN+FEATURE_WIDE)-1'b1):0]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=1)?in_lab1[NUM-1:0]          :{NUM{1'b0}}      ;
            end 
           5'd2:begin
              com_result<=(K>=2)?in_candidate0[2*(2*LEN+FEATURE_WIDE)-1:  (2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=2)?in_lab0[2*NUM-1:  NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd3:begin
              com_result<=(K>=2)?in_candidate1[2*(2*LEN+FEATURE_WIDE)-1:  (2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=2)?in_lab1[2*NUM-1:  NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd4:begin
              com_result<=(K>=3)?in_candidate0[3*(2*LEN+FEATURE_WIDE)-1:2 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=3)?in_lab0[3*NUM-1:2 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd5:begin
              com_result<=(K>=3)?in_candidate1[3*(2*LEN+FEATURE_WIDE)-1:2 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=3)?in_lab1[3*NUM-1:2 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd6:begin
              com_result<=(K>=4)?in_candidate0[4*(2*LEN+FEATURE_WIDE)-1:3 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=4)?in_lab0[4*NUM-1:3 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd7:begin
              com_result<=(K>=4)?in_candidate1[4*(2*LEN+FEATURE_WIDE)-1:3 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=4)?in_lab1[4*NUM-1:3 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd8:begin
              com_result<=(K>=5)?in_candidate0[5*(2*LEN+FEATURE_WIDE)-1:4 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=5)?in_lab0[5*NUM-1:4 *NUM]                 :{NUM{1'b0}}       ;        
           end 
           5'd9:begin
              com_result<=(K>=5)?in_candidate1[5*(2*LEN+FEATURE_WIDE)-1:4 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=5)?in_lab1[5*NUM-1:4 *NUM]                 :{NUM{1'b0}}       ;        
           end 
           5'd10:begin
              com_result<=(K>=6)?in_candidate0[6*(2*LEN+FEATURE_WIDE)-1:5 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=6)?in_lab0[6*NUM-1:5 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd11:begin
              com_result<=(K>=6)?in_candidate1[6*(2*LEN+FEATURE_WIDE)-1:5 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=6)?in_lab1[6*NUM-1:5 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd12:begin
              com_result<=(K>=7)?in_candidate0[7*(2*LEN+FEATURE_WIDE)-1:6 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=7)?in_lab0[7*NUM-1:6 *NUM]                 :{NUM{1'b0}}      ;
           end 
           5'd13:begin
              com_result<=(K>=7)?in_candidate1[7*(2*LEN+FEATURE_WIDE)-1:6 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=7)?in_lab1[7*NUM-1:6 *NUM]                 :{NUM{1'b0}}      ;
           end 
           5'd14:begin
              com_result<=(K>=8)?in_candidate0[8*(2*LEN+FEATURE_WIDE)-1:7 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=8)?in_lab0[8*NUM-1:7 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd15:begin
              com_result<=(K>=8)?in_candidate1[8*(2*LEN+FEATURE_WIDE)-1:7 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=8)?in_lab1[8*NUM-1:7 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd16:begin
              com_result<=(K>=9)?in_candidate0[9*(2*LEN+FEATURE_WIDE)-1:8 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=9)?in_lab0[9*NUM-1:8 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd17:begin
              com_result<=(K>=9)?in_candidate1[9*(2*LEN+FEATURE_WIDE)-1:8 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=9)?in_lab1[9*NUM-1:8 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd18:begin
              com_result<=(K>=10)?in_candidate0[10*(2*LEN+FEATURE_WIDE)-1:9 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=10)?in_lab0[10*NUM-1:9 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd19:begin
              com_result<=(K>=10)?in_candidate1[10*(2*LEN+FEATURE_WIDE)-1:9 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=10)?in_lab1[10*NUM-1:9 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd20:begin
              com_result<=(K>=11)?in_candidate0[11*(2*LEN+FEATURE_WIDE)-1:10 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=11)?in_lab0[11*NUM-1:10 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd21:begin
              com_result<=(K>=11)?in_candidate1[11*(2*LEN+FEATURE_WIDE)-1:10 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=11)?in_lab1[11*NUM-1:10 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd22:begin
              com_result<=(K>=12)?in_candidate0[12*(2*LEN+FEATURE_WIDE)-1:11 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=12)?in_lab0[12*NUM-1:11 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd23:begin
              com_result<=(K>=12)?in_candidate1[12*(2*LEN+FEATURE_WIDE)-1:11 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=12)?in_lab1[12*NUM-1:11 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd24:begin
              com_result<=(K>=13)?in_candidate0[13*(2*LEN+FEATURE_WIDE)-1:12 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=13)?in_lab0[13*NUM-1:12 *NUM]                 :{NUM{1'b0}}      ;
           end 
           5'd25:begin
              com_result<=(K>=13)?in_candidate1[13*(2*LEN+FEATURE_WIDE)-1:12 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=13)?in_lab1[13*NUM-1:12 *NUM]                 :{NUM{1'b0}}      ;
           end 
           5'd26:begin
              com_result<=(K>=14)?in_candidate0[14*(2*LEN+FEATURE_WIDE)-1:13 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=14)?in_lab0[14*NUM-1:13 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd27:begin
              com_result<=(K>=14)?in_candidate1[14*(2*LEN+FEATURE_WIDE)-1:13 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=14)?in_lab1[14*NUM-1:13 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd28:begin
              com_result<=(K>=15)?in_candidate0[15*(2*LEN+FEATURE_WIDE)-1:14 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=15)?in_lab0[15*NUM-1:14 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd29:begin
              com_result<=(K>=15)?in_candidate1[15*(2*LEN+FEATURE_WIDE)-1:14 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=15)?in_lab1[15*NUM-1:14 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd30:begin
              com_result<=(K>=16)?in_candidate0[16*(2*LEN+FEATURE_WIDE)-1:15 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=16)?in_lab0[16*NUM-1:15 *NUM]                  :{NUM{1'b0}}      ;
           end 
           5'd31:begin
              com_result<=(K>=16)?in_candidate1[16*(2*LEN+FEATURE_WIDE)-1:15 *(2*LEN+FEATURE_WIDE)]:{(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <=(K>=16)?in_lab1[16*NUM-1:15 *NUM]                  :{NUM{1'b0}}      ;
           end 
           default:begin
              com_result<={(2*LEN+FEATURE_WIDE){1'b1}};
              com_lab   <={NUM{1'b0}}      ;
           end 
        endcase
        end 
    else begin
        com_result<={(2*LEN+FEATURE_WIDE){1'b1}};
        com_lab   <={NUM{1'b0}}      ;
    
    end 
end





always @(*)begin     
    if(!rst_n) begin
        location = 5'd0;
    end
    else if (flag_r==1'b1 )begin
        if(com_result<candidate0    && K>=1 ) begin
            location = 5'd1;
        end
        else if(com_result<candidate1 && K>=2 ) begin
            location = 5'd2;
        end
        else if(com_result<candidate2 && K>=3 ) begin
            location = 5'd3;
        end
        else if(com_result<candidate3 && K>=4 )begin
            location = 5'd4;
        end
        else if(com_result<candidate4 && K>=5 ) begin
            location = 5'd5;
        end
        else if(com_result<candidate5 && K>=6 ) begin
            location = 5'd6;
        end
        else if(com_result<candidate6 && K>=7 ) begin
            location = 5'd7;
        end
        else if(com_result<candidate7 && K>=8 ) begin
            location = 5'd8;
        end
        else if(com_result<candidate8 && K>=9 ) begin
            location = 5'd9;
        end
        else if(com_result<candidate9 && K>=10) begin
            location = 5'd10;
        end
        else if(com_result<candidate10&& K>=11) begin
            location = 5'd11;
        end
        else if(com_result<candidate11&& K>=12) begin
            location = 5'd12;
        end
        else if(com_result<candidate12&& K>=13) begin
            location = 5'd13;
        end
        else if(com_result<candidate13&& K>=14) begin
            location = 5'd14;
        end
        else if(com_result<candidate14&& K>=15) begin
            location = 5'd15;
        end
        else if(com_result<candidate15&& K==16) begin
            location = 5'd16;
        end
        else begin
            location = 5'd0;
        end
    end
    else begin
            location = 5'd0;
    end
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        candidate0 <=(K>=1 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate1 <=(K>=2 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate2 <=(K>=3 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate3 <=(K>=4 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate4 <=(K>=5 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate5 <=(K>=6 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate6 <=(K>=7 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate7 <=(K>=8 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate8 <=(K>=9 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate9 <=(K>=10) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate10<=(K>=11) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate11<=(K>=12) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate12<=(K>=13) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate13<=(K>=14) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate14<=(K>=15) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate15<=(K>=16) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        lab0 <={NUM{1'b0}};
        lab1 <={NUM{1'b0}};
        lab2 <={NUM{1'b0}};
        lab3 <={NUM{1'b0}};
        lab4 <={NUM{1'b0}};
        lab5 <={NUM{1'b0}};
        lab6 <={NUM{1'b0}};
        lab7 <={NUM{1'b0}};
        lab8 <={NUM{1'b0}};
        lab9 <={NUM{1'b0}};
        lab10<={NUM{1'b0}};
        lab11<={NUM{1'b0}};
        lab12<={NUM{1'b0}};
        lab13<={NUM{1'b0}};
        lab14<={NUM{1'b0}};
        lab15<={NUM{1'b0}};
    end
    else if(flag==1'b1)begin
                case (location)
                5'd1:begin  
                     candidate0 <= (K>=1 ) ?com_result  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate1 <= (K>=2 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate2 <= (K>=3 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate3 <= (K>=4 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate4 <= (K>=5 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate5 <= (K>=6 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate6 <= (K>=7 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate7 <= (K>=8 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate8 <= (K>=9 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate9 <= (K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate10<= (K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate11<= (K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate12<= (K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate13<= (K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate14<= (K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate15<= (K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     lab0  <= (K>=1 ) ?lab0     :{NUM{1'b0}};
                     lab1  <= (K>=2 ) ?com_lab  :{NUM{1'b0}};
                     lab2  <= (K>=3 ) ?lab1     :{NUM{1'b0}};
                     lab3  <= (K>=4 ) ?lab2     :{NUM{1'b0}};
                     lab4  <= (K>=5 ) ?lab3     :{NUM{1'b0}};
                     lab5  <= (K>=6 ) ?lab4     :{NUM{1'b0}};
                     lab6  <= (K>=7 ) ?lab5     :{NUM{1'b0}};
                     lab7  <= (K>=8 ) ?lab6     :{NUM{1'b0}};
                     lab8  <= (K>=9 ) ?lab7     :{NUM{1'b0}};
                     lab9  <= (K>=10) ?lab8     :{NUM{1'b0}};
                     lab10 <= (K>=11) ?lab9     :{NUM{1'b0}};
                     lab11 <= (K>=12) ?lab10    :{NUM{1'b0}};
                     lab12 <= (K>=13) ?lab11    :{NUM{1'b0}};
                     lab13 <= (K>=14) ?lab12    :{NUM{1'b0}};
                     lab14 <= (K>=15) ?lab13    :{NUM{1'b0}};
                     lab15 <= (K>=16) ?lab14    :{NUM{1'b0}};  
                end
                5'd2:begin  
                     candidate0 <= (K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate1 <= (K>=2 ) ?com_result  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate2 <= (K>=3 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate3 <= (K>=4 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate4 <= (K>=5 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate5 <= (K>=6 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate6 <= (K>=7 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate7 <= (K>=8 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate8 <= (K>=9 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate9 <= (K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate10<= (K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate11<= (K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate12<= (K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate13<= (K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate14<= (K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     candidate15<= (K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                     lab0  <= (K>=1 ) ?lab0 :{NUM{1'b0}};
                     lab1  <= (K>=2 ) ?com_lab  :{NUM{1'b0}};
                     lab2  <= (K>=3 ) ?lab1 :{NUM{1'b0}};
                     lab3  <= (K>=4 ) ?lab2 :{NUM{1'b0}};
                     lab4  <= (K>=5 ) ?lab3 :{NUM{1'b0}};
                     lab5  <= (K>=6 ) ?lab4 :{NUM{1'b0}};
                     lab6  <= (K>=7 ) ?lab5 :{NUM{1'b0}};
                     lab7  <= (K>=8 ) ?lab6 :{NUM{1'b0}};
                     lab8  <= (K>=9 ) ?lab7 :{NUM{1'b0}};
                     lab9  <= (K>=10) ?lab8 :{NUM{1'b0}};
                     lab10 <= (K>=11) ?lab9 :{NUM{1'b0}};
                     lab11 <= (K>=12) ?lab10:{NUM{1'b0}};
                     lab12 <= (K>=13) ?lab11:{NUM{1'b0}};
                     lab13 <= (K>=14) ?lab12:{NUM{1'b0}};
                     lab14 <= (K>=15) ?lab13:{NUM{1'b0}};
                     lab15 <= (K>=16) ?lab14:{NUM{1'b0}};  
                end
                5'd3:begin
                    candidate0 <= (K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <= (K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <= (K>=3 ) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <= (K>=4 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <= (K>=5 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <= (K>=6 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <= (K>=7 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <= (K>=8 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <= (K>=9 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <= (K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<= (K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<= (K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<= (K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<= (K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<= (K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<= (K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <= (K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <= (K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <= (K>=3 ) ?com_lab  :{NUM{1'b0}};
                    lab3  <= (K>=4 ) ?lab2 :{NUM{1'b0}};
                    lab4  <= (K>=5 ) ?lab3 :{NUM{1'b0}};
                    lab5  <= (K>=6 ) ?lab4 :{NUM{1'b0}};
                    lab6  <= (K>=7 ) ?lab5 :{NUM{1'b0}};
                    lab7  <= (K>=8 ) ?lab6 :{NUM{1'b0}};
                    lab8  <= (K>=9 ) ?lab7 :{NUM{1'b0}};
                    lab9  <= (K>=10) ?lab8 :{NUM{1'b0}};
                    lab10 <= (K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <= (K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <= (K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <= (K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <= (K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <= (K>=16) ?lab14:{NUM{1'b0}};  
                
                end
                5'd4:begin
                    candidate0 <= (K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <= (K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <= (K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <= (K>=4 ) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <= (K>=5 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <= (K>=6 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <= (K>=7 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <= (K>=8 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <= (K>=9 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <= (K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<= (K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<= (K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<= (K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<= (K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<= (K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<= (K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <= (K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <= (K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <= (K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <= (K>=4 ) ?com_lab  :{NUM{1'b0}};
                    lab4  <= (K>=5 ) ?lab3 :{NUM{1'b0}};
                    lab5  <= (K>=6 ) ?lab4 :{NUM{1'b0}};
                    lab6  <= (K>=7 ) ?lab5 :{NUM{1'b0}};
                    lab7  <= (K>=8 ) ?lab6 :{NUM{1'b0}};
                    lab8  <= (K>=9 ) ?lab7 :{NUM{1'b0}};
                    lab9  <= (K>=10) ?lab8 :{NUM{1'b0}};
                    lab10 <= (K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <= (K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <= (K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <= (K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <= (K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <= (K>=16) ?lab14:{NUM{1'b0}};  
                end
                5'd5:begin       
                    candidate0 <= (K>=1 ) ?candidate0   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <= (K>=2 ) ?candidate1   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <= (K>=3 ) ?candidate2   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <= (K>=4 ) ?candidate3   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <= (K>=5 ) ?com_result :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <= (K>=6 ) ?candidate4   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <= (K>=7 ) ?candidate5   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <= (K>=8 ) ?candidate6   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <= (K>=9 ) ?candidate7   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <= (K>=10) ?candidate8   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<= (K>=11) ?candidate9   :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<= (K>=12) ?candidate10  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<= (K>=13) ?candidate11  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<= (K>=14) ?candidate12  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<= (K>=15) ?candidate13  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<= (K>=16) ?candidate14  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <= (K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <= (K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <= (K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <= (K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <= (K>=5 ) ?com_lab  :{NUM{1'b0}};
                    lab5  <= (K>=6 ) ?lab4 :{NUM{1'b0}};
                    lab6  <= (K>=7 ) ?lab5 :{NUM{1'b0}};
                    lab7  <= (K>=8 ) ?lab6 :{NUM{1'b0}};
                    lab8  <= (K>=9 ) ?lab7 :{NUM{1'b0}};
                    lab9  <= (K>=10) ?lab8 :{NUM{1'b0}};
                    lab10 <= (K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <= (K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <= (K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <= (K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <= (K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <= (K>=16) ?lab14:{NUM{1'b0}};  
                
                end
                5'd6:begin       
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?com_lab  :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab5 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab6 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab7 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab8 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                
                end
                5'd7:begin       
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?com_lab  :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab6 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab7 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab8 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                
                end
                5'd8:begin  
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?com_lab  :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab7 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab8 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                end
                5'd9:begin  
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?com_lab  :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab8 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                end
                5'd10:begin
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?com_lab  :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab9 :{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                end
                5'd11:begin
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab9 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?com_lab  :{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab10:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                end
                5'd12:begin       
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab9 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab10:{NUM{1'b0}};
                    lab11 <=(K>=12) ?com_lab  :{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab11:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}}; 
                
                end
                5'd13:begin       
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab9 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab10:{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab11:{NUM{1'b0}};
                    lab12 <=(K>=13) ?com_lab  :{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab12:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                
                end
                5'd14:begin       
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}}; 
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab9 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab10:{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab11:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab12:{NUM{1'b0}};
                    lab13 <=(K>=14) ?com_lab  :{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab13:{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                
                end
                5'd15:begin       
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab9 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab10:{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab11:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab12:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab13:{NUM{1'b0}};
                    lab14 <=(K>=15) ?com_lab  :{NUM{1'b0}};
                    lab15 <=(K>=16) ?lab14:{NUM{1'b0}};  
                
            end
                5'd16:begin       
                    candidate0 <=(K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate9  :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate10 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate11 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate12 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate13 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate14 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?com_result:{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <=(K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <=(K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <=(K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <=(K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <=(K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <=(K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <=(K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <=(K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <=(K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <=(K>=10) ?lab9 :{NUM{1'b0}};
                    lab10 <=(K>=11) ?lab10:{NUM{1'b0}};
                    lab11 <=(K>=12) ?lab11:{NUM{1'b0}};
                    lab12 <=(K>=13) ?lab12:{NUM{1'b0}};
                    lab13 <=(K>=14) ?lab13:{NUM{1'b0}};
                    lab14 <=(K>=15) ?lab14:{NUM{1'b0}};
                    lab15 <=(K>=16) ?com_lab  :{NUM{1'b0}};  
                end
                default:begin    
                    candidate0 <=(K>=1 ) ?candidate0 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate1 <=(K>=2 ) ?candidate1 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate2 <=(K>=3 ) ?candidate2 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate3 <=(K>=4 ) ?candidate3 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate4 <=(K>=5 ) ?candidate4 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate5 <=(K>=6 ) ?candidate5 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate6 <=(K>=7 ) ?candidate6 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate7 <=(K>=8 ) ?candidate7 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate8 <=(K>=9 ) ?candidate8 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate9 <=(K>=10) ?candidate9 :{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate10<=(K>=11) ?candidate10:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate11<=(K>=12) ?candidate11:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate12<=(K>=13) ?candidate12:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate13<=(K>=14) ?candidate13:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate14<=(K>=15) ?candidate14:{(2*LEN+FEATURE_WIDE){1'b0}};
                    candidate15<=(K>=16) ?candidate15:{(2*LEN+FEATURE_WIDE){1'b0}};
                    lab0  <= (K>=1 ) ?lab0 :{NUM{1'b0}};
                    lab1  <= (K>=2 ) ?lab1 :{NUM{1'b0}};
                    lab2  <= (K>=3 ) ?lab2 :{NUM{1'b0}};
                    lab3  <= (K>=4 ) ?lab3 :{NUM{1'b0}};
                    lab4  <= (K>=5 ) ?lab4 :{NUM{1'b0}};
                    lab5  <= (K>=6 ) ?lab5 :{NUM{1'b0}};
                    lab6  <= (K>=7 ) ?lab6 :{NUM{1'b0}};
                    lab7  <= (K>=8 ) ?lab7 :{NUM{1'b0}};
                    lab8  <= (K>=9 ) ?lab8 :{NUM{1'b0}};
                    lab9  <= (K>=10) ?lab9 :{NUM{1'b0}};
                    lab10 <= (K>=11) ?lab10:{NUM{1'b0}};
                    lab11 <= (K>=12) ?lab11:{NUM{1'b0}};
                    lab12 <= (K>=13) ?lab12:{NUM{1'b0}};
                    lab13 <= (K>=14) ?lab13:{NUM{1'b0}};
                    lab14 <= (K>=15) ?lab14:{NUM{1'b0}};
                    lab15 <= (K>=16) ?lab15:{NUM{1'b0}};  
                end
                endcase
    end
    else begin
        candidate0 <=(K>=1 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate1 <=(K>=2 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate2 <=(K>=3 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate3 <=(K>=4 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate4 <=(K>=5 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate5 <=(K>=6 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate6 <=(K>=7 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate7 <=(K>=8 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate8 <=(K>=9 ) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate9 <=(K>=10) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate10<=(K>=11) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate11<=(K>=12) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate12<=(K>=13) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate13<=(K>=14) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate14<=(K>=15) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        candidate15<=(K>=16) ?{(2*LEN+FEATURE_WIDE){1'b1}}:{(2*LEN+FEATURE_WIDE){1'b0}};
        lab0 <={NUM{1'b0}};
        lab1 <={NUM{1'b0}};
        lab2 <={NUM{1'b0}};
        lab3 <={NUM{1'b0}};
        lab4 <={NUM{1'b0}};
        lab5 <={NUM{1'b0}};
        lab6 <={NUM{1'b0}};
        lab7 <={NUM{1'b0}};
        lab8 <={NUM{1'b0}};
        lab9 <={NUM{1'b0}};
        lab10<={NUM{1'b0}};
        lab11<={NUM{1'b0}};
        lab12<={NUM{1'b0}};
        lab13<={NUM{1'b0}};
        lab14<={NUM{1'b0}};
        lab15<={NUM{1'b0}};
    end
end


assign en_r =(cnt_rank==2*K-1'b1)?1'b1:1'b0;



endmodule


