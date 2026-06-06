`timescale 1ns / 1ps

module mini_cpu_tb();

    reg clk, rst;
    wire [7:0] pc_debug;
    wire [15:0] instr_debug, result_debug;
    
    mini_cpu uut (clk, rst, pc_debug, instr_debug, result_debug);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #10; rst = 0;
        #1000; $finish;
    end

endmodule
