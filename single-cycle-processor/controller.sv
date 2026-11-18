module controller(
	input  logic [6:0]  op,
	input  logic [2:0]  funct3,
	input  logic 	    funct7,
	input  logic        zero,

	output logic 	    RegWrite,
	output logic [1:0]  ImmSrc,
	output logic 	    ALUSrc,
	output logic	    MemWrite,
	output logic        ResultSrc,
	output logic 	    Branch,
	output logic [2:0]  ALUControl
);

	// Declare internal input signals
	logic [1:0] ALUop;

	logic [1:0] op_funct7;
	assign op_funct7 = {op[5], funct7};

	main_decoder md(
		.op(op),
		.RegWrite(RegWrite),
        	.ImmSrc(ImmSrc),
        	.ALUSrc(ALUSrc),
        	.MemWrite(MemWrite),
        	.ResultSrc(ResultSrc),
        	.Branch(Branch),
        	.ALUop(ALUop)
	);

	alu_decoder ad(
		.ALUop(ALUop),
		.funct3(funct3),
		.op_funct7(op_funct7),
		.ALUControl(ALUControl)
	);

endmodule