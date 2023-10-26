module CodeReceiver
(
  input        clock,
  input        reset,
  input        io_input,
  output reg [7:0] io_output
);
  reg [2:0] countReg;
  reg [7:0] dataReg;
  reg [7:0] dataRegBuffer; // to store the value when in the process of receiving
  reg dataFull;

  // initialize
  initial begin
    countReg <= 3'h0;
    dataReg <= 8'h00;
    dataRegBuffer <= 8'h00;
    dataFull <= 1'b1;
  end

  always @(posedge clock) begin
    if (reset) begin
      countReg <= 3'h0;
      dataReg <= 8'h00;
      dataRegBuffer <= 8'h00;
      dataFull <= 1'b1;
    end
    else begin
      if (dataFull) begin 
        io_output <= dataRegBuffer; // maintain the current state
        if (io_input) begin // detect the start bit, jump directly to the receiving state
		  dataFull <= 0;
          dataReg <= 8'h00;
        end
      end
      else begin
      countReg <= countReg + 1;
      if (countReg < 3'h7) begin
        dataReg <= (dataReg << 1);
        dataReg[0] <= io_input;
        dataFull <= 0;
        io_output <= dataRegBuffer;
      end
      else begin
        countReg <= 3'h0; // the data is full
        io_output <= dataReg;
        dataRegBuffer <= dataReg;
        if (io_input) begin // detect the start bit, jump directly to the receiving state
		  dataFull <= 0;
          dataReg <= 8'h00;
        end
        else begin // maintain the current state
          dataFull <= 1;
        end
      end
      end
    end
  end
endmodule