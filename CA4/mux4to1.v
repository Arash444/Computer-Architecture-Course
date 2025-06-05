module mux4to1#(parameter size = 16)(input [1:0] Command, input [size-1:0] a, b, c, d, output [size-1:0] w);
	wire [size-1:0] mux1, mux2;
	mux2to1#(size) Mux1(Command[0], a, b, mux1);
	mux2to1#(size) Mux2(Command[0], c, d, mux2);
	mux2to1#(size) Mux3(Command[1], mux1, mux2, w);
endmodule 