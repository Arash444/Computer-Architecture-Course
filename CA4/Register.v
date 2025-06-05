module Register(input clk, reg_write, input [15:0] data, output reg [15:0] out);
	always@(posedge clk)begin
		if(reg_write)
			out <= data;
		else
			out <= out;
	end
endmodule
