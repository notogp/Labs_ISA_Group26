module bs #(
  localparam int unsigned WIDTH_PPG = 14,
  localparam int unsigned CONTROL_BITS = 4)
 (
  input  logic [WIDTH_PPG - 1:0]      X,       //14 bits
  input  logic [WIDTH_PPG - 1:0]      2X,      //14 bits
  input  logic [WIDTH_PPG - 1:0]      3X,      //14 bits
  input  logic [WIDTH_PPG - 1:0]      4X,      //14 bits
  input  logic [CONTROL_BITS - 1:0]   control, //4 bits
  output logic [WIDTH_PPG - 1:0]      P, //14 bits
  );

//In input we should have also a vector containing all the ni

//control[0] = ai
//control[1] = bi
//control[2] = ci
//control[3] = di

assign P = (((ai & xj) ~| (bi & xj-1)) ~& ((ci & xj+xj-1) ~| (di & xj-2))) ^ ni


endmodule