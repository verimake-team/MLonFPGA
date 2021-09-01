
module DT
#(  
    parameter LAYER_NUM    =6                                             ,  //up to 5 
    parameter FEATURE_WIDE =13                                            ,  //input feature Intege bit width
    parameter FEATURE_NUM  =6                                            ,  //Number of input feature,up to 16
    parameter LAYER_CON0   =4'd0                                          ,
    parameter LAYER_CON1   ={4'd1,4'd0}                                   ,
    parameter LAYER_CON2   ={4'd3,4'd2,4'd1,4'd0}                         ,
    parameter LAYER_CON3   ={4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0}     ,
    parameter LAYER_CON4   ={4'd15,4'd14,4'd13,4'd12,4'd11,4'd10,4'd9,4'd8,
                             4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0     },
    parameter LAYER_CON5   ={4'd15,4'd14,4'd13,4'd12,4'd11,4'd10,4'd9,4'd8,
                             4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0,4'd15,
                             4'd14,4'd13,4'd12,4'd11,4'd10,4'd9,4'd8,4'd7 ,
                             4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0},
    parameter CLASS_WIDTH  =7                                     //layer_num=1(2),layer_num=2(3),=3(4),=4(5),=5(6),=6(7)
)
(
    input                             clk       ,
    input                             rst_n     ,
    input                             en        ,
    input    [FEATURE_WIDE-1'b1:0]    feature   ,


    output reg [CLASS_WIDTH-1'b1:0]   out_class ,
    output reg                        en_end 
);

reg         [CLASS_WIDTH-1'b1:0]        cnt                       ;

reg         [FEATURE_WIDE-1'b1:0]       mem[FEATURE_NUM-1'b1:0]   ;

reg         [FEATURE_WIDE-1'b1:0]       feature_r                 ;

reg         [FEATURE_WIDE-1'b1:0]       feature_rr                ;

reg                                     en_00                     ;

reg                                     en_10                     ;

reg                                     en_11                     ;

reg                                     en_20                     ;

reg                                     en_21                     ;

reg                                     en_22                     ;

reg                                     en_30                     ;

reg                                     en_31                     ;

reg                                     en_32                     ;

reg                                     en_33                     ;

reg                                     en_40                     ;

reg                                     en_41                     ;

reg                                     en_42                     ;

reg                                     en_43                     ;

reg                                     en_44                     ;

reg                                     en_50                     ;

reg                                     en_51                     ;

reg                                     en_52                     ;

reg                                     en_53                     ;

reg                                     en_54                     ;

reg                                     en_55                     ;

reg                                     en_60                     ;

reg                                     en_61                     ;

reg                                     en_62                     ;

reg                                     en_63                     ;

reg                                     en_64                     ;

reg                                     en_65                     ;

reg                                     en_66                     ;

reg                                     en_70                     ;

reg                                     en_71                     ;

reg                                     en_72                     ;

reg                                     en_73                     ;

wire [1:0]                              end_00                    ;

wire [1:0]                              end_10                    ;

wire [1:0]                              end_11                    ;

wire [1:0]                              end_20                    ;

wire [1:0]                              end_21                    ;

wire [1:0]                              end_22                    ;

wire [1:0]                              end_30                    ;

wire [1:0]                              end_31                    ;

wire [1:0]                              end_32                    ;

wire [1:0]                              end_33                    ;

wire [1:0]                              end_40                    ;

wire [1:0]                              end_41                    ;

wire [1:0]                              end_42                    ;

wire [1:0]                              end_43                    ;

wire [1:0]                              end_44                    ;

wire [1:0]                              end_50                    ;

wire [1:0]                              end_51                    ;

wire [1:0]                              end_52                    ;

wire [1:0]                              end_53                    ;

wire [1:0]                              end_54                    ;

wire [1:0]                              end_55                    ;

wire [1:0]                              end_60                    ;

wire [1:0]                              end_61                    ;

wire [1:0]                              end_62                    ;

wire [1:0]                              end_63                    ;

wire [1:0]                              end_64                    ;

wire [1:0]                              end_65                    ;

wire [1:0]                              end_66                    ;

wire [1:0]                              end_70                    ;

wire [1:0]                              end_71                    ;

wire [1:0]                              end_72                    ;

wire [1:0]                              end_73                    ;

reg [2:0]                               cnt_delay                 ;

wire                                    flag                      ;

reg [2:0]                               cnt_layer                 ;

wire [FEATURE_WIDE-1'b1:0]              train                     ;

reg [5:0]                               address                   ;

wire                                    flag_en                   ;

reg                                     flag_en_r                 ;



assign flag=(cnt_delay==2'd0 && flag_en==1'b1)?1'b1:1'b0;

assign flag_en=(cnt==FEATURE_NUM)?1'b1:1'b0;

always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt<={CLASS_WIDTH{1'b0}};
    end
    else if(flag_en==1'b1)begin
        cnt<=FEATURE_NUM;
    end 
    else if(en==1'b1)begin
        cnt<=cnt+1'b1;
   end 
end 


always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt_delay<=3'd0;
    end
    else if(cnt_delay==3'd2)begin
        cnt_delay<=3'd0;
    end 
    else if(flag_en==1'b1)begin
        cnt_delay<=cnt_delay+1'b1;
   end 
end 


always@(posedge clk or negedge rst_n )begin
    if(!rst_n)begin
        cnt_layer<=3'd1;
    end
    else if(cnt_layer==LAYER_NUM)begin
        cnt_layer<=LAYER_NUM;
    end 
    else if(cnt_delay==3'd2)begin
        cnt_layer<=cnt_layer+1'b1;
   end 
end 



always@(posedge clk )begin
    if (en==1'b1)begin
        mem[cnt]=feature;
    end 
end 


always@(posedge clk )begin 
    feature_rr<=feature_r;
    flag_en_r <=flag_en  ;
end 



always@(posedge clk )begin
    if (en==1'b0)begin
        en_00<=1'b0;
        en_10<=1'b0;
        en_11<=1'b0;
        en_20<=1'b0;
        en_21<=1'b0;
        en_22<=1'b0;
        en_30<=1'b0;
        en_31<=1'b0;
        en_32<=1'b0;
        en_33<=1'b0;
        en_40<=1'b0;
        en_41<=1'b0;
        en_42<=1'b0;
        en_43<=1'b0;
        en_44<=1'b0;
        en_50<=1'b0;
        en_51<=1'b0;
        en_52<=1'b0;
        en_53<=1'b0;
        en_54<=1'b0;
        en_55<=1'b0;
        en_60<=1'b0;
        en_61<=1'b0;
        en_62<=1'b0;
        en_63<=1'b0;
        en_64<=1'b0;
        en_65<=1'b0;
        en_66<=1'b0;
        en_70<=1'b0;
        en_71<=1'b0;
        en_72<=1'b0;
        en_73<=1'b0;
    end 
    else if (flag==1'b1)begin
         if ( (LAYER_NUM>=1 && end_00==2'd1)||(flag_en_r==1'b0 && flag_en==1'b1))begin
            en_00<=1'b1;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end 
         else if (LAYER_NUM>=2 && end_00==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b1;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
            
          end 
         else if (LAYER_NUM>=3 && end_10==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b1;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end 
         else if (LAYER_NUM>=3 && end_10==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b1;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end    
         else if (LAYER_NUM>=4 && end_11==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b1;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end  
         else if (LAYER_NUM>=4 && end_11==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b1;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end  
         else if (LAYER_NUM>=4 && end_20==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b1;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end  
         else if (LAYER_NUM>=4 && end_20==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b1;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_21==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b1;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_21==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b1;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_22==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b1;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_22==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b1;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_30==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b1;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_30==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b1;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_31==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b1;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=5 && end_31==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b1;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_32==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b1;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_32==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b1;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_33==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b1;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_33==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b1;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_40==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b1;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_40==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b1;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_41==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b1;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_41==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b1;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_42==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b1;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_42==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b1;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_43==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b1;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_43==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b1;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_44==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b1;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_44==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b1;
            en_72<=1'b0;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_50==2'd1 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b1;
            en_73<=1'b0;
          end
         else if (LAYER_NUM>=6 && end_50==2'd2 )begin
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b1;
          end
         else begin 
            en_00<=1'b0;
            en_10<=1'b0;
            en_11<=1'b0;
            en_20<=1'b0;
            en_21<=1'b0;
            en_22<=1'b0;
            en_30<=1'b0;
            en_31<=1'b0;
            en_32<=1'b0;
            en_33<=1'b0;
            en_40<=1'b0;
            en_41<=1'b0;
            en_42<=1'b0;
            en_43<=1'b0;
            en_44<=1'b0;
            en_50<=1'b0;
            en_51<=1'b0;
            en_52<=1'b0;
            en_53<=1'b0;
            en_54<=1'b0;
            en_55<=1'b0;
            en_60<=1'b0;
            en_61<=1'b0;
            en_62<=1'b0;
            en_63<=1'b0;
            en_64<=1'b0;
            en_65<=1'b0;
            en_66<=1'b0;
            en_70<=1'b0;
            en_71<=1'b0;
            en_72<=1'b0;
            en_73<=1'b0;
         end 
    end
    else begin 
        en_00<=en_00;
        en_10<=en_10;
        en_11<=en_11;
        en_20<=en_20;
        en_21<=en_21;
        en_22<=en_22;
        en_30<=en_30;
        en_31<=en_31;
        en_32<=en_32;
        en_33<=en_33;
        en_40<=en_40;
        en_41<=en_41;
        en_42<=en_42;
        en_43<=en_43;
        en_44<=en_44;
        en_50<=en_50;
        en_51<=en_51;
        en_52<=en_52;
        en_53<=en_53;
        en_54<=en_54;
        en_55<=en_55;
        en_60<=en_60;
        en_61<=en_61;
        en_62<=en_62;
        en_63<=en_63;
        en_64<=en_64;
        en_65<=en_65;
        en_66<=en_66;
        en_70<=en_70;
        en_71<=en_71;
        en_72<=en_72;
        en_73<=en_73;

    end 
end 



always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        feature_r<={FEATURE_WIDE{1'b0}};
    end 
    else if (end_62==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[127:124]];
    end 
    else if (end_62==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[123:120]];
    end
    else if (end_61==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[119:116]];
    end 
    else if (end_61==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[115:112]];
    end
    else if (end_60==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[111:108]];
    end 
    else if (end_60==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[107:104]];
    end
    else if (end_55==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[103:100]];
    end 
    else if (end_55==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[99:96]];
    end
    else if (end_54==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[95:92]];
    end 
    else if (end_54==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[91:88]];
    end
    else if (end_53==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[87:84]];
    end 
    else if (end_53==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[83:80]];
    end
    else if (end_52==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[79:76]];
    end 
    else if (end_52==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[75:72]];
    end
    else if (end_51==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[71:68]];
    end 
    else if (end_51==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[67:64]];
    end 
    else if (end_50==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[63:60]];
    end 
    else if (end_50==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[59:56]];
    end 
    else if (end_44==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[55:52]];
    end 
    else if (end_44==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[51:48]];
    end 
    else if (end_43==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[47:44]];
    end 
    else if (end_43==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[43:40]];
    end 
    else if (end_42==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[39:36]];
    end 
    else if (end_42==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[35:32]];
    end 
    else if (end_41==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[31:28]];
    end 
    else if (end_41==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[27:24]];
    end 
    else if (end_40==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[23:20]];
    end 
    else if (end_40==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[19:16]];
    end 
    else if (end_33==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[15:12]];
    end 
    else if (end_33==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[11:8]];
    end 
    else if (end_32==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[7:4]];
    end 
    else if (end_32==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        feature_r<=mem[LAYER_CON5[3:0]];
    end 
    else if (end_31==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[63:60]];
    end 
    else if (end_31==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[59:56]];
    end 
    else if (end_30==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[55:52]];
    end 
    else if (end_30==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[51:48]];
    end 
    else if (end_22==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[47:44]];
    end 
    else if (end_22==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[43:40]];
    end 
    else if (end_21==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[39:36]];
    end 
    else if (end_21==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[35:32]];
    end 
    else if (end_20==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[31:28]];
    end 
    else if (end_20==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[27:24]];
    end 
    else if (end_11==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[23:20]];
    end 
    else if (end_11==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[19:16]];
    end 
    else if (end_10==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[15:12]];
    end 
    else if (end_10==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[11:8]];
    end 
    else if (end_00==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[7:4]];
    end 
    else if (end_00==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        feature_r<=mem[LAYER_CON4[3:0]];
    end 
    else if (end_20==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[31:28]];
    end 
    else if (end_20==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[27:24]];
    end 
    else if (end_11==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[23:20]];
    end 
    else if (end_11==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[19:16]];
    end 
    else if (end_10==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[15:12]];
    end 
    else if (end_10==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[11:8]];
    end 
    else if (end_00==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[7:4]];
    end 
    else if (end_00==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        feature_r<=mem[LAYER_CON3[3:0]];
    end 
    else if (end_10==2'd2 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        feature_r<=mem[LAYER_CON2[15:12]];
    end 
    else if (end_10==2'd1 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        feature_r<=mem[LAYER_CON2[11:8]];
    end 
    else if (end_00==2'd2 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        feature_r<=mem[LAYER_CON2[7:4]];
    end 
    else if (end_00==2'd1 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        feature_r<=mem[LAYER_CON2[3:0]];
    end 
    else if (end_00==2'd2 && cnt_layer==3'd2 && LAYER_NUM>=2)begin
        feature_r<=mem[LAYER_CON1[7:4]];
    end 
    else if (end_00==2'd1 && cnt_layer==3'd2 && LAYER_NUM>=2)begin
        feature_r<=mem[LAYER_CON1[3:0]];
    end 
    else if (flag_en==1'b1 && cnt_layer==3'd1)begin
        feature_r<=mem[LAYER_CON0];
    end
end 



always@(*)begin
    if (!rst_n)begin
        address =6'd0;
    end 
    else if (end_50==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd62;
    end 
    else if (end_50==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd61;
    end 
    else if (end_44==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd60;
    end 
    else if (end_44==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd59;
    end 
    else if (end_43==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd58;
    end 
    else if (end_43==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd57;
    end 
    else if (end_42==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd56;
    end 
    else if (end_42==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd55;
    end
    else if (end_41==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd54;
    end 
    else if (end_41==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd53;
    end 
    else if (end_40==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd52;
    end 
    else if (end_40==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd51;
    end 
    else if (end_33==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd50;
    end 
    else if (end_33==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd49;
    end 
    else if (end_32==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd48;
    end 
    else if (end_32==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd47;
    end
    else if (end_31==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd46;
    end 
    else if (end_31==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd45;
    end 
    else if (end_30==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd44;
    end 
    else if (end_30==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd43;
    end 
    else if (end_22==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd42;
    end 
    else if (end_22==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd41;
    end 
    else if (end_21==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd40;
    end 
    else if (end_21==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd39;
    end
    else if (end_20==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd38;
    end 
    else if (end_20==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd37;
    end 
    else if (end_11==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd36;
    end 
    else if (end_11==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd35;
    end 
    else if (end_10==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd34;
    end 
    else if (end_10==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd33;
    end 
    else if (end_00==2'd2 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd32;
    end 
    else if (end_00==2'd1 && cnt_layer==3'd6 && LAYER_NUM>=6)begin
        address =6'd31;
    end
    else if (end_31==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd30;
    end 
    else if (end_31==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd29;
    end 
    else if (end_30==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd28;
    end 
    else if (end_30==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd27;
    end 
    else if (end_22==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd26;
    end 
    else if (end_22==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd25;
    end 
    else if (end_21==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd24;
    end 
    else if (end_21==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd23;
    end
    else if (end_20==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd22;
    end 
    else if (end_20==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd21;
    end 
    else if (end_11==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd20;
    end 
    else if (end_11==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd19;
    end 
    else if (end_10==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd18;
    end 
    else if (end_10==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd17;
    end 
    else if (end_00==2'd2 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd16;
    end 
    else if (end_00==2'd1 && cnt_layer==3'd5 && LAYER_NUM>=5)begin
        address =6'd15;
    end
    else if (end_20==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd14;
    end 
    else if (end_20==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd13;
    end 
    else if (end_11==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd12;
    end 
    else if (end_11==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd11;
    end 
    else if (end_10==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd10;
    end 
    else if (end_10==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd9;
    end 
    else if (end_00==2'd2 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd8;
    end 
    else if (end_00==2'd1 && cnt_layer==3'd4 && LAYER_NUM>=4)begin
        address =6'd7;
    end 
    else if (end_10==2'd2 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        address =6'd6;
    end 
    else if (end_10==2'd1 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        address =6'd5;
    end 
    else if (end_00==2'd2 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        address =6'd4;
    end 
    else if (end_00==2'd1 && cnt_layer==3'd3 && LAYER_NUM>=3)begin
        address =6'd3;
    end 
    else if (end_00==2'd2 && cnt_layer==3'd2 && LAYER_NUM>=2)begin
        address =6'd2;
    end 
    else if (end_00==2'd1 && cnt_layer==3'd2 && LAYER_NUM>=2)begin
        address =6'd1;
    end 
    else if (flag_en==1'b1 && cnt_layer==3'd1)begin
        address =6'd0;
    end
    else begin
        address =6'd0;
    
    end 

end 


always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        out_class<={(CLASS_WIDTH){1'b0}};
    end 
    else if (cnt_layer==LAYER_NUM && flag==1'b1)begin
        if (end_00==2'd1)begin 
            out_class<=2'd1;
        end 
        else if (end_00==2'd2)begin 
            out_class<=2'd2;
        end 
        else if (end_10==2'd1)begin 
            out_class<=2'd3;
        end 
        else if (end_10==2'd2)begin 
            out_class<=3'd4;
        end 
        else if (end_11==2'd1)begin 
            out_class<=3'd5;
        end 
        else if (end_11==2'd2)begin 
            out_class<=3'd6;
        end 
        else if (end_20==2'd1)begin 
            out_class<=3'd7;
        end 
        else if (end_20==2'd2)begin 
            out_class<=4'd8;
        end 
        else if (end_21==2'd1)begin 
            out_class<=4'd9;
        end 
        else if (end_21==2'd2)begin 
            out_class<=4'd10;
        end 
        else if (end_22==2'd1)begin 
            out_class<=4'd11;
        end 
        else if (end_22==2'd2)begin 
            out_class<=4'd12;
        end 
        else if (end_30==2'd1)begin 
            out_class<=4'd13;
        end 
        else if (end_30==2'd2)begin 
            out_class<=4'd14;
        end 
        else if (end_31==2'd1)begin 
            out_class<=4'd15;
        end 
        else if (end_31==2'd2)begin 
            out_class<=5'd16;
        end 
        else if (end_32==2'd1)begin 
            out_class<=5'd17;
        end 
        else if (end_32==2'd2)begin 
            out_class<=5'd18;
        end 
        else if (end_33==2'd1)begin 
            out_class<=5'd19;
        end 
        else if (end_33==2'd2)begin 
            out_class<=5'd20;
        end 
        else if (end_40==2'd1)begin 
            out_class<=5'd21;
        end 
        else if (end_40==2'd2)begin 
            out_class<=5'd22;
        end 
        else if (end_41==2'd1)begin 
            out_class<=5'd23;
        end 
        else if (end_41==2'd2)begin 
            out_class<=5'd24;
        end 
        else if (end_42==2'd1)begin 
            out_class<=5'd25;
        end 
        else if (end_42==2'd2)begin 
            out_class<=5'd26;
        end 
        else if (end_43==2'd1)begin 
            out_class<=5'd27;
        end 
        else if (end_43==2'd2)begin 
            out_class<=5'd28;
        end 
        else if (end_44==2'd1)begin 
            out_class<=5'd29;
        end 
        else if (end_44==2'd2)begin 
            out_class<=5'd30;
        end 
        else if (end_50==2'd1)begin 
            out_class<=5'd31;
        end 
        else if (end_50==2'd2)begin 
            out_class<=6'd32;
        end
        else if (end_51==2'd1)begin 
            out_class<=6'd33;
        end 
        else if (end_51==2'd2)begin 
            out_class<=6'd34;
        end 
        else if (end_52==2'd1)begin 
            out_class<=6'd35;
        end 
        else if (end_52==2'd2)begin 
            out_class<=6'd36;
        end 
        else if (end_53==2'd1)begin 
            out_class<=6'd37;
        end 
        else if (end_53==2'd2)begin 
            out_class<=6'd38;
        end 
        else if (end_54==2'd1)begin 
            out_class<=6'd39;
        end 
        else if (end_54==2'd2)begin 
            out_class<=6'd40;
        end 
        else if (end_55==2'd1)begin 
            out_class<=6'd41;
        end 
        else if (end_55==2'd2)begin 
            out_class<=6'd42;
        end 
        else if (end_60==2'd1)begin 
            out_class<=6'd43;
        end 
        else if (end_60==2'd2)begin 
            out_class<=6'd44;
        end 
        else if (end_61==2'd1)begin 
            out_class<=6'd45;
        end 
        else if (end_61==2'd2)begin 
            out_class<=6'd46;
        end 
        else if (end_62==2'd1)begin 
            out_class<=6'd47;
        end 
        else if (end_62==2'd2)begin 
            out_class<=6'd48;
        end 
        else if (end_63==2'd1)begin 
            out_class<=6'd49;
        end 
        else if (end_63==2'd2)begin 
            out_class<=6'd50;
        end 
        else if (end_64==2'd1)begin 
            out_class<=6'd51;
        end 
        else if (end_64==2'd2)begin 
            out_class<=6'd52;
        end 
        else if (end_65==2'd1)begin 
            out_class<=6'd53;
        end 
        else if (end_65==2'd2)begin 
            out_class<=6'd54;
        end 
        else if (end_66==2'd1)begin 
            out_class<=6'd55;
        end 
        else if (end_66==2'd2)begin 
            out_class<=6'd56;
        end 
        else if (end_70==2'd1)begin 
            out_class<=6'd57;
        end 
        else if (end_70==2'd2)begin 
            out_class<=6'd58;
        end 
        else if (end_71==2'd1)begin 
            out_class<=6'd59;
        end 
        else if (end_71==2'd2)begin 
            out_class<=6'd60;
        end 
        else if (end_72==2'd1)begin 
            out_class<=6'd61;
        end 
        else if (end_72==2'd2)begin 
            out_class<=6'd62;
        end
        else if (end_73==2'd1)begin 
            out_class<=6'd63;
        end 
        else if (end_73==2'd2)begin 
            out_class<=7'd64;
        end
    end 
    else begin
        out_class<={(CLASS_WIDTH){1'b0}};
    end 

end 


always@(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        en_end<=1'b0;
    end 
    else if (flag==1'b1 && cnt_layer==LAYER_NUM)begin
        en_end<=1'b1;
    end 
end 




/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////



data  data(
    .address(address                ),
    .clock  (clk                    ),
    .rden   (en                     ),
    
    .q      (train                  )
);





node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_00(
   .clk          (clk            ),
   .rst_n        (en_00          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_00         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_10(
   .clk          (clk            ),
   .rst_n        (en_10          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_10         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_11(
   .clk          (clk            ),
   .rst_n        (en_11          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_11         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_20(
   .clk          (clk            ),
   .rst_n        (en_20          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_20         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_21(
   .clk          (clk            ),
   .rst_n        (en_21          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_21         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_22(
   .clk          (clk            ),
   .rst_n        (en_22          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_22         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_30(
   .clk          (clk            ),
   .rst_n        (en_30          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_30         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_31(
   .clk          (clk            ),
   .rst_n        (en_31          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_31         )  
);




node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_32(
   .clk          (clk            ),
   .rst_n        (en_32          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_32         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_33(
   .clk          (clk            ),
   .rst_n        (en_33          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_33         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_40(
   .clk          (clk            ),
   .rst_n        (en_40          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_40         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_41(
   .clk          (clk            ),
   .rst_n        (en_41          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_41         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_42(
   .clk          (clk            ),
   .rst_n        (en_42          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_42         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_43(
   .clk          (clk            ),
   .rst_n        (en_43          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_43         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_44(
   .clk          (clk            ),
   .rst_n        (en_44          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_44         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_50(
   .clk          (clk            ),
   .rst_n        (en_50          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_50         )  
);
 
/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////

node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_51(
   .clk          (clk            ),
   .rst_n        (en_51          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_51         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_52(
   .clk          (clk            ),
   .rst_n        (en_52          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_52         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_53(
   .clk          (clk            ),
   .rst_n        (en_53          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_53         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_54(
   .clk          (clk            ),
   .rst_n        (en_54          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_54         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_55(
   .clk          (clk            ),
   .rst_n        (en_55          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_55         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_60(
   .clk          (clk            ),
   .rst_n        (en_60          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_60         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_61(
   .clk          (clk            ),
   .rst_n        (en_61          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_61         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_62(
   .clk          (clk            ),
   .rst_n        (en_62          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_62         )  
);




node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_63(
   .clk          (clk            ),
   .rst_n        (en_63          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_63         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_64(
   .clk          (clk            ),
   .rst_n        (en_64          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_64         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_65(
   .clk          (clk            ),
   .rst_n        (en_65          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_65         )  
);



node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_66(
   .clk          (clk            ),
   .rst_n        (en_66          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_66         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_70(
   .clk          (clk            ),
   .rst_n        (en_70          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_70         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_71(
   .clk          (clk            ),
   .rst_n        (en_71          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_71         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_72(
   .clk          (clk            ),
   .rst_n        (en_72          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_72         )  
);


node
#(
   .FEATURE_WIDE (FEATURE_WIDE   )                         //input feature Intege bit width
)
node_73(
   .clk          (clk            ),
   .rst_n        (en_73          ),
   .feature      (feature_rr     ),
   .train        (train          ),
                                 
   .en_end       (end_73         )  
);



endmodule 