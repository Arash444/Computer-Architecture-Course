module IFID(input [31:0] PC1, InstTemp, input IFIDwrite, IF_flush, clk, output [31:0] PC1O, Inst);

	RegisterWrite RPC1(clk, IFIDwrite, 1'b0, PC1, PC1O);
	RegisterWrite TEMPINST(clk, IFIDwrite, IF_flush, InstTemp, Inst);

endmodule	
