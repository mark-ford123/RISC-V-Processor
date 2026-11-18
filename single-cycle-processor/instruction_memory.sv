module instruction_memory(
	input  logic [31:0] PC,

	output logic [31:0] Instr
);

	logic [31:0] ram [63:0];

	initial $readmemh("program.hex", ram);

	always_comb begin		
		Instr = ram[PC[31:2]];
	end

endmodule