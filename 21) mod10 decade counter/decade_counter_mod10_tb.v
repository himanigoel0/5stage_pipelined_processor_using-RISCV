`timescale 1ns / 1ps

module decade_counter_mod10_tb();

    reg clk, rst;
    wire [3:0] Q;
    
    decade_counter_mod10 uut (.clk(clk), .rst(rst), .Q(Q));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #10; rst = 0;
        #100; rst = 1;
        #10; rst = 0;
        #200; rst = 1;
        #10; rst = 0;
        #10; $finish;
    end

endmodule
