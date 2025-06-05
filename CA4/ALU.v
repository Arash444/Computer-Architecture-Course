module ALU(input [15:0] A,B,input [2:0] ALU_opc, output Zero, output reg [15:0]Result);
	always@(A,B,ALU_opc) begin
		Result = 0;
		case(ALU_opc)
		3'b000:begin
			Result = B;
		end
		3'b001:begin
			Result = A;
		end
		3'b010:begin
			Result = A + B;
		end
		3'b011:begin
			Result = B - A;
		end
		3'b100:begin
			Result = A & B;
		end
		3'b101:begin
			Result = A | B;
		end
		3'b110:begin
			Result = ~A;
		end
		3'b111:begin
			Result = Result;
		end
	endcase
	end
	assign Zero = ~|Result;
endmodule