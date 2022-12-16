module bsu #(
  // FPU configuration
  localparam int unsigned WIDTH_PPG = 14,
  localparam int unsigned CONTROL_BITS = 4)
 (
  input  logic [WIDTH_PPG - 1:0]           X, //14 bits
  input  logic [WIDTH_PPG - 1:0]           2X, //14 bits
  input  logic [WIDTH_PPG - 1:0]           3X, //14 bits
  input  logic [WIDTH_PPG - 1:0]           4X, //14 bits
  input  logic [CONTROL_BITS - 1:0]   control1, 
  input  logic [CONTROL_BITS - 1:0]   control2, 
  input  logic [CONTROL_BITS - 1:0]   control3, 
  input  logic [CONTROL_BITS - 1:0]   control4,
  input  logic [CONTROL_BITS - 1:0]   control5,
  input  logic [CONTROL_BITS - 1:0]   control6,
  input  logic [CONTROL_BITS - 1:0]   control7,
  input  logic [CONTROL_BITS - 1:0]   control8,
  output logic [WIDTH_PPG - 1:0]            P0,
  output logic [WIDTH_PPG - 1:0]            P1,
  output logic [WIDTH_PPG - 1:0]            P2,
  output logic [WIDTH_PPG - 1:0]            P3  
  );



  bs #()
   bs1 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );

  bs #()
   bs2 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );
    
  bs #()
   bs3 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );

  bs #()
   bs4 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );

  bs #()
   bs5 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );

  bs #()
   bs6 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );

  bs #()
   bs7 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );

  bs #()
   bs8 (
    .X       (X),
    .2X      (2X),
    .3X      (3X),
    .4X      (4X),
    .control (),
    .P       ()
    );
    
endmodule