`timescale 1ns / 1ps

// operation = 000 is AND, 001 is OR, 010 is ADD, 011 is SUB, 100 is XOR.
// operation = 101 is SLT, 110 is NOR

module alu_tb();

    reg [7:0] num1, num2;
    reg [2:0] operation;
    wire [8:0] result;
    
    alu uut (num1, num2, operation, result);
    
    initial begin 
        num1 = 15; num2 = 12; operation = 0;
        #10; num1 = 15; num2 = 12; operation = 1;
        #10; num1 = 15; num2 = 12; operation = 2;
        #10; num1 = 15; num2 = 12; operation = 3;
        #10; num1 = 15; num2 = 12; operation = 4;
        #10; num1 = 15; num2 = 12; operation = 5;
        #10; num1 = 15; num2 = 12; operation = 6;
        
        #10; num1 = 21; num2 = 30; operation = 0;
        #10; num1 = 21; num2 = 30; operation = 1;
        #10; num1 = 21; num2 = 30; operation = 2;
        #10; num1 = 21; num2 = 30; operation = 3;
        #10; num1 = 21; num2 = 30; operation = 4;
        #10; num1 = 21; num2 = 30; operation = 5;
        #10; num1 = 21; num2 = 30; operation = 6;
        
        #10; num1 = -12; num2 = 14; operation = 0;
        #10; num1 = -12; num2 = 14; operation = 1;
        #10; num1 = -12; num2 = 14; operation = 2;
        #10; num1 = -12; num2 = 14; operation = 3;
        #10; num1 = -12; num2 = 14; operation = 4;
        #10; num1 = -12; num2 = 14; operation = 5;
        #10; num1 = -12; num2 = 14; operation = 6;
        
        #10; $finish;
    end

endmodule
