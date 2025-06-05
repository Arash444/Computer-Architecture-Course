module Memory(input mem_write, mem_read, clk, input [11:0] adr, input [15:0] w_data, output reg [15:0] out);
	reg [15:0] memory [4095:0];
	wire [15:0] out_temp;
	initial begin
		$readmemb("init.txt",memory);
	end
	assign out = mem_read ? memory[adr] : 16'bx;
	always@(posedge clk)begin
		if(mem_write)
			memory[adr] <= w_data;
	end
endmodule
			