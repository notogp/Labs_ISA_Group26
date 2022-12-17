module beu_tb;
    logic [23:0] y;
    logic [3:0] ctrl1;
    logic [3:0] ctrl2;
    logic [3:0] ctrl3;
    logic [3:0] ctrl4;
    logic [3:0] ctrl5;
    logic [3:0] ctrl6;
    logic [3:0] ctrl7;
    logic [3:0] ctrl8;    
    
    beu uut (
        .Yin(y),
        .control1(ctrl1),
        .control2(ctrl2),
        .control3(ctrl3),
        .control4(ctrl4),
        .control5(ctrl5),
        .control6(ctrl6),
        .control7(ctrl7),
        .control8(ctrl8)
    );




    initial begin

            #10;
            y = 24'h000000;
            
            #10;
            y = 24'hffffff;
          
            
    end
    
endmodule