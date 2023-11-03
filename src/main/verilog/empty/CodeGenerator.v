module CodeGenerator(
	input reset, 
	output [3:0] code
);
  reg [3:0] clk_cnt = 4'b0000;
  always @ (posedge reset) begin
    clk_cnt <= clk_cnt + 4'b1101;
  end
  assign code = clk_cnt;
endmodule