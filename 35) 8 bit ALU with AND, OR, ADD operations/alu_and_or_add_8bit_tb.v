`timescale 1ns / 1ps

module alu_and_or_add_8bit_tb();

    reg [7:0] num1, num2;
    reg [1:0] operation;
    wire [8:0] result;
    
    alu_and_or_add_8bit uut (num1, num2, operation, result);
    
    initial begin
        num1 = 12; num2 = 15; operation = 3'b00;   // and
        #10; num1 = 8'b11011001; num2 = 8'b10101001; operation = 3'b00;    // and
        #10; num1 = 12; num2 = 15; operation = 3'b01;   // or
        #10; num1 = 8'b11011001; num2 = 8'b10101001; operation = 3'b01;    // or
        #10; num1 = 12; num2 = 15; operation = 3'b10;    // add
        #10; num1 = 8'b11011001; num2 = 8'b10101001; operation = 3'b10;    // add
        #10; $finish;
    end

endmodule
