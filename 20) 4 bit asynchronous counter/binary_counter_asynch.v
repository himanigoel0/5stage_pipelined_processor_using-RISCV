`timescale 1ns / 1ps

module binary_counter_asynch(
    input clk, rst,
    output [3:0] Q
);

// Synchronous counter: all the bit modules get the same clk together
// Asynchronous counter: Only the first flip-flop gets the external clock
// Each subsequent flip-flop uses the previous flip-flop's output as its clock

// clk -> ff0 -> ff1 -> ff2 -> ff3
// ff0 toggles from external clk
// ff1 toggles from ff0 output.. and so on
// q[0] toggles with freq half of clk, q[1] with freq half of q[0]

    tff_using_dff f0 (.clk(clk), .T(1'b1), .rst(rst), .Q(Q[0]));
    tff_using_dff f1 (.clk(Q[0]), .T(1'b1), .rst(rst), .Q(Q[1]));
    tff_using_dff f2 (.clk(Q[1]), .T(1'b1), .rst(rst), .Q(Q[2]));
    tff_using_dff f3 (.clk(Q[2]), .T(1'b1), .rst(rst), .Q(Q[3]));
    
    // here we are using posedge clk and hence we get a down counter.
    // if we need an up counter, we need to use negedhe of clk.
//    FF0 clock = clk
//    FF1 clock = Q[0]
//    FF2 clock = Q[1]
//    FF3 clock = Q[2]

endmodule
