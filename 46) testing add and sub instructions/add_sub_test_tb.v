`timescale 1ns / 1ps

// operation for add = 4'b0010, for sub = 4'b0011
module add_sub_test_tb();

    reg signed [7:0] num1, num2;
    reg [3:0] operation;
    reg [1:0] opselect;
    reg [2:0] shift_amt;
    wire [15:0] result;
    wire carry, overflow;
    
    alu uut (num1, num2, operation, opselect, shift_amt, result, carry, overflow);
    
    initial begin
        // testing add:
        num1 = 15; num2 = 12; operation = 4'b0010; opselect = 2'b00; shift_amt = 3'b000;
        #10; num1 = 15; num2 = -12;
        #10; num1 = -15; num2 = 12;
        #10; num1 = -15; num2 = -12;
        
        #10; num1 = 127; num2 = 2;
        #10; num1 = 127; num2 = -2;
        #10; num1 = -128; num2 = 2;
        #10; num1 = -128; num2 = -12;
        
        #10; num1 = 15; num2 = 12; operation = 4'b0011; opselect = 2'b00; shift_amt = 3'b000;
        #10; num1 = 15; num2 = -12;
        #10; num1 = -15; num2 = 12;
        #10; num1 = -15; num2 = -12;
        
        #10; num1 = 127; num2 = 2;
        #10; num1 = 127; num2 = -2;
        #10; num1 = -128; num2 = 2;
        #10; num1 = -128; num2 = -12;
        
        #10; $finish;
        
    end
    
endmodule
