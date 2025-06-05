module mux2to1#(parameter size = 16)(input Command, input [size-1:0] a, b, output [size-1:0] w);
	assign w = Command ? b : a;
endmodule 