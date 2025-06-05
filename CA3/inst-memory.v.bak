module INSMEM(input clk, input [9:0]adr, output [31:0]ins);
	reg [31:0] memory[1023:0];
	reg [31:0] inss;
	initial begin
		$readmemb("instructions.txt",memory);
	end
	//always@(posedge clk) begin
		//inss <= memory[adr];
	//end // always@(posedge clk)
	assign ins = memory[adr];
endmodule // INSMEM
			
