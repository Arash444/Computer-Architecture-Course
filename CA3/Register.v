module Register#(parameter size = 32)(input clk, input [size-1:0] data, output reg [size-1:0] out);
	always@(posedge clk)begin
		out <= data;
	end
endmodule
