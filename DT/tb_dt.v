
`timescale 1 ps / 1 ps
module tb_dt();


reg                             clk       ;
reg                             rst_n     ;
reg                             en        ;
reg    [12:0]                   feature   ;
 
wire     [4:0]                  out_class ;
wire                            en_end    ;


initial begin
    clk     =0;  
    rst_n   =0;  
    en      =0;  
    feature =0; 
    #100
       
    rst_n   =1;  
    en      =1;  
    feature =13'd3590; 
    #20
    feature =13'd3270; 
    #20
    feature =13'd37; 
    #20
    feature =13'd370; 
    #20
    feature =13'd207; 
    #20
    feature =13'd70; 
    #20
    feature =13'd60; 
    #20
    feature =13'd700; 
    #20
    feature =13'd700;    
    #20
    feature =13'd27; 
    #20
    feature =13'd67; 
    #20
    feature =13'd67; 
    #20
    feature =13'd67; 
    #20
    feature =13'd67; 
    #20
    feature =13'd67;    
    #20
    feature =13'd7; 

#1000
$stop;

end 

always#10 clk =!clk ;




DT
#(  
    .LAYER_NUM    (6                                                      ),  //Number of hidden layers,up to 4  
    .FEATURE_WIDE (13                                                     ),  //input feature Intege bit width
    .FEATURE_NUM  (16                                                     ),  //Number of input feature,up to 16
    .LAYER_CON0   (4'd0                                                   ),
    .LAYER_CON1   ({4'd1,4'd0}                                            ),
    .LAYER_CON2   ({4'd3,4'd2,4'd1,4'd0}                                  ),
    .LAYER_CON3   ({4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0}              ),
    .LAYER_CON4   ({4'd15,4'd14,4'd13,4'd12,4'd11,4'd10,4'd9,4'd8,        
                             4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0     }),
    .LAYER_CON5   ({4'd15,4'd14,4'd13,4'd12,4'd11,4'd10,4'd9,4'd8,
                             4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0,4'd15,
                             4'd14,4'd13,4'd12,4'd11,4'd10,4'd9,4'd8,4'd7 ,
                             4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0}),
    .CLASS_WIDTH  (7                                                      )
)
DT
(
    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .en        (en        ),
    .feature   (feature   ),
    
    .out_class (out_class ),
    .en_end    (en_end    )  
);






endmodule 