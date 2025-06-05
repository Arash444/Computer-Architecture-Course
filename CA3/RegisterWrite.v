module RegisterWrite (input clk, reg_write, flush, input [31:0] data, output reg [31:0] out);
	always@(posedge clk)begin
		if(flush)
			out <= 32'b10000000000000000000000000000000;
		else if(reg_write)
			out <= data;
		else
			out <= out;
	end
endmodule
