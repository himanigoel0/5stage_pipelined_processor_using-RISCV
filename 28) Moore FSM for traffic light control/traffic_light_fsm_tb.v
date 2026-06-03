`timescale 1ns / 1ps

module traffic_light_fsm_tb();
    reg clk, rst;
    wire ga, ya, ra, gb, yb, rb;
    
    traffic_light_fsm uut (clk, rst, ga, ya, ra, gb, yb, rb);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #10; rst = 0;
        #400; $finish;
    end
    
endmodule
