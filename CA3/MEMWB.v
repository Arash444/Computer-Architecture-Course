module MEMWB(input [31:0] ALU_Res, RegB_data, PC1, Mem_Data, input [4:0] wReg, input clk, reg_write, mem_to_reg, write_pc_4, 
	output [31:0] ALU_ResO, RegB_dataO, PC1O, Mem_DataO, output [4:0] wRegO, output reg_writeO, mem_to_regO, write_pc_4O);

	NegRegister#(1) REG_WRITE(clk, reg_write, reg_writeO);
	NegRegister#(1) MEM_TO_REG(clk, mem_to_reg, mem_to_regO);
	NegRegister#(1) WRITE_PC_4(clk, write_pc_4, write_pc_4O);
	NegRegister#(5) WREG(clk, wReg, wRegO);
	NegRegister RPC1(clk, PC1, PC1O);
	NegRegister ALU_RES(clk, ALU_Res, ALU_ResO);
	NegRegister REGB(clk, RegB_data, RegB_dataO);
	NegRegister MEM_DATA(clk, Mem_Data, Mem_DataO);

endmodule	
