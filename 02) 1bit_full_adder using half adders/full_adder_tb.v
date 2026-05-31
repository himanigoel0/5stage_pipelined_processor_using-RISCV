`timescale 1ns / 1ps

module full_adder_tb();
    reg A, B, Cin;
    wire sum, cout;
    
    full_adder uut (.A(A), .B(B), .Cin(Cin), .sum(sum), .cout(cout));
    
    initial begin
        A = 0; B = 0; Cin = 0;
        #10; A = 0; B = 0; Cin = 1;
        #10; A = 0; B = 1; Cin = 0;
        #10; A = 0; B = 1; Cin = 1;
        #10; A = 1; B = 0; Cin = 0;
        #10; A = 1; B = 0; Cin = 1;
        #10; A = 1; B = 1; Cin = 0;
        #10; A = 1; B = 1; Cin = 1;
        #10; $finish;
    end
    
endmodule
