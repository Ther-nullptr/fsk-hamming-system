`include "ClockGenerator.v"
`include "CodeGenerator.v"
`include "CodeSender.v"
`include "CodeReceiver.v"
`include "FSKEncoder.v"
`include "FSKDecoder.v"
`include "HammingEncoder.v"
`include "HammingDecoder.v"
`include "Debounce.v"

module CommunicationSystem(
  input        sys_clock,
  input        reset_original,
  output [3:0] io_output
);
  wire [3:0] hammingEncoder_io_input; // @[CommunicationSystem.scala 15:30]
  wire [7:0] hammingEncoder_io_output; // @[CommunicationSystem.scala 15:30]
  wire  codeSender_clock; // @[CommunicationSystem.scala 17:26]
  wire  codeSender_reset; // @[CommunicationSystem.scala 17:26]
  wire [7:0] codeSender_io_input; // @[CommunicationSystem.scala 17:26]
  wire  codeSender_io_output; // @[CommunicationSystem.scala 17:26]
  wire  codeReceiver_clock; // @[CommunicationSystem.scala 20:28]
  wire  codeReceiver_reset; // @[CommunicationSystem.scala 20:28]
  wire  codeReceiver_io_input; // @[CommunicationSystem.scala 20:28]
  wire [7:0] codeReceiver_io_output; // @[CommunicationSystem.scala 20:28]
  wire [7:0] hammingDecoder_io_input; // @[CommunicationSystem.scala 21:30]
  wire [3:0] hammingDecoder_io_output; // @[CommunicationSystem.scala 21:30]
  wire reset;
  assign reset = reset_original;

  // Debounce debounce(
  //   .clk(sys_clock),
  //   .io_input(reset_original),
  //   .io_output(reset)
  // );
  
  CodeGenerator codeGenerator(
    .reset(reset),
    .code(hammingEncoder_io_input)
  );
  ClockGenerator clockGenerator(
    .sysclk(sys_clock),
    .reset(reset),
    .clk(clock)
  );

  HammingEncoder4to7 hammingEncoder ( // @[CommunicationSystem.scala 15:30]
    .io_input(hammingEncoder_io_input),
    .io_output(hammingEncoder_io_output)
  );
  CodeSender codeSender ( // @[CommunicationSystem.scala 17:26]
    .clock(codeSender_clock),
    .reset(codeSender_reset),
    .io_input(codeSender_io_input),
    .io_output(codeSender_io_output)
  );
  FSKEncoder fskEncoder (
    .clock(sys_clock),
    .reset(codeSender_reset),
    .io_input(fskEncoder_io_input),
    .io_output(fskEncoder_io_output)
  );
  FSKDecoder fskDecoder (
    .clock(sys_clock),
    .reset(codeReceiver_reset),
    .io_input(fskDecoder_io_input),
    .io_output(fskDecoder_io_output)
  );
  CodeReceiver codeReceiver ( // @[CommunicationSystem.scala 20:28]
    .clock(codeReceiver_clock),
    .reset(codeReceiver_reset),
    .io_input(codeReceiver_io_input),
    .io_output(codeReceiver_io_output)
  );
  HammingDecoder7to4 hammingDecoder ( // @[CommunicationSystem.scala 21:30]
    .io_input(hammingDecoder_io_input),
    .io_output(hammingDecoder_io_output)
  );
  assign io_output = hammingDecoder_io_output; // @[CommunicationSystem.scala 32:13]
  // assign hammingEncoder_io_input = io_input; // @[CommunicationSystem.scala 23:27]
  assign codeSender_clock = clock;
  assign codeSender_reset = reset;
  assign codeSender_io_input = hammingEncoder_io_output; // @[CommunicationSystem.scala 27:23]
  assign fskEncoder_io_input = codeSender_io_output;
  assign fskDecoder_io_input = fskEncoder_io_output;
  assign codeReceiver_io_input = fskDecoder_io_output;
  assign codeReceiver_clock = clock;
  assign codeReceiver_reset = reset;
  assign hammingDecoder_io_input = codeReceiver_io_output; // @[CommunicationSystem.scala 31:27]
endmodule
