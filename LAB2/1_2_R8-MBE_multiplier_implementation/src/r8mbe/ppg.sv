module ppg #(
  localparam int unsigned WIDTH = 24)
 (
  input  logic [WIDTH - 1:0]      Xin, //24 bits
  output logic [WIDTH + 2 - 1:0]    X, //26 bits
  output logic [WIDTH + 2 - 1:0]   2X, //26 bits
  output logic [WIDTH + 2 - 1:0]   3X, //26 bits
  output logic [WIDTH + 2 - 1:0]   4X  //26 bits
  );

assign  X = Xin;
assign 2X = Xin << 1;
assign 3X = X + 2X;
assign 4X = Xin << 2;

endmodule