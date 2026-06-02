`timescale 1ns / 1ps

module piso_shift_register_tb();
    reg clk, rst, load;
    reg [3:0] parallel_in;
    wire serial_out;
    
    piso_shift_register uut (.clk(clk), .rst(rst), .load(load), .parallel_in(parallel_in), .serial_out(serial_out));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1; load = 0; parallel_in = 4'b0000;
        #10; rst = 0; load = 0; parallel_in = 4'b1010;
        #10; load = 1; 
        #10; load = 0;
        #50; rst = 1;
        #10; rst = 0; load = 1; parallel_in = 4'b1011;
        #10; load = 0;
        #50; rst = 1;
        #10; rst = 0; load = 1; parallel_in = 4'b1001;
        #10; load = 0;
        #50; $finish;
    end
    
endmodule
