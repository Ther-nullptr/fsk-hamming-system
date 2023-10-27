module CodeSender(
  input clock,
  input reset,
  input [7:0] io_input,
  output reg io_output
);

  reg [2:0] clk_cnt;
  always @ (posedge clock) begin
    if (reset) begin
      io_output <= 0;
      clk_cnt <= 0;
    end
    else begin
      io_output <= io_input[7 - clk_cnt];
      if (clk_cnt < 3'h7) begin
        clk_cnt <= clk_cnt + 1;
      end
      else begin
        clk_cnt <= 0;
      end
    end
  end
endmodule