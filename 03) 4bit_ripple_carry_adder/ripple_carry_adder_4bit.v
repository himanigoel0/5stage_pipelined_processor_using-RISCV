`timescale 1ns / 1ps

module ripple_carry_adder_4bit(
    input [3:0] A, B,
    output [3:0] sum,
    output cout
);

    wire c1, c2, c3;

    full_adder stage1 (.A(A[0]), .B(B[0]), .Cin(1'b0), .sum(sum[0]), .cout(c1));
    full_adder stage2 (.A(A[1]), .B(B[1]), .Cin(c1), .sum(sum[1]), .cout(c2));
    full_adder stage3 (.A(A[2]), .B(B[2]), .Cin(c2), .sum(sum[2]), .cout(c3));
    full_adder stage4 (.A(A[3]), .B(B[3]), .Cin(c3), .sum(sum[3]), .cout(cout));

endmodule
