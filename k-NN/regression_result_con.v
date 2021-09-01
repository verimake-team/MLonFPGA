module regression_result_con
#(
  parameter NUM           =3,
  parameter CLASS_NUM     =6,
  parameter FEATURE_WIDE  =4,
  parameter K             =7, 
  parameter LEN           =12     
)(
    input                       clk              ,     
    input                       rst_n            ,
    input                       flag             ,
    input  [K*(2*LEN+2)-1:0]    ocandidate       ,
    input  [K*(2*LEN+2)-1:0]    ecandidate       ,
    input  [K*NUM-1:0]          lab_e            ,
    input  [K*NUM-1:0]          lab_o            ,

        
    output [K*NUM-1:0]          result          
 

);

reg   [NUM-1'b1:0]          lab           ;
                        
reg   [4:0]                 cnt           ;
                        
reg   [NUM+2'd3:0]          sigma         ;

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

wire                     en            ;


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



always@(*)begin
    case(cnt)
        5'd0 : lab<=lab0 ;
        5'd1 : lab<=lab1 ;
        5'd2 : lab<=lab2 ;
        5'd3 : lab<=lab3 ;
        5'd4 : lab<=lab4 ;
        5'd5 : lab<=lab5 ;
        5'd6 : lab<=lab6 ;
        5'd7 : lab<=lab7 ;
        5'd8 : lab<=lab8 ;
        5'd9 : lab<=lab9 ;
        5'd10: lab<=lab10;
        5'd11: lab<=lab11;
        5'd12: lab<=lab12;
        5'd13: lab<=lab13;
        5'd14: lab<=lab14;
        5'd15: lab<=lab15;  
        default:lab<={NUM{1'b0}}; 
        endcase
end                    

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        sigma<={(NUM+3'd4){1'b0}};
    end
    else if(cnt<K && en==1'b1)begin
        sigma<=sigma+lab;
    end
end 


assign result =(cnt==K)?sigma/K:{K*NUM{1'b0}};



rank_candidate
#(
  .NUM         (NUM            ),
  .K           (K              ), 
  .FEATURE_WIDE(FEATURE_WIDE   ),
  .LEN         (LEN            )    
)
e_rank_candidate(
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