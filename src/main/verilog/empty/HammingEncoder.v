module HammingEncoder4to7(
  input        clock,
  input        reset,
  input  [3:0] io_input,
  output [7:0] io_output
);
  wire  _p1_T_2 = io_input[3] ^ io_input[2]; // @[HammingEncoder.scala 14:24]
  wire  p1 = io_input[3] ^ io_input[2] ^ io_input[0]; // @[HammingEncoder.scala 14:38]
  wire  p2 = io_input[2] ^ io_input[1] ^ io_input[0]; // @[HammingEncoder.scala 15:38]
  wire  p3 = _p1_T_2 ^ io_input[1]; // @[HammingEncoder.scala 16:38]
  wire [3:0] io_output_lo = {io_input[3],io_input[2],io_input[1],io_input[0]}; // @[Cat.scala 33:92]
  wire [3:0] io_output_hi = {1'h1,p3,p2,p1}; // @[Cat.scala 33:92]
  assign io_output = {io_output_hi,io_output_lo}; // @[Cat.scala 33:92]
endmodule
