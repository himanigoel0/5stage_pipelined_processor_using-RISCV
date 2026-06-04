`timescale 1ns / 1ps

// ALU is generally combinational circuit.
// The ALU itself doesn't need to remember anything. The registers around it provide the memory.

module alu_and_or_add_8bit(
    input [7:0] num1, num2,
    input [1:0] operation,
    output reg [8:0] result
);
    // operation = 00 is and, 01 is or, 10 is add

    // & and | are bitwise operators.
    always @(*) begin
        if (operation == 2'b00) result = num1 & num2;
        else if (operation == 2'b01) result = num1 | num2;
        else if (operation == 2'b10) result = num1 + num2;
        else result <= 9'b0;
    end

endmodule
