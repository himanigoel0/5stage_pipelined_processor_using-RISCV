`timescale 1ns / 1ps

module binary_counter_synch_tb();

    reg clk, rst;
    wire [3:0] Q;
    
    binary_counter_synch uut (.clk(clk), .rst(rst), .Q(Q));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
    
        rst = 1;
        #10; rst = 0; 
        #100; rst = 1;
        #10; rst = 0;
        #223; rst = 1;
        #10; rst = 0;
            
    end

endmodule
