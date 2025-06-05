module PC(input clk, init, input [9:0] adr, output reg [9:0] out);
	always @(posedge clk or posedge init) begin
		if(init) 
			out <= 0;
		 else 
			out <=adr ;
		
	end
endmodule // PC