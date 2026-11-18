module testbench();
    logic        clk;
    logic        reset;
    logic [31:0] WriteData;
    logic [31:0] ALUResult;
    logic        MemWrite;


    // Instantiate the Device Under Test (DUT)
    top dut(
        .clk(clk),
        .reset(reset),
        .WriteData(WriteData),
        .ALUResult(ALUResult),
        .MemWrite(MemWrite)
    );


    // Generate Clock Signal (10 time units per full cycle)
    always begin
        clk = 1; #5;
        clk = 0; #5;
    end


    // 3. Apply Initial Reset Pulse
    initial begin
        reset = 1; 
        #22;       // Hold reset high for a little over 2 cycles
        reset = 0; 
    end


    // Self-Checking Verification Logic
    always @(negedge clk) begin
        if (MemWrite) begin
            // Example success condition: 
            // If the processor writes 25 (WriteData) to data address 100 (ALUResult)
            if (ALUResult === 100 && WriteData === 25) begin
                $display("----------------------------------------");
                $display("SIMULATION SUCCESSFUL! Expected result written.");
                $display("----------------------------------------");
                $stop;
            end 
            // Example scratchpad address check (e.g., address 96 used for intermediate tests)
            else if (ALUResult !== 96) begin
                $display("ERROR: Unexpected write to address %0d with data %0d", ALUResult, WriteData);
                $stop;
            end
        end
    end

endmodule
