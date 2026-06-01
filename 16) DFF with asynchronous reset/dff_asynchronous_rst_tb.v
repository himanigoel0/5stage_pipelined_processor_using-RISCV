`timescale 1ns / 1ps

module dff_asynchronous_rst_tb();
    reg clk, rst, D;
    wire Q;
    
    dff_asynchronous_rst uut (.D(D), .rst(rst), .clk(clk), .Q(Q));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        // testing asynchronous reset at clk edges
             rst = 1; D = 0;
        #10; rst = 1; D = 1;
        #10; rst = 0; D = 0;
        #10; rst = 0; D = 1;
        // testing asynchronous reset at non clk edges
        #14; rst = 1; D = 1;
        #12; rst = 1; D = 0;
        #10; $finish;
    end
    
endmodule
