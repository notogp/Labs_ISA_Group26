module ppg #(
  localparam int unsigned WIDTH = 24)
 (
  input  logic [WIDTH - 1:0]         Xin, //24 bits
  output logic [WIDTH + 2 - 1:0]    oneX, //26 bits
  output logic [WIDTH + 2 - 1:0]    twoX, //26 bits
  output logic [WIDTH + 2 - 1:0]  threeX, //26 bits
  output logic [WIDTH + 2 - 1:0]   fourX  //26 bits
  );

assign oneX = Xin;
assign twoX = Xin << 1;
assign threeX = oneX + twoX;
assign fourX = Xin << 2;

endmodule