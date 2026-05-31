`timescale 1ns / 1ps

module demux_1x2_tb();
    reg A, sel;
    wire Y1, Y2;
    
    demux_1x2 uut (A, sel, Y1, Y2);
    
    initial begin
        A = 0; sel = 0;
        #10; A = 1; sel = 0;
        #10; A = 0; sel = 1;
        #10; A = 1; sel = 1;
        #10; $finish;
        
    end
    
endmodule
