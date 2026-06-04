`timescale 1ns / 1ps

module alu(
    input [7:0] num1, num2,
    input [2:0] operation,
    output reg [7:0] result,
    output reg carry,
    output reg overflow
);
    // operation = 000 is AND, 001 is OR, 010 is ADD, 011 is SUB, 100 is XOR.
    // operation = 101 is SLT, 110 is NOR
    // for 8 bit number range of numbers = -128 to 127
    // overflow is meaningful only for add and sub operations.

    // & and | are bitwise operators.
    
    always @(*) begin
    
        carry = 0;
    
        case (operation)
            3'b000: result = num1 & num2;
            3'b001: result = num1 | num2;
            3'b010: {carry, result} = num1 + num2;
            3'b011: {carry, result} = num1 - num2;
            3'b100: result = num1 ^ num2;
            3'b101: result = ($signed(num1) < $signed(num2))? 1:0;
            3'b110: result = ~(num1 | num2);
            default: result = 8'b0;
        endcase
        
        
        // to detect overflow: 
        // addition overflow: 50 + 100 or -50 + -100
        // if we add 2 same polarity numbers and result comes out to be opposite polarity
        if (operation == 3'b010 && (num1[7] == num2[7]) && (result[7] != num1[7])) overflow = 1;
        
        // subtraction overflow: 50 - -100 = +150 (overflow, msb 1) or -50 - 100 = -150 (overflow, msb 0)
        // so, we compare the msb of result and num1[7]
        else if (operation == 3'b011 && (num1[7] != num2[7]) && (result[7] != num1[7])) overflow = 1;
        else overflow = 0;
        
    end
endmodule
