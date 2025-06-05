module signex#(parameter size = 26) (input [size-1:0] a, output [31:0] b);
	assign b = {{size{a[size-1]}}, a};
endmodule 