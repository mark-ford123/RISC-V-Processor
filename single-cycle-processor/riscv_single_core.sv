module riscvsingle(
	input  logic 	    clk,
	input  logic        reset,
	input  logic [31:0] Instr,
	input  logic [31:0] ReadData,
	
	output logic [31:0] PC,
	output logic        MemWrite,
	output logic [31:0] ALUResult,
	output logic [31:0] WriteData
);


	logic 	    ResultSrc; 
	logic       ALUSrc; 
	logic       RegWrite;
	logic       zero;
	logic       Branch;
	logic [2:0] ALUControl;
	logic [1:0] ImmSrc;



	controller c(
		.op(Instr[6:0]),
		.funct3(Instr[14:12]),
		.funct7(Instr[30]),
		.zero(zero),
		.ImmSrc(ImmSrc),
		.ALUSrc(ALUSrc),
		.ResultSrc(ResultSrc),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.ALUControl(ALUControl),
		.RegWrite(RegWrite)
	);

	
	datapath dp(
		.clk(clk),
		.reset(reset),
		.Instr(Instr),
		.ImmSrc(ImmSrc),
		.Branch(Branch),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.ALUControl(ALUControl),
		.ReadData(ReadData),
		.ResultSrc(ResultSrc),
		.PC(PC),
		.WriteData(WriteData),
		.ALUResult(ALUResult), 
		.zero(zero)            
	);


endmodule
