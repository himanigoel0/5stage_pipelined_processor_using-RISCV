`timescale 1ns / 1ps

module password_lock_system_mealy_fsm_tb();
    reg clk, rst;
    reg pswd_bit;
    wire unlock;

    password_lock_system_mealy_fsm uut (clk, rst, pswd_bit, unlock);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1; pswd_bit = 0;
        #10; rst = 0; pswd_bit = 1;
        #10; pswd_bit = 0;
        #10; pswd_bit = 1;
        #10; pswd_bit = 1;
        #10; pswd_bit = 1;
        #10; pswd_bit = 0;
        #10; pswd_bit = 1;
        #10; pswd_bit = 1;
        #10; pswd_bit = 0;
        #10; pswd_bit = 1;
        #10; pswd_bit = 1;
        #10; pswd_bit = 0;
        #10; pswd_bit = 1;
        #10; pswd_bit = 0;
        #10; pswd_bit = 1;
        #10; pswd_bit = 1;
        #10; pswd_bit = 0;
        #10; $finish;
    end
    
endmodule
