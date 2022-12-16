module be #(
  localparam int unsigned CONTROL_BITS = 4)
 (
  input  logic [CONTROL_BITS - 1:0]   Y_4bits, //4 bits
  output logic [CONTROL_BITS - 1:0]   control, 
  );

//Y(3i-1)  -->  Y_4bits[0]  
//Y(3i)    -->  Y_4bits[1]
//Y(3i+1)  -->  Y_4bits[2]
//Y(3i+2)  -->  Y_4bits[3]

assign  control[0] = ~((Y_4bits[0] ~^ Y_4bits[1]) & (~(Y_4bits[2] ~^ Y_4bits[3])))                                 //ai
assign  control[1] = ~((~(Y_4bits[0] ~^ Y_4bits[1])) & (Y_4bits[1] ~^ Y_4bits[2]))                                 //bi
assign  control[2] = ~((Y_4bits[0] ~^ Y_4bits[1]) & (Y_4bits[2] ~^ Y_4bits[3]))                                    //ci
assign  control[3] = ~((~(Y_4bits[0] ~^ Y_4bits[1])) & (~(Y_4bits[2] ~^ Y_4bits[3])) & (Y_4bits[2] ~^ Y_4bits[3])) //di

endmodule