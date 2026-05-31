`timescale 1ns / 1ps

module full_adder(
    input A, B, Cin,
    output sum, cout
);
wire half_sum, c1, c2;

    half_adder_1_bit stage1 (.A(A), .B(B), .sum(half_sum), .cout(c1));
    half_adder_1_bit stage2 (.A(half_sum), .B(Cin), .sum(sum), .cout(c2));
    
    or (cout, c1, c2);
endmodule
