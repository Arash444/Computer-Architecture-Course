module PC(input clk, init, PCwrite, input [11:0] pc, output reg [11:0] out);
	always @(posedge clk or posedge init) begin
		if(init) 
			out <= 12'd256;
		else if (PCwrite)
			out <= pc;
		else
			out <= out;
	end
endmodule