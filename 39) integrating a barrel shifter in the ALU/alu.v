`timescale 1ns / 1ps

module alu(
    input signed [7:0] num1, num2,
    input [2:0] operation,
    input [1:0] opselect,
    input [2:0] shift_amt,
    output reg [7:0] result,
    output reg carry,
    output reg overflow
);
    // operation = 000 is AND, 001 is OR, 010 is ADD, 011 is SUB, 100 is XOR.
    // operation = 101 is SLT, 110 is NOR, 111 is shift
    // for 8 bit number range of numbers = -128 to 127
    // overflow is meaningful only for add and sub operations.
    // since we have 8 bit data, we have 3 bit shift_amt so that we can shift upto 8 bits.
    // operation = 7 will select the shift operation, opselect will select the shift type.
    
    // opselect = 0: shift left logical, 1: shift left arith, 2: shift right logical, 3: shift right arithmetic

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
            3'b111: case (opselect)
                        2'b00: result = num1 << shift_amt; 
                        2'b01: begin 
                                   carry = num1[7]; 
                                   result = num1 <<< shift_amt;
                               end
                        2'b10: result = num1 >> shift_amt;
                        2'b11: result = num1 >>> shift_amt;
                    endcase
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
