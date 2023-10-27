`timescale 1ns/1ps
`include "CommunicationSystem.v"

module tb_top;
	reg sysclk;
	reg reset;
	wire [3:0] result;

	CommunicationSystem communicationSystem(
    .sys_clock(sysclk),
    .reset_original(reset),
    .io_output(result)
  );

	initial begin
		#0 sysclk<=0;
		#0 reset<=0;
		#101 reset<=1;
		#151 reset<=0;
		#50101 reset<=1;
    #50151 reset<=0;
    #100101 reset<=1;
    #100151 reset<=0;
	end

	// Clock generation
	always begin
		#5 sysclk = ~sysclk;
	end

	initial begin
		$dumpfile("tb_top.vcd");
		$dumpvars(0, tb_top);
		$display("time\tresult");
		$monitor("%d\t%b", $time, result);
		#1000000 $finish;
	end

endmodule