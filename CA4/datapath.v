module datapath(input clk, init, wDataSrc, AluSrcB, memWrite, memRead, PCwrite, PCWriteCond, IRwrite, IorD, regWrite, regWriteALU, move, moveALU, input [1:0] PCsrc, AluSrcA, input [2:0] ALU_opc, output [15:0] Inst);
	wire [15:0] wData, RRegA, RReg0, RegA, Reg0, MemData, MDRdata, A_ALU, B_ALU, ALU_Res, ALU_out, data_extend16;
	wire [11:0] PCin, PCout, adr;
	wire [2:0] wDataReg;
	wire Zero, branch, PCwriteF, regWriteF, moveF;

	mux4to1#(12) MuxPC(PCsrc, ALU_Res[11:0], {PCout[11:9], Inst[8:0]} , Inst[11:0], 12'bx, PCin);
	And Branch(Zero,PCWriteCond, branch); 
	Or Write(PCwrite,branch, PCwriteF); 
	PC ourPC(clk, init, PCwriteF, PCin, PCout);
	
	mux2to1#(12) MuxIorD(IorD, PCout, Inst[11:0], adr);
	Memory ourMemory(memWrite, memRead, clk, adr, Reg0, MemData);
	Register IR(clk, IRwrite, MemData, Inst);
	Register MDR(clk, 1'b1, MemData, MDRdata);

	And RegWrite(regWrite,regWriteALU, regWriteF); 
	And Move(move,moveALU, moveF); 
	mux2to1#(3) MuxMove(moveF, 3'b0, Inst[11:9], wDataReg);
	mux2to1 MuxData(wDataSrc, MDRdata, ALU_out, wData);
	Regfile ourRegfile(clk,regWriteF, Inst[11:9], 3'b0, wDataReg, wData, RRegA, RReg0);

	Register RegisterA(clk, 1'b1, RRegA, RegA);
	Register Register0(clk, 1'b1, RReg0, Reg0);

	signex SIX16(Inst[11:0], data_extend16);
	mux4to1 ALUA(AluSrcA, data_extend16, {4'b0000, PCout}, RegA, 16'bx, A_ALU);
	mux2to1 ALUB(AluSrcB, Reg0, 16'd1, B_ALU);
	ALU ourALU(A_ALU, B_ALU, ALU_opc, Zero, ALU_Res);
	Register ALUout(clk, 1'b1, ALU_Res, ALU_out);
endmodule