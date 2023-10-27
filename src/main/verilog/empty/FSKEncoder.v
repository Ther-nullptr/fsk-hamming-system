module FSKEncoder(
  input   clock,
  input   reset,
  input   io_input,
  output  io_output
);
  reg  carrier2; // @[FSKEncoder.scala 12:25]
  reg  carrier16; // @[FSKEncoder.scala 13:26]
  reg [3:0] cnt_carrier2; // @[FSKEncoder.scala 14:29]
  reg [3:0] cnt_carrier16; // @[FSKEncoder.scala 15:30]
  wire [3:0] _cnt_carrier2_T_1 = cnt_carrier2 + 4'h1; // @[FSKEncoder.scala 17:32]
  wire [3:0] _cnt_carrier16_T_1 = cnt_carrier16 + 4'h1; // @[FSKEncoder.scala 18:34]
  assign io_output = io_input ? carrier2 : carrier16; // @[FSKEncoder.scala 28:19]
  always @(posedge clock) begin
    if (reset) begin // @[FSKEncoder.scala 12:25]
      carrier2 <= 1'h0; // @[FSKEncoder.scala 12:25]
    end else if (cnt_carrier2 == 4'h1) begin // @[FSKEncoder.scala 19:30]
      carrier2 <= ~carrier2; // @[FSKEncoder.scala 20:14]
    end
    if (reset) begin // @[FSKEncoder.scala 13:26]
      carrier16 <= 1'h0; // @[FSKEncoder.scala 13:26]
    end else if (cnt_carrier16 == 4'hf) begin // @[FSKEncoder.scala 23:32]
      carrier16 <= ~carrier16; // @[FSKEncoder.scala 24:15]
    end
    if (reset) begin // @[FSKEncoder.scala 14:29]
      cnt_carrier2 <= 4'h0; // @[FSKEncoder.scala 14:29]
    end else if (cnt_carrier2 == 4'h1) begin // @[FSKEncoder.scala 19:30]
      cnt_carrier2 <= 4'h0; // @[FSKEncoder.scala 21:18]
    end else begin
      cnt_carrier2 <= _cnt_carrier2_T_1; // @[FSKEncoder.scala 17:16]
    end
    if (reset) begin // @[FSKEncoder.scala 15:30]
      cnt_carrier16 <= 4'h0; // @[FSKEncoder.scala 15:30]
    end else if (cnt_carrier16 == 4'hf) begin // @[FSKEncoder.scala 23:32]
      cnt_carrier16 <= 4'h0; // @[FSKEncoder.scala 25:19]
    end else begin
      cnt_carrier16 <= _cnt_carrier16_T_1; // @[FSKEncoder.scala 18:17]
    end
  end
endmodule
