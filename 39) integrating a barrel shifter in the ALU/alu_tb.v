`timescale 1ns / 1ps

// operation = 000 is AND, 001 is OR, 010 is ADD, 011 is SUB, 100 is XOR.
// operation = 101 is SLT, 110 is NOR, 111 is shift

module alu_tb();

    reg signed [7:0] num1, num2;
    reg [2:0] operation;
    reg [1:0] opselect;
    reg [2:0] shift_amt;
    wire [7:0] result;
    wire carry;
    wire overflow;
    
    alu uut (num1, num2, operation, opselect, shift_amt, result, carry, overflow);
    
    initial begin 
//        num1 = 15; num2 = 12; operation = 0;
//        #10; num1 = 15; num2 = 12; operation = 1;
//        #10; num1 = 15; num2 = 12; operation = 2;
//        #10; num1 = 15; num2 = 12; operation = 3;
//        #10; num1 = 15; num2 = 12; operation = 4;
//        #10; num1 = 15; num2 = 12; operation = 5;
//        #10; num1 = 15; num2 = 12; operation = 6;
        
//        #10; num1 = 21; num2 = 30; operation = 0;
//        #10; num1 = 21; num2 = 30; operation = 1;
//        #10; num1 = 21; num2 = 30; operation = 2;
//        #10; num1 = 21; num2 = 30; operation = 3;
//        #10; num1 = 21; num2 = 30; operation = 4;
//        #10; num1 = 21; num2 = 30; operation = 5;
//        #10; num1 = 21; num2 = 30; operation = 6;
        
//        #10; num1 = -12; num2 = 14; operation = 0;
//        #10; num1 = -12; num2 = 14; operation = 1;
//        #10; num1 = -12; num2 = 14; operation = 2;
//        #10; num1 = -12; num2 = 14; operation = 3;
//        #10; num1 = -12; num2 = 14; operation = 4;
//        #10; num1 = -12; num2 = 14; operation = 5;
//        #10; num1 = -12; num2 = 14; operation = 6;

//          num1 = 100; num2 = 50; operation = 2; opselect = 2'b00; shift_amt = 0;
//          #10; num1 = -100; num2 = 50; operation = 2;
//          #10; num1 = 100; num2 = -50; operation = 2;
//          #10; num1 = -100; num2 = -50; operation = 2;
          
//          #10; num1 = 100; num2 = 50; operation = 3;
//          #10; num1 = -100; num2 = 50; operation = 3;
//          #10; num1 = 100; num2 = -50; operation = 3;
//          #10; num1 = -100; num2 = -50; operation = 3;
          
//          #10; num1 = 100; num2 = 50; operation = 5;
//          #10; num1 = -100; num2 = 50; operation = 5;
//          #10; num1 = 100; num2 = -50; operation = 5;
//          #10; num1 = -100; num2 = -50; operation = 5;
          
          num1 = 8'b01101011; num2 = 0; operation = 3'b111; opselect = 2'b00; shift_amt = 2;
          #10; num1 = 8'b01101011; operation = 3'b111; opselect = 2'b01; shift_amt = 2;
          #10; num1 = 8'b01101011; operation = 3'b111; opselect = 2'b10; shift_amt = 2;
          #10; num1 = 8'b01101011; operation = 3'b111; opselect = 2'b11; shift_amt = 2;
                                                                         
          #10; num1 = 8'b11101011; operation = 3'b111; opselect = 2'b00; shift_amt = 2;
          #10; num1 = 8'b11101011; operation = 3'b111; opselect = 2'b01; shift_amt = 2;
          #10; num1 = 8'b11101011; operation = 3'b111; opselect = 2'b10; shift_amt = 2;
          #10; num1 = 8'b11101011; operation = 3'b111; opselect = 2'b11; shift_amt = 2;
        
        #10; $finish;
    end

endmodule
