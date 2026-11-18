module main_decoder(
	input  logic [6:0]  op,
	
	output logic 	    RegWrite,
	output logic [1:0]  ImmSrc,
	output logic 	    ALUSrc,
	output logic	    MemWrite,
	output logic        ResultSrc, // 0 for R-Type Instructons; 1 for lw to choose ReadData
	output logic 	    Branch,
	output logic [1:0]  ALUop
);

	always_comb begin
		case(op)
			7'b0000011: begin  // lw
			RegWrite  = 1'b1;
			ImmSrc    = 2'b00;
			ALUSrc    = 1'b1;
			MemWrite  = 1'b0;
			ResultSrc = 1'b1;
			Branch 	  = 1'b0;
			ALUop     = 2'b00; 
			end

			7'b0100011: begin  //sw
			RegWrite  = 1'b0;
			ImmSrc    = 2'b01;
			ALUSrc    = 1'b1;
			MemWrite  = 1'b1;
			ResultSrc = 1'b0;  // x (don't care)
			Branch 	  = 1'b0;
			ALUop     = 2'b00; 
			end

			7'b0110011: begin  // R-Type
			RegWrite  = 1'b1;
			ImmSrc    = 2'b00; // x (don't care)
			ALUSrc    = 1'b0;
			MemWrite  = 1'b0;
			ResultSrc = 1'b0;
			Branch 	  = 1'b0;
			ALUop     = 2'b10; 
			end

			7'b1100011: begin  // beq
			RegWrite  = 1'b0;
			ImmSrc    = 2'b10;
			ALUSrc    = 1'b0;
			MemWrite  = 1'b0;
			ResultSrc = 1'b0;  // x (don't care) 
			Branch 	  = 1'b1;
			ALUop     = 2'b01; 
			end

			7'b0010011: begin  // addi (I-type arithmetic)
    			RegWrite  = 1'b1;
    			ImmSrc    = 2'b00; // I-type immediate
    			ALUSrc    = 1'b1;  // Use immediate as ALU source B
    			MemWrite  = 1'b0;
    			ResultSrc = 1'b0;  // ALU result
    			Branch    = 1'b0;
    			ALUop     = 2'b10; // Same as R-type so ALU decoder reads funct3
			end

			default: begin
			RegWrite  = 1'b0;
        		ImmSrc    = 2'b00;
        		ALUSrc    = 1'b0;
        		MemWrite  = 1'b0;
        		ResultSrc = 1'b0;
        		Branch    = 1'b0;
        		ALUop     = 2'b00;
			end
		endcase
	end

endmodule
