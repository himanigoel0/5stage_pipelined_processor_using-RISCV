`timescale 1ns / 1ps

module tff_using_dff_tb();
    reg clk, rst, T;
    wire Q;
    
    tff_using_dff uut (.clk(clk), .rst(rst), .T(T), .Q(Q));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin

        rst = 1; T = 0;
        #10; rst = 1; T = 1;
        #10; rst = 0; T = 0;
        #10; rst = 0; T = 1;
        #14; rst = 1; T = 0;
        #10; rst = 0;
        #10; T = 1;
        #10; T = 1;
        #10; T = 1;
        #10; T = 1;
        #14; rst = 1;
        
        #20; $finish;

    end

    
endmodule
