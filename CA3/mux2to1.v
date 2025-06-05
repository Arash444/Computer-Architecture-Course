module mux#(parameter size = 32)(input Command, input [size-1:0] a, b, output [size-1:0] w);
	assign w = Command ? a : b;
endmodule