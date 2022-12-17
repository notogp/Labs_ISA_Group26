module r8mbe_tb;
    logic [23:0] X;
    logic [23:0] Y;
    logic [47:0] product;
    
    logic [25:0] oneXout;
    logic [25:0] twoXout;
    logic [25:0] threeXout;
    logic [25:0] fourXout;

    r8mbe_top uut (
        .X        (X), //24 bits
        .Y        (Y), //24 bits
        .product  (product),
        .oneXout  (oneXout),
        .twoXout  (twoXout),
        .threeXout(threeXout),
        .fourXout (fourXout)
    );




    initial begin

        #10;
        X = 0;
        Y = 0;
        
        #10;
        X = 12;
        Y = 12;

        #10;
        X = 11;
        Y = 11;

        #10;
        X = 1;
        Y = 1; 

        #10;
        X = 5;
        Y = 5;      
    end
    
endmodule