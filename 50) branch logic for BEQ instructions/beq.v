`timescale 1ns / 1ps

// assuming each instruction is at the immediate next address, so that we have next instruction at pc+1.
// instruction format for branch type instructions will be operation | rs | rt | offset
//                                                             4     | 3  | 3  |   4

module beq(
    input [7:0] pc,
    input signed [7:0] num1, num2,
    input signed [3:0] offset,
    output reg [7:0] next_pc
);

    reg signed [7:0] offset_extended;

    always @(*) begin
    
        offset_extended = {{4{offset[3]}}, offset};
    
        if (num1 == num2) next_pc = pc + 1 + (offset_extended);
        else next_pc = pc + 1;
    end

endmodule
