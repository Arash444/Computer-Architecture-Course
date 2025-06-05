module mux4to1 (input [1:0] Command, input [31:0] a, b, c, d, output [31:0] w);
	wire [31:0] mux1, mux2;
	mux Mux1(Command[0], b, a, mux1);
	mux Mux2(Command[0], d, c, mux2);
	mux Mux3(Command[1], mux2, mux1, w);
endmodule
