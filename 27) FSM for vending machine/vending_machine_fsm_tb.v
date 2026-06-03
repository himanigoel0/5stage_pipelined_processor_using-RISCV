`timescale 1ns / 1ps

module vending_machine_fsm_tb();
    reg clk, rst;
    reg insert5, insert10, cancel;
    wire dispense;
    wire change;
    
    vending_machine_fsm uut (.clk(clk),
                              .rst(rst),
                              .insert5(insert5),
                              .insert10(insert10),
                              .cancel(cancel),
                              .dispense(dispense),
                              .change(change));
                              
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1; insert5 = 0; insert10 = 0; cancel = 0;
        
        // 5 + 5 + 10 dispense + change
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 0; insert10 = 1; cancel = 0;
        
        // 5 + 5 + 5 dispense
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        
        // 10 + 10 dispense
        #10; rst = 0; insert5 = 0; insert10 = 1; cancel = 0;
        #10; rst = 0; insert5 = 0; insert10 = 1; cancel = 0;
        
        // 5 + 10 dispense
        #10; rst = 0; insert5 = 0; insert10 = 1; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        
        // 10 + 5 dispense
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 0; insert10 = 1; cancel = 0;
        
        // 5 + cancel + 5 + 5 + 5 dispense
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 1;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        
        // 5 + cancel + 5 + 5 + 10 dispense + change
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 1;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 1; insert10 = 0; cancel = 0;
        #10; rst = 0; insert5 = 0; insert10 = 1; cancel = 0;
        
        #20; $finish;
        
    end
endmodule
