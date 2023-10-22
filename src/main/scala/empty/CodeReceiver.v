module CodeReceiver
(
  input        clock,
  input        reset,
  input        io_input,
  output reg [7:0] io_output
);
  reg countReg;
  reg [7:0] dataReg;
  reg dataFull;

  // initialize
  initial begin
    countReg <= 3'h0;
    dataReg <= 8'h00;
    dataFull <= 1'b0;
  end

  always (posedge clock or negedge reset) begin
    if (~reset) begin
      countReg <= 3'h0;
      dataReg <= 8'h00;
      dataFull <= 1'b0;
    end
    else begin
      if (dataFull) begin 
        io_output <= dataReg;
        if (io_input) begin
		      dataFull <= 0;
        end
      end
      else begin
      countReg <= countReg + 1;
      if (countReg < 3'h7) begin
        dataReg <= (dataReg << 1);
        dataReg[0] <= io_input;
        dataFull <= 0;
      end
      else begin
        countReg <= 3'h0;
        io_output <= dataReg;
        dataFull <= 1;
      end
      end
    end
  end
endmodule