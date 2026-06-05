`timescale 1ns / 1ps

module signed_multiplication_tb();

    reg [7:0] A, B;
    wire [15:0] product;
    
    signed_multiplication uut (A, B, product);
    
    initial begin
        // testing normal cases
        A = 5; B = 10;
        #10; A = -5; B = 10;
        #10; A = 5; B = -10;
        #10; A = -5; B = -10;
        
        // testing the extreme cases
        #10; A = 127; B = 1;
        #10; A = -128; B = 1;
        #10; A = 127; B = -1;
        #10; A = -128; B = -1;
        
        #10; $finish;
    end

endmodule
