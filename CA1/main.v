`timescale 1ns/1ns
module main (input clk, reset, start, output [19:0] E, output Ready);
	wire ld_p, ld_ss, ld_B1, ld_B2, ld_er, mean_done, en1, en2;
	wire [19:0] X,Y;
	wire [19:0] b0,b1;
	wire [7:0] adrr;
	assign B0 = b0;
	assign B1 = b1;
	Controller C(clk,rst,start, ld_p, ld_ss, ld_B1, ld_B2, ld_er, mean_done, en1, en2, Ready, adrr);
	data_loader DL(adrr,X,Y);
	error_checker EC(X,Y,b0,b1, en2, ld_er, clk, reset, E);
	calculator_coefficient CC(X,Y, en1, ld_p ,ld_ss ,ld_B1 ,ld_B0 ,mean_done ,clk ,reset, b0,b1);
endmodule
	
