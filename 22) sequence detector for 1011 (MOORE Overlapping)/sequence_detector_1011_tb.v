`timescale 1ns / 1ps

module sequence_detector_1011_tb();

    reg clk, rst, x;
    wire y;
    
    sequence_detector_1011 uut (.clk(clk), .rst(rst), .x(x), .y(y));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1; x = 0;
        #10; rst = 0; x = 1;
        #10; x = 0;
        #10; x = 1;
        #10; x = 1;
        #10; x = 0;
        #10; x = 1;
        #10; x = 1;
        #10; x = 1;
        #10; x = 1;
        #10; x = 0;
        #10; x = 0;
        #10; x = 1;
        #10; x = 0;
        #10; x = 1;
        #10; x = 0;
        #10; x = 1;
        #10; x = 1;
        #10; x = 0;
        #10; x = 1;
        #10; x = 0;
        #10; x = 1;
        #10; x = 1;
        #10; $finish;
    end

endmodule
