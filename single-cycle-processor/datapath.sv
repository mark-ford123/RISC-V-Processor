module datapath(
    input  logic 	    clk,
    input  logic        reset,
    input  logic [31:0] Instr,
    input  logic [1:0]  ImmSrc,
    input  logic	    Branch,
    input  logic        ALUSrc,       
    input  logic        RegWrite,     
    input  logic [2:0]  ALUControl,   
    input  logic [31:0] ReadData,  
    input  logic        ResultSrc,
    input  logic        zero,
    
    output logic [31:0] PC,
    output logic [31:0] WriteData,
    output logic [31:0] ALUResult
);

    // Declare missing internal 32-bit wires
    logic [31:0] SrcA;
    logic [31:0] SrcB;
    logic [31:0] Result;
    logic [31:0] ImmExt;

    regfile rf(
        .clk(clk),
        .we3(RegWrite),
        .a1(Instr[19:15]),
        .a2(Instr[24:20]),
        .a3(Instr[11:7]),
        .wd3(Result),    
        .rd1(SrcA),
        .rd2(WriteData)
    );

    ALU alu(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .zero(zero)
    );

    imm_ext ie(
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .immext(ImmExt)
    );

    logic [31:0] PCPlus4;
    assign PCPlus4 = PC + 4;

    logic [31:0] PCTarget;
    assign PCTarget = PC + ImmExt;

    logic PCSrc;
    assign PCSrc = Branch & zero;

    logic [31:0] PCNext;
    assign PCNext = (PCSrc ? PCTarget : PCPlus4);

    always_ff @(posedge clk or posedge reset)
        if (reset)
            PC <= 32'h0;
        else
            PC <= PCNext;

    assign SrcB = (ALUSrc ? ImmExt : WriteData);
    assign Result = (ResultSrc ? ReadData : ALUResult);

endmodule