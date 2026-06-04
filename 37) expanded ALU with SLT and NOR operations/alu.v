`timescale 1ns / 1ps

module alu(
    input [7:0] num1, num2,
    input [2:0] operation,
    output reg [8:0] result
);
    // operation = 000 is AND, 001 is OR, 010 is ADD, 011 is SUB, 100 is XOR.
    // operation = 101 is SLT, 110 is NOR

    // & and | are bitwise operators.
    always @(*) begin
        case (operation)
            3'b000: result = num1 & num2;
            3'b001: result = num1 | num2;
            3'b010: result = num1 + num2;
            3'b011: result = num1 - num2;
            3'b100: result = num1 ^ num2;
            3'b101: result = (num1 < num2)? 1:0;
            3'b110: result = ~(num1 | num2);
            
            default: result = 9'b0;
        endcase
    end
endmodule
