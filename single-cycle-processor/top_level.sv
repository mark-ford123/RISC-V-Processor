module top(
	input  logic        clk,
	input  logic        reset,

	output logic [31:0] WriteData,
	output logic [31:0] ALUResult,
	output logic        MemWrite
);


	logic [31:0] PC;
	logic [31:0] Instr;
	logic [31:0] ReadData;


instruction_memory imem(
	.PC(PC),
	.Instr(Instr)
);


data_memory dmem(
	.clk(clk),
	.ALUResult(ALUResult),
	.WriteData(WriteData),
	.MemWrite(MemWrite),
	.ReadData(ReadData)
);


riscvsingle core(
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instr(Instr),
        .MemWrite(MemWrite),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

endmodule