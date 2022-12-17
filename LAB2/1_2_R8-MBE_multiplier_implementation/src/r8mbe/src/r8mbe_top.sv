module r8mbe_top #(
  // FPU configuration
  localparam int unsigned WIDTH_OPERATORS = 24,
  localparam int unsigned WIDTH_PRODUCT = 48,
  localparam int unsigned CONTROL_BITS = 5)
 (
  input  logic [WIDTH_OPERATORS - 1:0]      X, //24 bits
  input  logic [WIDTH_OPERATORS - 1:0]      Y, //24 bits
  output logic [WIDTH_PRODUCT - 1:0]   product,  
  output logic [WIDTH_OPERATORS + 2 - 1:0]  oneXout, //26 bits
  output logic [WIDTH_OPERATORS + 2 - 1:0]  twoXout, //26 bits
  output logic [WIDTH_OPERATORS + 2 - 1:0]  threeXout, //26 bits
  output logic [WIDTH_OPERATORS + 2 - 1:0]  fourXout //26 bits

  );

  logic [WIDTH_OPERATORS + 2 - 1 :0] oneX;
  logic [WIDTH_OPERATORS + 2 - 1 :0] twoX;
  logic [WIDTH_OPERATORS + 2 - 1 :0] threeX;
  logic [WIDTH_OPERATORS + 2 - 1 :0] fourX;
  logic [CONTROL_BITS - 1 :0] control1;
  logic [CONTROL_BITS - 1 :0] control2;
  logic [CONTROL_BITS - 1 :0] control3;
  logic [CONTROL_BITS - 1 :0] control4;
  logic [CONTROL_BITS - 1 :0] control5;
  logic [CONTROL_BITS - 1 :0] control6;
  logic [CONTROL_BITS - 1 :0] control7;
  logic [CONTROL_BITS - 1 :0] control8;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P1;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P2;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P3;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P4;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P5;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P6;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P7;
  logic [WIDTH_OPERATORS + 2 - 1 :0] P8;
  
  logic [WIDTH_PRODUCT - 1:0] P1shifted;
  logic [WIDTH_PRODUCT - 1:0] P2shifted;
  logic [WIDTH_PRODUCT - 1:0] P3shifted;
  logic [WIDTH_PRODUCT - 1:0] P4shifted;
  logic [WIDTH_PRODUCT - 1:0] P5shifted;
  logic [WIDTH_PRODUCT - 1:0] P6shifted;
  logic [WIDTH_PRODUCT - 1:0] P7shifted;
  logic [WIDTH_PRODUCT - 1:0] P8shifted;
  
  
  //Here we declare all the modules
    ppg ppg_uut (
        .Xin         (X), //24 bits
        .oneX     (oneX), //26 bits
        .twoX     (twoX), //26 bits
        .threeX (threeX), //26 bits
        .fourX   (fourX)  //26 bits
    );

    beu beu_uut (
        .Yin      (Y),
        .control1 (control1),
        .control2 (control2),
        .control3 (control3),
        .control4 (control4),
        .control5 (control5),
        .control6 (control6),
        .control7 (control7),
        .control8 (control8) 
    );

    bsu bsu_uut (
        .oneX     (oneX),
        .twoX     (twoX),
        .threeX   (threeX),
        .fourX    (fourX),
        .control1 (control1),
        .control2 (control2),
        .control3 (control3),
        .control4 (control4),
        .control5 (control5),
        .control6 (control6),
        .control7 (control7),
        .control8 (control8),
        .P1       (P1),
        .P2       (P2),
        .P3       (P3),
        .P4       (P4),
        .P5       (P5),
        .P6       (P6),
        .P7       (P7),
        .P8       (P8)

    );

    assign P1shifted = {P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1[25],P1};
    assign P2shifted = {P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25],P2[25], P2, 3'b000};
    assign P3shifted = {P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25],P3[25], P3, 6'b000000};
    assign P4shifted = {P4[25],P4[25],P4[25],P4[25],P4[25],P4[25],P4[25],P4[25],P4[25],P4[25],P4[25],P4[25],P4[25], P4, 9'b000000000};
    assign P5shifted = {P5[25],P5[25],P5[25],P5[25],P5[25],P5[25],P5[25],P5[25],P5[25],P5[25], P5, 12'b000000000000};
    assign P6shifted = {P6[25],P6[25],P6[25],P6[25],P6[25],P6[25],P6[25], P6, 15'b000000000000000};
    assign P7shifted = {P7[25],P7[25],P7[25],P7[25], P7, 18'b000000000000000000};
    assign P8shifted = {P8[25], P8, 21'b000000000000000000000};
    
    assign oneXout   = oneX;
    assign twoXout   = twoX;
    assign threeXout = threeX;
    assign fourXout  = fourX;

    assign product = P1shifted + P2shifted + P3shifted + P4shifted + P5shifted + P6shifted + P7shifted + P8shifted;
    //assign product = P1shifted+P2shifted+P3+P4+P5+P6+P7+P8;
  endmodule