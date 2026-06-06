`timescale 1ns / 1ps

module fetch_decode_execute_tb();
    reg clk, rst;
    reg [2:0] shift_amt;
    wire [15:0] result_out;
    
    wire [7:0]  pc_debug;
    wire [15:0] instruction_debug;
    wire [3:0]  operation_debug;
    wire [2:0]  rs_debug;
    wire [2:0]  rt_debug;
    wire [2:0]  rd_debug;
    wire [7:0]  num1_debug;
    wire [7:0]  num2_debug;
    
    fetch_decode_execute uut (clk, rst, shift_amt, result_out, pc_debug, instruction_debug, operation_debug,
                              rs_debug, rt_debug, rd_debug, num1_debug, num2_debug);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
    
        rst = 1; shift_amt = 0;
        #10; rst = 0; shift_amt = 1;
        #200; $finish;
    
    end
    
endmodule
