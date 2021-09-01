module sort
#(
  parameter NUM          =3   ,
  parameter COM_NUM      =600 ,
  parameter FEATURE_WIDE =4   ,   //feature bit width
  parameter K            =7   , 
  parameter LEN          =12     
)
(
    input                                         clk             ,
    input                                         rst_n           ,
    input       [2*LEN+FEATURE_WIDE-1'b1:0]       sigma_result    ,
    input       [NUM-1'b1:0]                      lab             ,
                                  
    output  reg                                   flag            ,
    output      [K*NUM-1'b1:0]                    out_lab         ,
    output      [K*(2*LEN+FEATURE_WIDE)-1'b1:0]   candidate       
);



reg [4:0]                       location     ;
                                             
reg                             rst_n_r      ;
                                             
reg                             rst_n_rr     ;
                                             
reg [10:0]                      cnt          ;
                                             
reg                             cnt0_1       ;
                                
reg [NUM-1'b1:0]                lab0         ;
                                
reg [NUM-1'b1:0]                lab1         ;
                                
reg [NUM-1'b1:0]                lab2         ;
                                
reg [NUM-1'b1:0]                lab3         ;
                                
reg [NUM-1'b1:0]                lab4         ;
                                
reg [NUM-1'b1:0]                lab5         ;
                                
reg [NUM-1'b1:0]                lab6         ;
                                
reg [NUM-1'b1:0]                lab7         ;
                                
reg [NUM-1'b1:0]                lab8         ;
                                
reg [NUM-1'b1:0]                lab9         ;
                                
reg [NUM-1'b1:0]                lab10        ;
                                
reg [NUM-1'b1:0]                lab11        ;
                                
reg [NUM-1'b1:0]                lab12        ;
                                
reg [NUM-1'b1:0]                lab13        ;
                                
reg [NUM-1'b1:0]                lab14        ;
                                
reg [NUM-1'b1:0]                lab15        ;

reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate0   ;
                          
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate1   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate2   ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate3   ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate4   ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate5   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate6   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate7   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate8   ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate9   ;
                          
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate10  ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate11  ;
                           
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate12  ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate13  ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate14  ;
                            
reg [2*LEN+FEATURE_WIDE-1'b1:0]   candidate15  ;

            
            
            
            
            
            
always@(posedge clk )begin

    rst_n_r<=rst_n;
    
    rst_n_rr<=rst_n_r;

end


always@(posedge  clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt0_1<=1'b0;
    end
    else begin
        cnt0_1<=cnt0_1+1'b1;
    end
end 


always@(posedge clk  )begin
    if(!rst_n_rr) begin
        cnt <= 11'd0;
        flag<=1'b0;
        end 
    else if (cnt==COM_NUM)begin
        cnt <= COM_NUM;
        flag<=1'b1;
    end 
    else begin
        cnt <=cnt+1'b1;
        flag<=1'b0;
    end 
end
            

always @(*)begin     
    if(!rst_n_rr) begin
        location = 5'd0;
    end
    else if (flag==1'b0 && cnt0_1==1'b1)begin
        if(sigma_result<candidate0      && K>=1 ) begin
            location = 5'd1;
        end
        else if(sigma_result<candidate1 && K>=2 ) begin
            location = 5'd2;
        end
        else if(sigma_result<candidate2 && K>=3 ) begin
            location = 5'd3;
        end
        else if(sigma_result<candidate3 && K>=4 ) begin
            location = 5'd4;
        end
        else if(sigma_result<candidate4 && K>=5 ) begin
            location = 5'd5;
        end
        else if(sigma_result<candidate5 && K>=6 ) begin
            location = 5'd6;
        end
        else if(sigma_result<candidate6 && K>=7 ) begin
            location = 5'd7;
        end
        else if(sigma_result<candidate7 && K>=8 ) begin
            location = 5'd8;
        end
        else if(sigma_result<candidate8 && K>=9 ) begin
            location = 5'd9;
        end
        else if(sigma_result<candidate9 && K>=10) begin
            location = 5'd10;
        end
        else if(sigma_result<candidate10&& K>=11) begin
            location = 5'd11;
        end
        else if(sigma_result<candidate11&& K>=12) begin
            location = 5'd12;
        end
        else if(sigma_result<candidate12&& K>=13) begin
            location = 5'd13;
        end
        else if(sigma_result<candidate13&& K>=14) begin
            location = 5'd14;
        end
        else if(sigma_result<candidate14&& K>=15) begin
            location = 5'd15;
        end
        else if(sigma_result<candidate15&& K==16) begin
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
    else 
        case (location)
            5'd1:begin  
                candidate0 <= (K>=1 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab0  <=(K>=1 ) ?lab  :{NUM{1'b0}};
                lab1  <=(K>=2 ) ?lab0 :{NUM{1'b0}};
                lab2  <=(K>=3 ) ?lab1 :{NUM{1'b0}};
                lab3  <=(K>=4 ) ?lab2 :{NUM{1'b0}};
                lab4  <=(K>=5 ) ?lab3 :{NUM{1'b0}};
                lab5  <=(K>=6 ) ?lab4 :{NUM{1'b0}};
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
            5'd2:begin  
                candidate0 <= (K>=1 ) ?candidate0  :{(2*LEN+FEATURE_WIDE){1'b0}};
                candidate1 <= (K>=2 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab1  <= (K>=2 ) ?lab  :{NUM{1'b0}};
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
                candidate2 <= (K>=3 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab2  <= (K>=3 ) ?lab  :{NUM{1'b0}};
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
                candidate3 <= (K>=4 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab3  <= (K>=4 ) ?lab  :{NUM{1'b0}};
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
                candidate4 <= (K>=5 ) ?sigma_result :{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab4  <= (K>=5 ) ?lab  :{NUM{1'b0}};
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
                candidate5 <=(K>=6 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab5  <=(K>=6 ) ?lab  :{NUM{1'b0}};
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
                candidate6 <=(K>=7 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab6  <=(K>=7 ) ?lab  :{NUM{1'b0}};
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
                candidate7 <=(K>=8 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab7  <=(K>=8 ) ?lab  :{NUM{1'b0}};
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
                candidate8 <=(K>=9 ) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab8  <=(K>=9 ) ?lab  :{NUM{1'b0}};
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
                candidate9 <=(K>=10) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab9  <=(K>=10) ?lab  :{NUM{1'b0}};
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
                candidate10<=(K>=11) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab10 <=(K>=11) ?lab  :{NUM{1'b0}};
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
                candidate11<=(K>=12) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab11 <=(K>=12) ?lab  :{NUM{1'b0}};
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
                candidate12<=(K>=13) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab12 <=(K>=13) ?lab  :{NUM{1'b0}};
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
                candidate13<=(K>=14) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab13 <=(K>=14) ?lab  :{NUM{1'b0}};
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
                candidate14<=(K>=15) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab14 <=(K>=15) ?lab  :{NUM{1'b0}};
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
                candidate15<=(K>=16) ?sigma_result:{(2*LEN+FEATURE_WIDE){1'b0}};
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
                lab15 <=(K>=16) ?lab  :{NUM{1'b0}};  
                
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




assign candidate=(flag==1'b1)?{candidate15,candidate14,candidate13,candidate12,candidate11,candidate10,candidate9 ,candidate8,
                  candidate7 ,candidate6 ,candidate5 ,candidate4 ,candidate3 ,candidate2 ,candidate1 ,candidate0}:{(2*LEN+FEATURE_WIDE){1'b1}};

assign out_lab=(flag==1'b1)?{lab15,lab14,lab13,lab12,lab11,lab10,lab9 ,lab8,
                lab7 ,lab6 ,lab5 ,lab4 ,lab3 ,lab2 ,lab1 ,lab0}:{NUM{1'b0}};


endmodule