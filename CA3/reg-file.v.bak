module Regfile(input clk,reg_write, input [4:0] a_adr, b_adr, des_adr, input [31:0] w_data, output [31:0] a_out, b_out);
	reg [31:0] regfile [31:0];
	initial begin
		$readmemb("new_init.txt",regfile);
	end
	assign a_out = regfile[a_adr];
	assign b_out = regfile[b_adr];
	always@(posedge clk)begin
		if(reg_write)
			regfile[des_adr] <= w_data;
	end // always@(posedge clk)
endmodule