module PC(input clk, input [9:0] adr, output reg [9:0] out);

	always @(posedge clk) begin
		out <=adr ;
	end
endmodule // PC