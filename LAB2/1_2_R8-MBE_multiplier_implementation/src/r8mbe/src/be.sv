module be #(
  localparam int unsigned CONTROL_BITS = 5,
  localparam int unsigned YBITS = 4)
 (
  input  logic [YBITS - 1:0]   Y_4bits, //4 bits
  output logic [CONTROL_BITS - 1:0]   control 
  );

//Y(3i-1)  -->  Y_4bits[0]  
//Y(3i)    -->  Y_4bits[1]
//Y(3i+1)  -->  Y_4bits[2]
//Y(3i+2)  -->  Y_4bits[3]

//The following logic functions doesn't work properly, so we used the switch case

//assign  control[0] = ~(((Y_4bits[0]) ~^ (Y_4bits[1])) & (~((Y_4bits[2]) ~^ (Y_4bits[3]))));                         //ai
//assign  control[1] = ~((~(Y_4bits[0] ~^ Y_4bits[1])) & (Y_4bits[1] ~^ Y_4bits[2]));                                 //bi
//assign  control[2] = ~((Y_4bits[0] ~^ Y_4bits[1]) & (Y_4bits[2] ~^ Y_4bits[3]));                                    //ci
//assign  control[3] = ~((~(Y_4bits[0] ~^ Y_4bits[1])) & (~(Y_4bits[2] ~^ Y_4bits[3])) & (Y_4bits[2] ~^ Y_4bits[3])); //di

always @(Y_4bits) begin
		case (Y_4bits)
			4'b0000	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00000; 
			4'b0001	: {control[0], control[1], control[2], control[3], control[4]} = 5'b10000;
			4'b0010	: {control[0], control[1], control[2], control[3], control[4]} = 5'b10000;
			4'b0011	: {control[0], control[1], control[2], control[3], control[4]} = 5'b01000;
			4'b0100	: {control[0], control[1], control[2], control[3], control[4]} = 5'b01000;
			4'b0101	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00100;
			4'b0110	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00100;
			4'b0111	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00010;
			4'b1000	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00011;
			4'b1001	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00101;
			4'b1010	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00101;
			4'b1011	: {control[0], control[1], control[2], control[3], control[4]} = 5'b01001;
			4'b1100	: {control[0], control[1], control[2], control[3], control[4]} = 5'b01001;
			4'b1101	: {control[0], control[1], control[2], control[3], control[4]} = 5'b10001;
			4'b1110	: {control[0], control[1], control[2], control[3], control[4]} = 5'b10001;
			4'b1111	: {control[0], control[1], control[2], control[3], control[4]} = 5'b00001;
			default : {control[0], control[1], control[2], control[3], control[4]} = 5'bxxxxx;
		endcase
	end

endmodule