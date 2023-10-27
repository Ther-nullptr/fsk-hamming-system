module ClockGenerator(
  input sysclk, 
  input reset, 
  output reg clk
); 

	reg [5:0] count;
	always @ (posedge sysclk) begin
		if (reset) begin
			count <= 0;
			clk <= 0;
		end
		else begin
			if (count == 6'b100000) begin
				clk <= ~clk;
				count <= 0;
			end
			else
				count <= count + 1;
		end
	end

endmodule