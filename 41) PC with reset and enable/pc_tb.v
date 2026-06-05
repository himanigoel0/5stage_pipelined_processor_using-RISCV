`timescale 1ns / 1ps

module pc_tb();
    reg clk, rst, en;
    wire [7:0] pc;
    
    pc uut (clk, rst, en, pc);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1; en = 0;
        #10; rst = 1; en = 1;
        #10; rst = 0; en = 1;
        #50; rst = 1; en = 1;
        #10; rst = 0; en = 1;
        #1000; rst = 0; en = 0;      // hold
        #40; rst = 0; en = 1;
        #2000; $finish;
    end
    
endmodule
