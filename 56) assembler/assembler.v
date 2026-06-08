`timescale 1ns / 1ps

// an assembler converts instructions into machine code
// C Program -> Compiler -> Assembly -> Assembler -> Machine Code -> CPU

module assembler(
    input [3:0] instr,
    input [11:0] imm,
    input [4:0] rd,
    input [4:0] rs1,
    input [4:0] rs2,

    output reg [31:0] machine_code
);

    always @(*) begin

        case(instr)
    
            4'd0: begin
                // ADD
                machine_code =
                {7'b0000000,
                 rs2,
                 rs1,
                 3'b000,
                 rd,
                 7'b0110011};
            end
    
            4'd1: begin
                // SUB
                machine_code =
                {7'b0100000,
                 rs2,
                 rs1,
                 3'b000,
                 rd,
                 7'b0110011};
            end
            
            4'd2: begin
                // ADDI
                machine_code =
                {imm,
                rs1,
                3'b000,
                rd,
                7'b0010011};
            end
    
            4'd3: begin
                // ORI
                machine_code =
                {imm,
                rs1,
                3'b110,
                rd,
                7'b0010011};
            end
    
            4'd4: begin
                // SLTI
                machine_code =
                {imm,
                rs1,
                3'b010,
                rd,
                7'b0010011};
            end
    
        endcase
    
    end
    
endmodule
