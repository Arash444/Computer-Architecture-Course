module CU(input [3:0] OPCcode, input clk, init, output reg wDataSrc, AluSrcB, memWrite, memRead, PCwrite, PCWriteCond, IRwrite, IorD, regWrite, move, output reg [1:0] PCsrc, AluSrcA, output reg [2:0] ALU_OP);
	parameter [4:0] load = 4'b0000, store = 4'b0001, jump = 4'b0010, branchZ = 4'b0100, rtl = 4'b1000, addi = 4'b1100, subi = 4'b1101, andi = 4'b1110, ori = 4'b1111;
	parameter [4:0] IF = 4'b0000, ID = 4'b0001, LOAD1 = 4'b0010, LOAD2 = 4'b0011, STORE = 4'b0100, JUMP = 4'b0101, BRANCHZ = 4'b0110, RTL1 = 4'b0111, RTL2 = 4'b1000, FUNCI = 4'b1001, SUBI = 4'b1010, ANDI = 4'b1011, ORI = 4'b1100;
	reg [4:0] pstate, nstate;
	always@(pstate, OPCcode) begin
		nstate = 4'b0000;
		ALU_OP = 3'b001;
		{wDataSrc, AluSrcB, memWrite, memRead, PCwrite, PCWriteCond, IRwrite, IorD, regWrite, move, PCsrc, AluSrcA} = 17'b0;
		case(pstate)
			IF: begin memRead = 1'b1; IorD = 1'b0; IRwrite = 1'b1; PCwrite = 1'b1; AluSrcB = 1'b1; AluSrcA = 2'b01; PCsrc = 2'b00; ALU_OP = 3'b001; nstate = ID; end
			ID: begin AluSrcB = 1'b0; AluSrcA = 2'b00; ALU_OP = 3'b001; 
				if(OPCcode == load)
					nstate = LOAD1;
				else if(OPCcode == store)
					nstate = STORE;
				else if(OPCcode == jump)
					nstate = JUMP;
				else if(OPCcode == branchZ)
					nstate = BRANCHZ;
				else if(OPCcode == rtl)
					nstate = RTL1;
				else if(OPCcode == addi)
					nstate = FUNCI;
				else if(OPCcode == subi)
					nstate = SUBI;
				else if(OPCcode == andi)
					nstate = ANDI;
				else if(OPCcode == ori)
					nstate = ORI;
				else 
					nstate = IF;
			    end
			LOAD1: begin memRead = 1'b1; IorD = 1'b1; nstate = LOAD2; end
			LOAD2: begin regWrite = 1'b1; move = 1'b0; wDataSrc = 1'b0; nstate = IF; end
			STORE: begin memWrite = 1'b1; IorD = 1'b1; nstate = IF; end
			JUMP: begin PCsrc = 2'b10; PCwrite = 1'b1; nstate = IF; end
			BRANCHZ: begin AluSrcB = 1'b0; AluSrcA = 2'b10; PCsrc = 2'b01; PCWriteCond = 1'b1; ALU_OP = 3'b010; nstate = IF; end
			RTL1: begin AluSrcB = 1'b0; AluSrcA = 2'b10; ALU_OP = 3'b000; nstate = RTL2; end
			RTL2: begin move = 1'b1; regWrite = 1'b1; wDataSrc = 1'b1; ALU_OP = 3'b000; nstate = IF; end
			FUNCI: begin move = 1'b0; regWrite = 1'b1; wDataSrc = 1'b1; nstate = IF; end
			SUBI: begin AluSrcB = 1'b0; AluSrcA = 2'b00; ALU_OP = 3'b010; nstate = FUNCI; end
			ANDI: begin AluSrcB = 1'b0; AluSrcA = 2'b00; ALU_OP = 3'b011; nstate = FUNCI; end
			ORI: begin AluSrcB = 1'b0; AluSrcA = 2'b00; ALU_OP = 3'b100; nstate = FUNCI; end
			default: nstate = IF;
		endcase
	end 
	always@(posedge clk or posedge init) begin
		if(init)
			pstate <= 4'b0000;
		else
			pstate <= nstate;
	end
endmodule
