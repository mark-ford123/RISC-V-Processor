module alu_decoder(
    input  logic [1:0]  ALUop,
    input  logic [2:0]  funct3,
    input  logic [1:0]  op_funct7,

    output logic [2:0]  ALUControl
);

    always_comb begin

        case(ALUop)
            2'b00: ALUControl = 3'b000;  // ADD instruction (lw/sw)

            2'b01: ALUControl = 3'b001;  // SUB instruction (beq)

            2'b10: begin

                case(funct3)
                    3'b000: begin 
                       
                        case(op_funct7)
                            2'b11:   ALUControl = 3'b001; // SUB (R-type)
                            default: ALUControl = 3'b000; // ADD (R-type)

                        endcase

                    end

                    3'b010: ALUControl = 3'b101; // Set Less Than (slt)
                    3'b110: ALUControl = 3'b011; // OR
                    3'b111: ALUControl = 3'b010; // AND
                            
                    default: ALUControl = 3'b000;

                endcase

            end

            default: ALUControl = 3'b000;

        endcase

    end

endmodule
