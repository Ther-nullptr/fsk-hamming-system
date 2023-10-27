module FSKDecoder(
  input   clock,
  input   reset,
  input   io_input,
  output  io_output
);
  reg  prev; // @[FSKDecoder.scala 12:21]
  reg [8:0] in_cnt; // @[FSKDecoder.scala 13:23]
  reg [11:0] clk_cnt; // @[FSKDecoder.scala 14:24]
  wire [8:0] _in_cnt_T_1 = in_cnt + 9'h1; // @[FSKDecoder.scala 17:22]
  wire  _GEN_1 = in_cnt < 9'h8 ? 1'h0 : 1'h1; // @[FSKDecoder.scala 20:24 21:17 23:17]
  wire [11:0] _clk_cnt_T_1 = clk_cnt + 12'h1; // @[FSKDecoder.scala 28:24]
  reg  io_output_REG; // @[FSKDecoder.scala 29:25]
  assign io_output = clk_cnt >= 12'h20 ? _GEN_1 : io_output_REG; // @[FSKDecoder.scala 19:25 29:15]
  always @(posedge clock) begin
    if (reset) begin // @[FSKDecoder.scala 12:21]
      prev <= 1'h0; // @[FSKDecoder.scala 12:21]
    end else begin
      prev <= io_input; // @[FSKDecoder.scala 31:8]
    end
    if (reset) begin // @[FSKDecoder.scala 13:23]
      in_cnt <= 9'h0; // @[FSKDecoder.scala 13:23]
    end else if (clk_cnt >= 12'h20) begin // @[FSKDecoder.scala 19:25]
      in_cnt <= 9'h0; // @[FSKDecoder.scala 26:12]
    end else if (~prev & io_input) begin // @[FSKDecoder.scala 16:42]
      in_cnt <= _in_cnt_T_1; // @[FSKDecoder.scala 17:12]
    end
    if (reset) begin // @[FSKDecoder.scala 14:24]
      clk_cnt <= 12'h0; // @[FSKDecoder.scala 14:24]
    end else if (clk_cnt >= 12'h20) begin // @[FSKDecoder.scala 19:25]
      clk_cnt <= 12'h0; // @[FSKDecoder.scala 25:13]
    end else begin
      clk_cnt <= _clk_cnt_T_1; // @[FSKDecoder.scala 28:13]
    end
    io_output_REG <= io_output; // @[FSKDecoder.scala 29:25]
  end
endmodule
