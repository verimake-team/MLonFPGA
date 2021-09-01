module ds
#(
  parameter FEATURE_NUM  =4         ,
  parameter LEN          =12        ,
  parameter FEATURE_WIDE =4         ,   //feature bit width
  parameter WIDE         =48
)
(
    input                                     clk         , 
    input                                     rst_n       ,
    input       [ WIDE-1'b1:0]                feature     ,
    input       [ WIDE-1'b1:0]                train_data  ,

    output  reg [2*LEN+FEATURE_WIDE-1'b1:0]   sigma_result
);


reg [2*LEN-1'b1:0]   ds_result0 ;
reg [2*LEN-1'b1:0]   ds_result1 ;
reg [2*LEN-1'b1:0]   ds_result2 ;
reg [2*LEN-1'b1:0]   ds_result3 ;
reg [2*LEN-1'b1:0]   ds_result4 ;
reg [2*LEN-1'b1:0]   ds_result5 ;
reg [2*LEN-1'b1:0]   ds_result6 ;
reg [2*LEN-1'b1:0]   ds_result7 ;
reg [2*LEN-1'b1:0]   ds_result8 ;
reg [2*LEN-1'b1:0]   ds_result9 ;
reg [2*LEN-1'b1:0]   ds_result10;
reg [2*LEN-1'b1:0]   ds_result11;
reg [2*LEN-1'b1:0]   ds_result12;
reg [2*LEN-1'b1:0]   ds_result13;
reg [2*LEN-1'b1:0]   ds_result14;
reg [2*LEN-1'b1:0]   ds_result15;





always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin   
        ds_result0  <= {(2*LEN){1'b0}};
        ds_result1  <= {(2*LEN){1'b0}};
        ds_result2  <= {(2*LEN){1'b0}};
        ds_result3  <= {(2*LEN){1'b0}};
        ds_result4  <= {(2*LEN){1'b0}};
        ds_result5  <= {(2*LEN){1'b0}};
        ds_result6  <= {(2*LEN){1'b0}};
        ds_result7  <= {(2*LEN){1'b0}};
        ds_result8  <= {(2*LEN){1'b0}};
        ds_result9  <= {(2*LEN){1'b0}};
        ds_result10 <= {(2*LEN){1'b0}};
        ds_result11 <= {(2*LEN){1'b0}};
        ds_result12 <= {(2*LEN){1'b0}};
        ds_result13 <= {(2*LEN){1'b0}};
        ds_result14 <= {(2*LEN){1'b0}};
        ds_result15 <= {(2*LEN){1'b0}};
    end
    else begin
        ds_result0  <=(FEATURE_NUM>=1 ) ? (train_data[     LEN-1'b1:     0] - feature[     LEN-1'b1:     0]) * (train_data[     LEN-1'b1:     0] - feature[     LEN-1'b1:     0]):{(2*LEN){1'b0}};
        ds_result1  <=(FEATURE_NUM>=2 ) ? (train_data[2  * LEN-1'b1:   LEN] - feature[2  * LEN-1'b1:   LEN]) * (train_data[2  * LEN-1'b1:   LEN] - feature[2  * LEN-1'b1:   LEN]):{(2*LEN){1'b0}};
        ds_result2  <=(FEATURE_NUM>=3 ) ? (train_data[3  * LEN-1'b1:2 *LEN] - feature[3  * LEN-1'b1:2 *LEN]) * (train_data[3  * LEN-1'b1:2 *LEN] - feature[3  * LEN-1'b1:2 *LEN]):{(2*LEN){1'b0}};
        ds_result3  <=(FEATURE_NUM>=4 ) ? (train_data[4  * LEN-1'b1:3 *LEN] - feature[4  * LEN-1'b1:3 *LEN]) * (train_data[4  * LEN-1'b1:3 *LEN] - feature[4  * LEN-1'b1:3 *LEN]):{(2*LEN){1'b0}};
        ds_result4  <=(FEATURE_NUM>=5 ) ? (train_data[5  * LEN-1'b1:4 *LEN] - feature[5  * LEN-1'b1:4 *LEN]) * (train_data[5  * LEN-1'b1:4 *LEN] - feature[5  * LEN-1'b1:4 *LEN]):{(2*LEN){1'b0}};
        ds_result5  <=(FEATURE_NUM>=6 ) ? (train_data[6  * LEN-1'b1:5 *LEN] - feature[6  * LEN-1'b1:5 *LEN]) * (train_data[6  * LEN-1'b1:5 *LEN] - feature[6  * LEN-1'b1:5 *LEN]):{(2*LEN){1'b0}};
        ds_result6  <=(FEATURE_NUM>=7 ) ? (train_data[7  * LEN-1'b1:6 *LEN] - feature[7  * LEN-1'b1:6 *LEN]) * (train_data[7  * LEN-1'b1:6 *LEN] - feature[7  * LEN-1'b1:6 *LEN]):{(2*LEN){1'b0}};
        ds_result7  <=(FEATURE_NUM>=8 ) ? (train_data[8  * LEN-1'b1:7 *LEN] - feature[8  * LEN-1'b1:7 *LEN]) * (train_data[8  * LEN-1'b1:7 *LEN] - feature[8  * LEN-1'b1:7 *LEN]):{(2*LEN){1'b0}};
        ds_result8  <=(FEATURE_NUM>=9 ) ? (train_data[9  * LEN-1'b1:8 *LEN] - feature[9  * LEN-1'b1:8 *LEN]) * (train_data[9  * LEN-1'b1:8 *LEN] - feature[9  * LEN-1'b1:8 *LEN]):{(2*LEN){1'b0}};
        ds_result9  <=(FEATURE_NUM>=10) ? (train_data[10 * LEN-1'b1:9 *LEN] - feature[10 * LEN-1'b1:9 *LEN]) * (train_data[10 * LEN-1'b1:9 *LEN] - feature[10 * LEN-1'b1:9 *LEN]):{(2*LEN){1'b0}};
        ds_result10 <=(FEATURE_NUM>=11) ? (train_data[11 * LEN-1'b1:10*LEN] - feature[11 * LEN-1'b1:10*LEN]) * (train_data[11 * LEN-1'b1:10*LEN] - feature[11 * LEN-1'b1:10*LEN]):{(2*LEN){1'b0}};
        ds_result11 <=(FEATURE_NUM>=12) ? (train_data[12 * LEN-1'b1:11*LEN] - feature[12 * LEN-1'b1:11*LEN]) * (train_data[12 * LEN-1'b1:11*LEN] - feature[12 * LEN-1'b1:11*LEN]):{(2*LEN){1'b0}};
        ds_result12 <=(FEATURE_NUM>=13) ? (train_data[13 * LEN-1'b1:12*LEN] - feature[13 * LEN-1'b1:12*LEN]) * (train_data[13 * LEN-1'b1:12*LEN] - feature[13 * LEN-1'b1:12*LEN]):{(2*LEN){1'b0}};
        ds_result13 <=(FEATURE_NUM>=14) ? (train_data[14 * LEN-1'b1:13*LEN] - feature[14 * LEN-1'b1:13*LEN]) * (train_data[14 * LEN-1'b1:13*LEN] - feature[14 * LEN-1'b1:13*LEN]):{(2*LEN){1'b0}};
        ds_result14 <=(FEATURE_NUM>=15) ? (train_data[15 * LEN-1'b1:14*LEN] - feature[15 * LEN-1'b1:14*LEN]) * (train_data[15 * LEN-1'b1:14*LEN] - feature[15 * LEN-1'b1:14*LEN]):{(2*LEN){1'b0}};
        ds_result15 <=(FEATURE_NUM>=16) ? (train_data[16 * LEN-1'b1:15*LEN] - feature[16 * LEN-1'b1:15*LEN]) * (train_data[16 * LEN-1'b1:15*LEN] - feature[16 * LEN-1'b1:15*LEN]):{(2*LEN){1'b0}};
    end
end



always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        sigma_result <= {(2*LEN+FEATURE_WIDE){1'b0}};
    end
    else begin
       sigma_result <= ds_result0 + ds_result1 +ds_result2 + ds_result3+
                       ds_result4 + ds_result5 +ds_result6 + ds_result7+
                       ds_result8 + ds_result9 +ds_result10 + ds_result11+
                       ds_result12 + ds_result13 +ds_result14 + ds_result15;
    end

end


endmodule