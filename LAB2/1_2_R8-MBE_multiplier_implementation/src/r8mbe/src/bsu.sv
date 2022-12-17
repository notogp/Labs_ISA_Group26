module bsu #(
  // FPU configuration
  localparam int unsigned WIDTH_PPG = 24,
  localparam int unsigned CONTROL_BITS = 5)
 (
  input  logic [WIDTH_PPG + 2 - 1:0]      oneX,   //26 bits
  input  logic [WIDTH_PPG + 2 - 1:0]      twoX,   //26 bits
  input  logic [WIDTH_PPG + 2 - 1:0]    threeX,   //26 bits
  input  logic [WIDTH_PPG + 2 - 1:0]     fourX,   //26 bits
  input  logic [CONTROL_BITS - 1:0]   control1, 
  input  logic [CONTROL_BITS - 1:0]   control2, 
  input  logic [CONTROL_BITS - 1:0]   control3, 
  input  logic [CONTROL_BITS - 1:0]   control4,
  input  logic [CONTROL_BITS - 1:0]   control5,
  input  logic [CONTROL_BITS - 1:0]   control6,
  input  logic [CONTROL_BITS - 1:0]   control7,
  input  logic [CONTROL_BITS - 1:0]   control8,
  output logic [WIDTH_PPG + 2 - 1:0]        P1,
  output logic [WIDTH_PPG + 2 - 1:0]        P2,
  output logic [WIDTH_PPG + 2 - 1:0]        P3,
  output logic [WIDTH_PPG + 2 - 1:0]        P4,
  output logic [WIDTH_PPG + 2 - 1:0]        P5,
  output logic [WIDTH_PPG + 2 - 1:0]        P6,
  output logic [WIDTH_PPG + 2 - 1:0]        P7,
  output logic [WIDTH_PPG + 2 - 1:0]        P8
  
  );



  bs bs1 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control1),
    .P       (P1)
    );
  
  bs bs2 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control2),
    .P       (P2)
    );
  
  bs bs3 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control3),
    .P       (P3)
    );
  
  bs bs4 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control4),
    .P       (P4)
    );
  
  bs bs5 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control5),
    .P       (P5)
    );
  
  bs bs6 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control6),
    .P       (P6)
    );
  
  bs bs7 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control7),
    .P       (P7)
    );
  
  bs bs8 (
    .oneX    (oneX),
    .twoX    (twoX),
    .threeX  (threeX),
    .fourX   (fourX),
    .control (control8),
    .P       (P8)
    );


endmodule