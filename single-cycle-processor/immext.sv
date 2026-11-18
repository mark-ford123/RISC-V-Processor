module imm_ext(
	input  logic [31:0] Instr,
	input  logic [1:0]  ImmSrc,
	
	output logic [31:0] immext
);

	always_comb begin
		case(ImmSrc)
			2'b00: immext = {{20{Instr[31]}}, Instr[31:20]};				   // I-Type Instruction (12-bit signed immediate)

			2'b01: immext = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};			   // S-Type Instruction (12-bit signed immediate)

			2'b10: immext = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};	   // B-Type Instruction (13-bit signed immediate)

			2'b11: immext = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};	   // J-Type Instruction (21-bit signed immediate)
		endcase

	end

endmodule
