

module top_knn
#(parameter FUNCTION     =1   ,   //classification 0，regression 1
  parameter FEATURE_NUM  =7   ,   //number of feature, up to 16 
  parameter FEATURE_WIDE =3   ,   //feature bit width (0,1)1,(2,3)2,(4,5,6,7)3…�  
  parameter LEN          =13  ,   //feature bit width
  parameter DATA_WIDE    =1   ,   //sample lab bit width (0,1)1,(2,3)2,(4,5,6,7)3…�  
  parameter COM_NUM      =600 ,   //number of sample, up to 1024
  parameter K            =2   ,   //up to 16 candidate 
  parameter CLASS_NUM    =16      //number of category, up to 16 
)(

    input                                       clk         ,
    input                                       rst_n       ,
    input   [LEN-1'b1:0]                        feature     , //input serial

    output  [DATA_WIDE-1'b1:0]                  result

);

wire [LEN*FEATURE_NUM+DATA_WIDE-1'b1:0]train_data   ;

reg  [LEN*FEATURE_NUM -1'b1:0]        feature_sum   ;

wire [LEN*FEATURE_NUM -1'b1:0]        feature_sum0  ;

reg  [9:0]                            address       ;

wire                                  en            ;

reg  [4:0]                            cnt           ;

wire                                  flag          ;

wire                                  o_clk         ;



 always@(posedge o_clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt<=5'd0;
    end
    else if(cnt==FEATURE_NUM)
        cnt<=FEATURE_NUM;
    else 
        cnt<=cnt+1'b1;
end 



always@(posedge o_clk or negedge rst_n )begin
    if(!rst_n)begin
        feature_sum<={(LEN*FEATURE_NUM){1'b0}};
    end
    else if(cnt<=FEATURE_NUM-1'b1)begin
        feature_sum<={feature,feature_sum[LEN*FEATURE_NUM -1:LEN]};
    end
    else begin
        feature_sum<=feature_sum;
    end
end




always@(posedge o_clk or negedge rst_n)begin
    if(!rst_n)begin
        address<=10'd0;
    end 
    else if (address==COM_NUM-1'b1)
        address<=COM_NUM-1'b1;
    else if(flag==1'b1)
        address<=address+1'b1;
end 



assign  en=(cnt==FEATURE_NUM)?1'b1:1'b0;

assign  feature_sum0=(cnt==FEATURE_NUM)?feature_sum:{(LEN*FEATURE_NUM){1'b0}};

assign  flag=(cnt>=FEATURE_NUM-2'd2)?1'b1:1'b0;




KNN
#(.FUNCTION    (FUNCTION               ),//classification 0，regression 11
  .FEATURE_NUM (FEATURE_NUM            ),//number of feature, up to 16 
  .FEATURE_WIDE(FEATURE_WIDE           ),
  .LEN         (LEN                    ),//feature bit width
  .DATA_WIDE   (DATA_WIDE              ),//sample lab bit width
  .COM_NUM     (COM_NUM                ),//number of sample, up to 2048
  .K           (K                      ),//up to 16 candidate 
  .CLASS_NUM   (CLASS_NUM              ),//number of category, up to 16 
  .WIDE        (LEN*FEATURE_NUM        ) 
)
U_KNN
(
    .clk        (o_clk        ),
    .rst_n      (en           ),
    .feature    (feature_sum0 ),
    .train_data (train_data   ),

    .result     (result       )

);

assign train_data = address;
assign o_clk = clk;
/*
lib u_lib(
    .addr  (address         ),
    .clk    (o_clk           ),
    .rst     (flag && rst_n   ),
    .rd_data  (train_data      )
    );
  
pll pll(
    .clkin1(REFERENCECLK    )  ,
    .clkout0    (PLLOUTCORE  ) 
);
*/ 

endmodule 