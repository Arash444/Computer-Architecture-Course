module equal(input [31:0] A,B, output w);
	wire [31:0] Result;
	assign Result = A - B;
	assign w = ~| Result;
endmodule

	/*wire [31:0] Xnor;
	XNOR XNORE(a,b,Xnor);
	assign w = ~| Xnor;*/