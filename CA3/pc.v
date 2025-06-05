module PC(input clk, init, PCwrite, input [9:0] pc, output reg [9:0] out);
	always @(posedge clk or posedge init) begin
		if(init)
			out <= 10'd0;
		else if (PCwrite)
			out <= pc;
		else
			out <= out;
	end
endmodule