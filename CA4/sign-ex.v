module signex (input [11:0] a, output [15:0] b);
	assign b = {{4{a[11]}}, a};
endmodule