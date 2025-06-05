module shifter(input [31:0]a, output [31:0] b);
	assign b = {a[30:0], 1'b0};
endmodule // shifter