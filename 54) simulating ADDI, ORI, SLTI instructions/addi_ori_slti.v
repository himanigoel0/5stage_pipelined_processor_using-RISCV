`timescale 1ns / 1ps

// addi, ori, slti have opcode = 001 0011
// funct3 values are respectively: 000, 110, 010

// I-type instruction format:

//31              20 19   15 14  12 11    7 6      0
//+----------------+-------+------+-------+--------+
//|  imm[11:0]     | rs1   |funct3|  rd   | opcode |
//+----------------+-------+------+-------+--------+

module addi_ori_slti(
    input [31:0] instruction,
    input signed [31:0] rs1_value,
    output reg signed [31:0] result
);
    wire signed [11:0] imm;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [4:0] rs1, rd;
    
    assign imm    = instruction[31:20];
    assign rs1    = instruction[19:15];
    assign funct3 = instruction[14:12];
    assign rd     = instruction[11:7];
    assign opcode = instruction[6:0];
    
    always @(*) begin
        result = 0;
        if (opcode == 7'b0010011) begin
            case(funct3)
                3'b000: result = rs1_value + $signed(imm);            // ADDI
                3'b110: result = rs1_value | imm;                     // ORI
                3'b010: result = ($signed(rs1_value) < $signed(imm)); // SLTI
        endcase
        end
    end
    
endmodule
