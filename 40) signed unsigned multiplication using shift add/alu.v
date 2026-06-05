`timescale 1ns / 1ps

module alu(
    input signed [7:0] num1, num2,
    input [3:0] operation,
    input [1:0] opselect,
    input [2:0] shift_amt,
    output reg [15:0] result,
    output reg carry,
    output reg overflow
);

    wire [15:0] mult_result;
    reg [8:0] temp_result;
    signed_multiplication dut (.A(num1), .B(num2), .product(mult_result));
    
    // operation = 000 is AND, 001 is OR, 010 is ADD, 011 is SUB, 100 is XOR.
    // operation = 101 is SLT, 110 is NOR, 111 is shift
    // for 8 bit number range of numbers = -128 to 127
    // overflow is meaningful only for add and sub operations.
    // since we have 8 bit data, we have 3 bit shift_amt so that we can shift upto 8 bits.
    // operation = 7 will select the shift operation, opselect will select the shift type.
    // operation = 8 will multiply the 2 bits (signed and unsigned).
    
    // opselect = 0: shift left logical, 1: shift left arith, 2: shift right logical, 3: shift right arithmetic

    // & and | are bitwise operators.
    
    always @(*) begin
    
        // Carry indicates unsigned overflow/carry-out.
        // Overflow indicates signed arithmetic overflow.
        carry = 0;
    
        case (operation)
            4'b0000: result = $signed(num1 & num2);
            4'b0001: result = $signed(num1 | num2);
            4'b0010: begin
                        temp_result = {num1[7],num1} + {num2[7],num2};
                        result = {{8{temp_result[7]}}, temp_result[7:0]};   // sign extension for 16 bit result
                        carry = temp_result[8];
                     end
            4'b0011: begin
                        temp_result = {num1[7],num1} - {num2[7],num2};
                        result = {{8{temp_result[7]}}, temp_result[7:0]};   // sign extension for 16 bit result
                        carry = temp_result[8];
                     end
            4'b0100: result = $signed(num1 ^ num2);
            4'b0101: result = ($signed(num1) < $signed(num2))? 1:0;
            4'b0110: result = $signed(~(num1 | num2));
            4'b0111: case (opselect)
                        2'b00: result = num1 << shift_amt; 
                        2'b01: begin 
                                   carry = num1[7]; 
                                   result = num1 <<< shift_amt;
                               end
                        2'b10: result = num1 >> shift_amt;
                        2'b11: result = num1 >>> shift_amt;
                    endcase
            4'b1000: result = mult_result;
            default: result = 16'b0;
        endcase
        
        
        // OVERFLOW DETECTION:
        
        // addition overflow: 50 + 100 or -50 + -100
        // if we add 2 same polarity numbers and result comes out to be opposite polarity
        if (operation == 4'b0010 && (num1[7] == num2[7]) && (result[7] != num1[7])) overflow = 1;
        
        // subtraction overflow: 50 - -100 = +150 (overflow, msb 1) or -50 - 100 = -150 (overflow, msb 0)
        // so, we compare the msb of result and num1[7]
        else if (operation == 4'b0011 && (num1[7] != num2[7]) && (result[7] != num1[7])) overflow = 1;
        else overflow = 0;
        
        
        
    end
endmodule
