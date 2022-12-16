module beu #(
  // FPU configuration
  localparam int unsigned WIDTH = 24,
  localparam int unsigned CONTROL_BITS = 4)
 (
  input  logic [WIDTH - 1:0]               Yin, //24 bits
  output logic [CONTROL_BITS - 1:0]   control1, 
  output logic [CONTROL_BITS - 1:0]   control2, 
  output logic [CONTROL_BITS - 1:0]   control3, 
  output logic [CONTROL_BITS - 1:0]   control4,
  output logic [CONTROL_BITS - 1:0]   control5,
  output logic [CONTROL_BITS - 1:0]   control6,
  output logic [CONTROL_BITS - 1:0]   control7,
  output logic [CONTROL_BITS - 1:0]   control8 
  );


  logic [CONTROL_BITS-1:0] Y_4bits1;
  logic [CONTROL_BITS-1:0] Y_4bits2;
  logic [CONTROL_BITS-1:0] Y_4bits3;
  logic [CONTROL_BITS-1:0] Y_4bits4;
  logic [CONTROL_BITS-1:0] Y_4bits5;
  logic [CONTROL_BITS-1:0] Y_4bits6;
  logic [CONTROL_BITS-1:0] Y_4bits7;
  logic [CONTROL_BITS-1:0] Y_4bits8;

  assign Y_4bits1 = {Yin[2:0], 1'b0};
  assign Y_4bits2 = Yin[5:2];
  assign Y_4bits3 = Yin[8:5];
  assign Y_4bits4 = Yin[11:8];
  assign Y_4bits5 = Yin[14:11];
  assign Y_4bits6 = Yin[17:14];
  assign Y_4bits7 = Yin[20:17];
  assign Y_4bits8 = Yin[23:20];


  be #()
   be1 (
    .Y_4bits( Y_4bits1 ),
    .control( control1 )
    );

  be #()
   be2 (
    .Y_4bits( Y_4bits2 ),
    .control( control2 )
    );
    
  be #()
   be3 (
    .Y_4bits( Y_4bits3 ),
    .control( control3 )
    );

  be #()
   be4 (
    .Y_4bits( Y_4bits4 ),
    .control( control4 )
    );

  be #()
   be5 (
    .Y_4bits( Y_4bits5 ),
    .control( control5 )
    );

  be #()
   be6 (
    .Y_4bits( Y_4bits6 ),
    .control( control6 )
    );

  be #()
   be7 (
    .Y_4bits( Y_4bits7 ),
    .control( control7 )
    );

  be #()
   be8 (
    .Y_4bits( Y_4bits8 ),
    .control( control8 )
    );
endmodule