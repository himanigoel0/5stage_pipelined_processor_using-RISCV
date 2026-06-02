`timescale 1ns / 1ps

module ring_counter_4bit_tb();
    reg clk, rst;
    wire [3:0] counter;
    
    ring_counter_4bit uut (.clk(clk), .rst(rst), .counter(counter));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #10; rst = 0;
        #100; rst = 1;
        #10; rst = 0;
        #60; rst = 1;
        #10; rst = 0;
        
    end
    
endmodule
