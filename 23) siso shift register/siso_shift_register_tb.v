`timescale 1ns / 1ps

module siso_shift_register_tb();
    reg clk, rst, serial_in;
    wire serial_out;
    
    siso_shift_register uut (.clk(clk), .rst(rst), .serial_in(serial_in), .serial_out(serial_out));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        // let me give the data 101101
        rst = 1; serial_in = 0;
        #10; rst = 0; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #50 rst = 1;
        #10 rst = 0;
        // now let us give the data 11101001
        #10; serial_in = 1;
        #10; serial_in = 1;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #50; $finish;
    end
    
endmodule
