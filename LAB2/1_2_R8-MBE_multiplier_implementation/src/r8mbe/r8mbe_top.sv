module r8mbe_top #(
  // FPU configuration
  localparam int unsigned WIDTH_OPERATORS = 24,
  localparam int unsigned WIDTH_PRODUCT = 48)
 (
  input  logic [WIDTH_OPERATORS - 1:0]      X, //24 bits
  input  logic [WIDTH_OPERATORS - 1:0]      Y, //24 bits
  output logic [WIDTH_PRODUCT - 1:0]   product  
  );

  //Here we declare all the modules


  endmodule