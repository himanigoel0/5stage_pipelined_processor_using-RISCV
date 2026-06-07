`timescale 1ns / 1ps

/*  BASIC RISCV INSTRUCTION FORMATS:
    1) official riscv has R-type, I-type, S-type, B-type, U-type, J-type instructions
    2) R-type: funct7 | rs2 | rs1 | funct3 | rd | opcode (register to register operations)
    3) I-type: imm[11:0] | rs1 | funct3 | rd | opcode (immediate instructions)
    4) S-type: imm | rs2 | rs1 | funct3 | imm | opcode (store instruction)
    5) B-type: imm | rs2 | rs1 | funct3 | imm | opcode (branch instruction)
    6) U-type: imm[31:12] | rd | opcode (upper immediate instruction)
    7) J-type: imm | rd | opcode (jump instructions)
    
    Common RV32I R-Type Instructions
    Instruction	opcode	  funct3	funct7
    ADD	        0110011	  000	    0000000
    SUB	        0110011	  000	    0100000
    AND	        0110011	  111	    0000000
    OR	        0110011	  110	    0000000
    XOR	        0110011	  100	    0000000
    SLL	        0110011	  001	    0000000
    SRL	        0110011	  101	    0000000
    SRA	        0110011	  101	    0100000
    SLT	        0110011	  010	    0000000
*/

module opcode_decoder_rv32i(
    input [6:0] opcode,
    output reg r_type,
    output reg i_type,
    output reg s_type,
    output reg b_type,
    output reg u_type,
    output reg j_type
);

    always @(*) begin

    r_type = 0;
    i_type = 0;
    s_type = 0;
    b_type = 0;
    u_type = 0;
    j_type = 0;

    case(opcode)
        7'b0110011: r_type = 1;

        7'b0010011,
        7'b0000011,
        7'b1100111: i_type = 1;

        7'b0100011: s_type = 1;

        7'b1100011: b_type = 1;

        7'b0110111,
        7'b0010111: u_type = 1;

        7'b1101111: j_type = 1;

        default: begin
            r_type = 0;
            i_type = 0;
            s_type = 0;
            b_type = 0;
            u_type = 0;
            j_type = 0;
        end
    endcase

end

endmodule
