module data_memory(
    input  logic        clk,
    input  logic [31:0] ALUResult,
    input  logic [31:0] WriteData,
    input  logic        MemWrite,

    output logic [31:0] ReadData
);

    // Declare the RAM array (64 words of 32 bits each)
    logic [31:0] ram [63:0];

    // Synchronous Write Logic
    always_ff @(posedge clk) begin
        if (MemWrite) begin
            ram[ALUResult[31:2]] <= WriteData;
        end
    end

    // Asynchronous Read Logic
    assign ReadData = ram[ALUResult[31:2]];

endmodule