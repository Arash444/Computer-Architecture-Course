module ALU(input [31:0] A,B,input [2:0] ALU_opc, output Zero, output reg [31:0]Result);
	always@(A,B,ALU_opc) begin
		Result = 0;
		case(ALU_opc)
		3'b000:begin
			Result = A&B;
		end
		3'b001:begin
			Result = A|B;
		end
		3'b010:begin
			Result = A + B;
		end
		3'b011:begin
			Result = A - B;
		end
		3'b100:begin
			Result = (A<B)?1'b1:1'b0;
		end
	endcase
	end
	assign Zero = ~|Result;
endmodule