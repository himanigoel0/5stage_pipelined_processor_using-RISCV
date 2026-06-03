`timescale 1ns / 1ps

module digital_clock_counter_tb();
    reg clk, rst;
    wire [4:0] HH;
    wire [5:0] MM;
    wire [5:0] SS;
    wire [16:0] timer;
    
    digital_clock_counter uut (.clk(clk), .rst(rst), .HH(HH), .MM(MM), .SS(SS), .timer(timer));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #10; rst = 0;
    end
    
endmodule
