`timescale 1ns/1ns
module data_loader(adr,x,y);
	reg [19:0] memoryx [0:149];
	reg [19:0] memoryy [0:149];
	input [7:0] adr;
	output [19:0] x,y;
	initial begin
		$readmemb("x_value.txt", memoryx);
		$readmemb("y_value.txt", memoryy);
	end
	assign x = memoryx[adr];
	assign y = memoryy[adr];
endmodule