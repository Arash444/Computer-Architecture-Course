module datapath(input clk, init, reg_dstI, r31I, reg_writeI, alu_srcI, mem_readI, mem_writeI, mem_to_regI, write_pc_4I, branchI, adr_r31I, jumpI, input [2:0] ALU_opcI, output [31:0] Inst);
	wire [31:0] RegA_data, RegB_data, wdata1, wdata, ALU_Res, data_extend16, data_extend26, Mem_Data, beqL, B_ALU1, B_ALU2, A_ALU;
	wire [31:0] RegA_dataO, RegB_dataO, Mem_DataO, ALU_ResO, data_extend16O, RegB_dataO2, ALU_ResO2, RegB_dataO3;
	wire [31:0] PCin, PCbeq, PC1I, PC1, PC1O, PC1O2, PC1O3, adress, InstTemp;
	wire [9:0] PCout;
	wire [4:0] Rs, Rt, Rd, RsO, RtO, RdO, wReg1, wReg, wRegO, wRegO2;
	wire [2:0] ALU_opc, ALU_opcO;
	wire [1:0] ForwardA, ForwardB;
	wire Zero, beq, PCsrc, PCwrite, EQ, IFIDwrite, Controller_Flush, IFID_flush, IFID_flush_Temp;
	wire reg_dst, r31, reg_write, alu_src, mem_read, mem_write, mem_to_reg, write_pc_4, branch, adr_r31, jump;
	wire reg_dstO, r31O, reg_writeO, alu_srcO, mem_readO, mem_writeO, mem_to_regO, write_pc_4O, reg_writeO2, mem_readO2, mem_writeO2, mem_to_regO2, write_pc_4O2, reg_writeO3, mem_to_regO3, write_pc_4O3;

	PC ourPC(clk, init, PCwrite, PCin[9:0], PCout);
	adder APC1({{22{1'b0}},PCout}, 32'd1, PC1I);
	INSMEM ourINSMEM(clk, PCout, InstTemp);
	And andBeq(EQ, branch, beq);
	Or PCSRC(jump,beq, PCsrc);
	Or FLUSH(PCsrc,adr_r31, IFID_flush_Temp);
	mux PCBEQ(PCsrc, beqL, PC1I, PCbeq);
	mux PCr31(adr_r31, RegA_data, PCbeq, PCin);

	IFID IFID1(PC1I, InstTemp, IFIDwrite, IFID_flush, clk, PC1, Inst);

	Hazzard HAU(RtO, Rs, Rt, mem_readO, init, IFID_flush_Temp, PCwrite, IFIDwrite, Controller_Flush, IFID_flush);
	SuperMux SPC(Controller_Flush, reg_dstI, r31I, reg_writeI, alu_srcI, mem_readI, mem_writeI, mem_to_regI, write_pc_4I, branchI, adr_r31I, jumpI, ALU_opcI, 
	reg_dst, r31, reg_write, alu_src, mem_read, mem_write, mem_to_reg, write_pc_4, branch, adr_r31, jump, ALU_opc);
	shifter ourShifter(adress, beqL);
	signex#(16) SIX16(Inst[15:0], data_extend16);
	signex SIX26(Inst[25:0], data_extend26);
	mux SIGN(jump, data_extend26, data_extend16, adress);
	Regfile ourRegfile(clk,reg_writeO3, Rs, Rt, wRegO2 , wdata, RegA_data, RegB_data);
	equal EQU(RegA_data, RegB_data, EQ);
	assign Rs = Inst[25:21];
	assign Rt = Inst[20:16];
	assign Rd = Inst[15:11];

	IDEX IDEX1(RegA_data, RegB_data, PC1, data_extend16, Rs, Rt, Rd, ALU_opc, clk, reg_dst, r31, reg_write, alu_src, mem_read, mem_write, mem_to_reg, write_pc_4, 
	RegA_dataO, RegB_dataO, PC1O, data_extend16O, RsO, RtO, RdO, ALU_opcO, reg_dstO, r31O, reg_writeO, alu_srcO, mem_readO, mem_writeO, mem_to_regO, write_pc_4O);

	FWU FWUA(RsO, wRegO, wRegO2, reg_writeO2, reg_writeO3, ForwardA);
	FWU FWUB(RtO, wRegO, wRegO2, reg_writeO2, reg_writeO3, ForwardB);
	mux BALU1(alu_srcO, data_extend16O, RegB_dataO, B_ALU1);
	mux4to1 BALU2(ForwardB, B_ALU1, wdata, ALU_ResO, 32'bz, B_ALU2);
	mux4to1 AALU(ForwardA, RegA_dataO, wdata, ALU_ResO, 32'bz, A_ALU);
	ALU ourALU(A_ALU, B_ALU2, ALU_opcO, Zero, ALU_Res);
	mux#(5) WR1(reg_dstO, RdO, RtO, wReg1);
	mux#(5) WR2(r31O, 5'b11111, wReg1, wReg);

 	EXMEM EXMEM1(ALU_Res, RegB_dataO, PC1O, wReg, clk, reg_writeO, mem_readO, mem_writeO, mem_to_regO, write_pc_4O, 
	ALU_ResO, RegB_dataO2, PC1O2, wRegO, reg_writeO2, mem_readO2, mem_writeO2, mem_to_regO2, write_pc_4O2);

	DATAMEM ourDATAMEM(mem_writeO2, mem_readO2, clk, ALU_ResO[9:0], RegB_dataO2, Mem_Data);

	MEMWB MEMWB1(ALU_ResO, RegB_dataO2, PC1O2, Mem_Data, wRegO, clk, reg_writeO2, mem_to_regO2, write_pc_4O2,
	ALU_ResO2, RegB_dataO3, PC1O3, Mem_DataO, wRegO2, reg_writeO3, mem_to_regO3, write_pc_4O3);

	mux WD1(mem_to_regO3, Mem_DataO, ALU_ResO2, wdata1);
	mux WD2(write_pc_4O3, PC1O3, wdata1, wdata);
	
	
endmodule