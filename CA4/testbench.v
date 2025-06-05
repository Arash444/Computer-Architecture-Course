module TB();
	reg clkk=0,initt=0;
	MIPS UUT(clkk,initt);
	always#10 clkk = ~clkk;
	initial begin
		#1 initt = 1;
		#1 initt = 0;
		#12850 $stop;
	end
endmodule