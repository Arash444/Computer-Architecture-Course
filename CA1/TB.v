`timescale 1ns/1ns
module TB();
	wire readyy;
	wire [19:0] error;
	reg startt=0, clkk=0, rst=0;
	main UUT(clkk, rst, startt, error, readyy);
	always #5 clkk <= ~clkk;
	initial begin
		#10 rst = 1;
		#9 rst = 0;
		#10 startt = 1;
		#10 startt = 0;
		#5000 $stop;
	end

endmodule
		
