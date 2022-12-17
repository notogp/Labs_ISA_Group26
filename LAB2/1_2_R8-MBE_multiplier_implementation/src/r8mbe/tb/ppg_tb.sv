module ppg_tb;

    logic [23:0] Xin;
    logic [25:0] SIGNALX;
    logic [25:0] SIGNAL2X;
    logic [25:0] SIGNAL3X;
    logic [25:0] SIGNAL4X;

    ppg uut (
        .Xin(Xin),
        .oneX(SIGNALX),
        .twoX(SIGNAL2X),
        .threeX(SIGNAL3X),
        .fourX(SIGNAL4X)
    );



    initial begin

            #10;
            Xin = 1;
            
            #10;
            Xin = 2;
            
    end
    
endmodule