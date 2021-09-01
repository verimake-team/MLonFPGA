
module KNN
#(parameter FUNCTION     =0   ,   //classification 0，regression 1
  parameter FEATURE_NUM  =4   ,   //number of feature, up to 16 
  parameter FEATURE_WIDE =4   ,   //feature bit width
  parameter LEN          =12  ,   //feature bit width
  parameter DATA_WIDE    =3   ,   //sample bit width
  parameter COM_NUM      =600 ,   //number of sample, up to 2048
  parameter K            =6   ,   //up to 16 candidate 
  parameter CLASS_NUM    =6   ,   //number of category, up to 16 
  parameter WIDE         =48
)
(
    input                            clk         ,
    input                            rst_n       ,
    input   [WIDE-1'b1:0]            feature     ,
    input   [WIDE+DATA_WIDE-1'b1:0]  train_data  ,
                                  
    output  [DATA_WIDE-1'b1:0]       result

);




reg    [DATA_WIDE-1'b1:0]                    lab          ;
                                          
reg    [DATA_WIDE-1'b1:0]                    lab0         ;

wire   [2*LEN+FEATURE_WIDE-1'b1:0]           sigma_result ;

wire   [DATA_WIDE-1'b1:0]                    result0      ;
                                            
wire   [DATA_WIDE-1'b1:0]                    result1      ;
                                             
reg    [2*LEN+FEATURE_WIDE-1'b1:0]           sigma_result0;
                                             
reg    [2*LEN+FEATURE_WIDE-1'b1:0]           sigma_result1;
                                             
reg                                          cnt          ;
                                             
reg                                          en_e         ;
                                             
reg                                          en_o         ;
                                             
reg    [DATA_WIDE-1'b1:0]                    lab_e        ;
                                             
reg    [DATA_WIDE-1'b1:0]                    lab_o        ;
                                             
wire   [K*(2*LEN+FEATURE_WIDE)-1'b1:0]       ocandidate   ;
                                             
wire   [K*(2*LEN+FEATURE_WIDE)-1'b1:0]       ecandidate   ;
                                             
wire   [K*DATA_WIDE-1'b1:0]                  lab_e0       ;
                                             
wire   [K*DATA_WIDE-1'b1:0]                  lab_o0       ; 
                                             
wire                                         flag         ;



always@(posedge clk )begin

   lab0<=train_data[WIDE+DATA_WIDE-1'b1:WIDE];
   
   lab <=lab0;
   
end


always@(posedge  clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt<=1'b0;
    end
    else begin
        cnt<=cnt+1'b1;
    end
end 


always@(posedge  clk or negedge rst_n)begin 
    if(!rst_n)begin
        sigma_result0<={(2*LEN+FEATURE_WIDE){1'b0}};
        sigma_result1<={(2*LEN+FEATURE_WIDE){1'b0}};
        en_e<=1'b0;
        en_o<=1'b0;
        lab_e<={DATA_WIDE{1'b0}};
        lab_o<={DATA_WIDE{1'b0}};
    end
    else begin
    case(cnt)
    1'b0:begin
            sigma_result0<=sigma_result;
            en_e<=1'b1;
            lab_e<=lab;
         end
    1'b1:begin
            sigma_result1<=sigma_result;
            en_o<=1'b1;
            lab_o<=lab;
        end
    default:begin
        sigma_result0<={(2*LEN+FEATURE_WIDE){1'b0}};
        sigma_result1<={(2*LEN+FEATURE_WIDE){1'b0}};
        en_e<=en_e;
        en_o<=en_o;
        lab_e<=lab_e;
        lab_o<=lab_o;
    end
    endcase
    end
end 



ds  
#(  .LEN         (LEN                   ),
    .FEATURE_NUM (FEATURE_NUM           ),
    .FEATURE_WIDE(FEATURE_WIDE          ),
    .WIDE        (WIDE                  )    
    )
u_ds0 (                                   
    .clk                     ( clk         ),
    .rst_n                   ( rst_n       ),
    .feature                 ( feature     ),
    .train_data              ( train_data  ),

    .sigma_result            ( sigma_result)
);


sort
#(  .LEN         (LEN           ),
    .NUM         (DATA_WIDE     ),
    .FEATURE_WIDE(FEATURE_WIDE  ),
    .K           (K             ),    
    .COM_NUM     (COM_NUM       )
)         
e_u_sort (
    .clk                     ( clk             ),
    .rst_n                   ( en_e            ),
    .sigma_result            ( sigma_result0   ),
    .lab                     ( lab_e           ),


    .candidate               ( ecandidate      ),
    .out_lab                 ( lab_e0          )
);

sort
#(  .LEN         (LEN           ),
    .NUM         (DATA_WIDE     ),
    .FEATURE_WIDE(FEATURE_WIDE  ),
    .K           (K             ),    
    .COM_NUM     (COM_NUM       )
)         
o_u_sort (
    .clk                     ( clk             ),
    .rst_n                   ( en_o            ),
    .sigma_result            ( sigma_result1   ),
    .lab                     ( lab_o           ),
    
    .flag                    (flag             ),
    .candidate               ( ocandidate      ),
    .out_lab                 ( lab_o0          )
);



class_result_con  
#(  .LEN        (LEN        ),
    .K          (K          ),
    .FEATURE_WIDE(FEATURE_WIDE  ),
    .NUM        (DATA_WIDE  ),
    .CLASS_NUM  (CLASS_NUM  )
) 
u_result (
    .clk                     ( clk               ),
    .rst_n                   ( rst_n             ),
    .ocandidate              ( ocandidate        ),
    .ecandidate              ( ecandidate        ),
    .flag                    ( flag && !FUNCTION ),
    .lab_o                   ( lab_o0            ),
    .lab_e                   ( lab_e0            ),
                                                 
    .lab                     (result0            )
);


regression_result_con  
#(  .LEN            (LEN           ),
    .K              (K             ),
    .FEATURE_WIDE   (FEATURE_WIDE  ),
    .NUM            (DATA_WIDE     ),
    .CLASS_NUM      (CLASS_NUM     )
) 
e_result (
    .clk                     ( clk               ),
    .rst_n                   ( rst_n             ),
    .ocandidate              ( ocandidate        ),
    .ecandidate              ( ecandidate        ),
    .flag                    ( flag &&  FUNCTION ),
    .lab_o                   ( lab_o0            ),
    .lab_e                   ( lab_e0            ),
                                                 
    .result                  (result1            )
);


assign result=(FUNCTION)?result1:result0;

endmodule