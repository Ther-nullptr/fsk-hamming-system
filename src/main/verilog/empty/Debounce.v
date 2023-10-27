`timescale 1ns / 1ps
// Engineer: Reborn Lee
// Module Name: debounce_1b


module Debounce(
	input clk, //50MHz
	input rst,
	input io_input,
	output reg io_output
);


	reg sw_mid_r1, sw_mid_r2, sw_valid;

	always@(posedge clk or posedge rst) begin
		if(rst) begin
			sw_mid_r1 <= 1; // synchronize 1 clock 
			sw_mid_r2 <= 1; // delay 1 clock
			sw_valid <= 0; // gen negedge
		end
		else begin
			sw_mid_r1 <= io_input;
			sw_mid_r2 <= sw_mid_r1;
			sw_valid <= sw_mid_r2 & (~sw_mid_r1);
		end
	end

	reg [19:0] key_cnt;

	always@(posedge clk or posedge rst) begin
		if(rst) begin
			key_cnt <= 0;
		end
		else if(sw_valid) begin
			key_cnt <= 0;
		end
		else begin
			key_cnt <= key_cnt + 1; //20ms
		end
	end

	always@(posedge clk or posedge rst) begin
		if(rst) begin
			io_output <= 1;
		end
		else if(key_cnt == 20'hffff) begin
			io_output <= io_input;
		end
	end

endmodule

