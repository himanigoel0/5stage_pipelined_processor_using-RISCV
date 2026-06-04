`timescale 1ns / 1ps

module alu(
    input [7:0] num1, num2,
    input [2:0] operation,
    output reg [8:0] result
);
    // operation = 000 is and, 001 is or, 010 is add, 011 is sub, 100 is xor.

    // & and | are bitwise operators.
    always @(*) begin
        case (operation)
            3'b000: result = num1 & num2;
            3'b001: result = num1 | num2;
            3'b010: result = num1 + num2;
            3'b011: result = num1 - num2;
            3'b100: result = num1 ^ num2;
            default: result = 9'b0;
        endcase
    end
endmodule
