`timescale 1ns / 1ps

module subtractor_4bit(
    input [3:0] A, B,
    output [3:0] diff,
    output borrow
);
    wire [3:0] bbar = ~B;
    wire c1, c2, c3, cout;
    
    full_adder stage1 (.A(A[0]), .B(bbar[0]), .Cin(1'b1), .sum(diff[0]), .cout(c1));
    full_adder stage2 (.A(A[1]), .B(bbar[1]), .Cin(c1), .sum(diff[1]), .cout(c2));
    full_adder stage3 (.A(A[2]), .B(bbar[2]), .Cin(c2), .sum(diff[2]), .cout(c3));
    full_adder stage4 (.A(A[3]), .B(bbar[3]), .Cin(c3), .sum(diff[3]), .cout(cout));
    
    assign borrow = ~cout;
    
    // in subtractor using full adders, the borrow is complement of carry out.
    
endmodule
