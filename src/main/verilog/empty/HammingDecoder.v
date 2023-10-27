module HammingDecoder7to4(
  input        clock,
  input        reset,
  input  [7:0] io_input,
  output [3:0] io_output
);
  wire  error_code_0 = io_input[0] ^ io_input[2] ^ io_input[3] ^ io_input[4]; // @[HammingDecoder.scala 15:60]
  wire  error_code_1 = io_input[0] ^ io_input[1] ^ io_input[2] ^ io_input[5]; // @[HammingDecoder.scala 16:60]
  wire  error_code_2 = io_input[1] ^ io_input[2] ^ io_input[3] ^ io_input[6]; // @[HammingDecoder.scala 17:60]
  wire [2:0] _T = {error_code_2,error_code_1,error_code_0}; // @[HammingDecoder.scala 19:20]
  wire  _T_1 = _T == 3'h6; // @[HammingDecoder.scala 19:27]
  wire  _io_output_T_4 = ~io_input[0]; // @[HammingDecoder.scala 21:65]
  wire [3:0] _io_output_T_5 = {io_input[3],io_input[2],io_input[1],_io_output_T_4}; // @[Cat.scala 33:92]
  wire  _T_3 = _T == 3'h3; // @[HammingDecoder.scala 23:32]
  wire  _io_output_T_9 = ~io_input[1]; // @[HammingDecoder.scala 25:52]
  wire [3:0] _io_output_T_11 = {io_input[3],io_input[2],_io_output_T_9,io_input[0]}; // @[Cat.scala 33:92]
  wire  _T_5 = _T == 3'h7; // @[HammingDecoder.scala 27:32]
  wire  _io_output_T_14 = ~io_input[2]; // @[HammingDecoder.scala 29:39]
  wire [3:0] _io_output_T_17 = {io_input[3],_io_output_T_14,io_input[1],io_input[0]}; // @[Cat.scala 33:92]
  wire  _T_7 = _T == 3'h5; // @[HammingDecoder.scala 31:32]
  wire  _io_output_T_19 = ~io_input[3]; // @[HammingDecoder.scala 33:26]
  wire [3:0] _io_output_T_23 = {_io_output_T_19,io_input[2],io_input[1],io_input[0]}; // @[Cat.scala 33:92]
  wire [3:0] _io_output_T_28 = {io_input[3],io_input[2],io_input[1],io_input[0]}; // @[Cat.scala 33:92]
  wire [3:0] _GEN_0 = _T_7 ? _io_output_T_23 : _io_output_T_28; // @[HammingDecoder.scala 32:3 33:15 37:15]
  wire [3:0] _GEN_1 = _T_5 ? _io_output_T_17 : _GEN_0; // @[HammingDecoder.scala 28:3 29:15]
  wire [3:0] _GEN_2 = _T_3 ? _io_output_T_11 : _GEN_1; // @[HammingDecoder.scala 24:3 25:15]
  assign io_output = _T_1 ? _io_output_T_5 : _GEN_2; // @[HammingDecoder.scala 20:3 21:15]
endmodule
