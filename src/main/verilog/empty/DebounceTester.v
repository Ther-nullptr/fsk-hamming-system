`include "Debounce.v"

module Debounce_tb();

  reg clk;
  reg reset;
  reg io_input;
  wire io_output;

  Debounce DUT (
    .clk(clk),
    .rst(reset),
    .io_input(io_input),
    .io_output(io_output)
  );

  initial begin
    // Initialize signals
    clk <= 0;
    io_input <= 0;
    reset <= 0;

    #1000 reset <= 1;
    #1000 reset <= 0;

    // Apply a test sequence
    #100000 io_input <= 1;
    #100000 io_input <= 0;
    #100000 io_input <= 1;

    // Simulate for a while
    #1000000;

    // Finish the simulation
    $finish;
  end

  always begin
    #5 clk <= ~clk;
  end

  initial begin
    // Monitor io_output
    $dumpfile("debounce_top.vcd");
    $display("Time = %0t, io_output = %b", $time, io_output);
  end

endmodule
