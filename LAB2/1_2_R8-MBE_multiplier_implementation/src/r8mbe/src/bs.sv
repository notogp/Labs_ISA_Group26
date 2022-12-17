module bs #(
  localparam int unsigned WIDTH_PPG = 24,
  localparam int unsigned CONTROL_BITS = 5)
 (
  input  logic [WIDTH_PPG + 2 - 1:0]      oneX,       //26 bits
  input  logic [WIDTH_PPG + 2 - 1:0]      twoX,    //26 bits
  input  logic [WIDTH_PPG + 2 - 1:0]      threeX,  //26 bits
  input  logic [WIDTH_PPG + 2 - 1:0]      fourX,   //26 bits
  input  logic [CONTROL_BITS - 1:0]   control, //4 bits
  output logic [WIDTH_PPG + 2 - 1:0]  P       //26 bits
  );

//In input we should have also a vector containing all the ni

//control[0] = ai
//control[1] = bi
//control[2] = ci
//control[3] = di
//control[4] = ni

//assign P = (((ai & xj) ~| (bi & xj-1)) ~& ((ci & xj+xj-1) ~| (di & xj-2))) ^ ni
	always @(control[0], control[1], control[2], control[3], control[4]) begin
		case ({control[0], control[1], control[2], control[3], control[4]})
			5'b00000 :  P =  26'b0; 
			5'b10000 :  P =  oneX;
			5'b01000 :  P =  twoX;
			5'b00100 :  P =  threeX; 
			5'b00010 :  P =  fourX;
			5'b00011 :  P = -fourX;
			5'b00101 :  P = -threeX;
			5'b01001 :  P = -twoX;
			5'b10001 :  P = -oneX;
			5'b11111 :  P =  26'b0; 
			default  : P =  26'bx; 
		endcase

	end

endmodule