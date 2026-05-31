`timescale 1ns / 1ps

module half_adder_1_bit_tb();
    reg A, B;
    wire sum, cout;
    
half_adder_1_bit uut (
    .A(A),
    .B(B),
    .sum(sum),
    .cout(cout)
);

    initial begin
        A = 0; B = 0;
        #10; A = 0; B = 1;
        #10; A = 1; B = 0;
        #10; A = 1; B = 1;
        
        #10; $finish;
        
    end

endmodule
