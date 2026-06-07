`timescale 1ns / 1ps

module and_or_slt_test_tb();

    reg signed [7:0] num1, num2;
    reg [3:0] operation;
    reg [1:0] opselect;
    reg [2:0] shift_amt;
    wire [15:0] result;
    wire carry, overflow;
    
    alu uut (num1, num2, operation, opselect, shift_amt, result, carry, overflow);
    
    initial begin
        // testing and operation (4'b0000):
        operation = 4'b0000; opselect = 2'b00; num1 = 8'b00100101; num2 = 8'b00101101; shift_amt = 3'b000;
        #10; num1 = 8'b00110101; num2 = 8'b10101101;
        #10; num1 = 8'b10100101; num2 = 8'b10101101;
        #10; num1 = 8'b10100101; num2 = 8'b00101101;
        
        // testing or operation (4'b0001): 
        #10; operation = 4'b0001; num1 = 8'b00100101; num2 = 8'b00101101;
        #10; num1 = 8'b00110101; num2 = 8'b10101101;
        #10; num1 = 8'b10100101; num2 = 8'b10101101;
        #10; num1 = 8'b10100101; num2 = 8'b00101101;
        
        // testing slt operation (4'b0101):
        #10; operation = 4'b0101; num1 = 8'd10; num2 = 8'd5;
        #10; num1 = 8'd10; num2 = -8'd5;
        #10; num1 = -8'd10; num2 = 8'd5;
        #10; num1 = -8'd10; num2 = -8'd5;
        
        #10; $finish;
    end
    
endmodule
