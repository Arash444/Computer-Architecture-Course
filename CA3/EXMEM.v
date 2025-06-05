module EXMEM(input [31:0] ALU_Res, RegB_data, PC1, input [4:0] wReg, input clk, reg_write, mem_read, mem_write, mem_to_reg, write_pc_4, 
	output [31:0] ALU_ResO, RegB_dataO, PC1O, output [4:0] wRegO, output reg_writeO, mem_readO, mem_writeO, mem_to_regO, write_pc_4O);
	wire [31:0] ALU_Res2;
	Register#(1) REG_WRITE(clk, reg_write, reg_writeO);
	Register#(1) MEM_WRITE(clk, mem_write, mem_writeO);
	Register#(1) MEM_READ(clk, mem_read, mem_readO);
	Register#(1) MEM_TO_REG(clk, mem_to_reg, mem_to_regO);
	Register#(1) WRITE_PC_4(clk, write_pc_4, write_pc_4O);
	Register#(5) WREG(clk, wReg, wRegO);
	Register RPC1(clk, PC1, PC1O);
	NegRegister ALU_RES1(clk, ALU_Res, ALU_Res2);
	Register ALU_RES2(clk, ALU_Res2, ALU_ResO);
	Register REGB(clk, RegB_data, RegB_dataO);

endmodule	
