module DATAMEM(input mem_write, mem_read, clk, input [9:0] adr, input [31:0] w_data, output reg [31:0] out);
	reg [31:0] datamem [1023:0];
	initial begin
		$readmemb("init.txt",datamem);
	end
	always@(posedge clk)begin
		if(mem_read)
			out <= datamem[adr];
		if(mem_write)
			datamem[adr] <= w_data;
	end // always@(posedge clk)
endmodule