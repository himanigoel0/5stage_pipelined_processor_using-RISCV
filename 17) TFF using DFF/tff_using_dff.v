`timescale 1ns / 1ps

module tff_using_dff(
    input T, clk, rst,
    output Q
);
    wire D;
    assign D = T ^ Q;
    
    dff_asynchronous_rst m1 (.clk(clk), .rst(rst), .D(D), .Q(Q));
    
endmodule
