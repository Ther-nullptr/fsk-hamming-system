`timescale 1ns/1ns

`include "../../../main/verilog/empty/CodeReceiver.v"

module CodeReceiver_tb;

  // Inputs
  reg clock;
  reg reset;
  reg io_input;

  // Outputs
  wire [7:0] io_output;

  // Instantiate the CodeReceiver module
  CodeReceiver uut (
    .clock(clock),
    .reset(reset),
    .io_input(io_input),
    .io_output(io_output)
  );

  // Clock generation
  always begin
    #5 clock = ~clock;
  end

  // Initial values
  initial begin
    clock = 1;
    reset = 0;
    io_input = 0;

    // Reset the CodeReceiver module
    reset = 1;
    #10 reset = 0;

    // Stimulus generation
    // 1,0,0,1,0,1,0,1
    // 1,0,1,0,0,1,1,1
    // 1,0,0,1,0,1,0,1
    io_input = 1;
    #10 io_input = 0;
    #10 io_input = 0;
    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 0;
    #10 io_input = 0;

    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 0;
    #10 io_input = 1;
    #10 io_input = 1;
    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 0;
    #10 io_input = 0;

    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 0;
    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 1;
    #10 io_input = 0;
    #10 io_input = 1;

    // Finish the simulation
    #50 $finish;
  end

  // Simulate the testbench
  initial begin
    $dumpfile("CodeReceiver_tb.vcd");
    $dumpvars(0, CodeReceiver_tb);
    $display("Starting simulation...");
    $monitor("io_output = %b", io_output);
    $display("");
    $display("Simulation results:");
    $display("-------------------");
    $display("");

    // Run the simulation for some time
    #3000;

    $display("");
    $display("Simulation finished.");
    $display("Exiting simulation...");
    $finish;
  end

endmodule