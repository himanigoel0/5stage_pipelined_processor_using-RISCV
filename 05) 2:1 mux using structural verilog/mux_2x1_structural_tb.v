`timescale 1ns / 1ps

module mux_2x1_structural_tb();
    reg A, B, sel;
    wire Y;
    
    mux_2x1_structural uut (.A(A), .B(B), .sel(sel), .Y(Y));
    
    initial begin
        sel = 0; A = 0; B = 0;
        #10; sel = 0; A = 0; B = 1;
        #10; sel = 0; A = 1; B = 0;
        #10; sel = 0; A = 1; B = 1;
        #10; sel = 1; A = 0; B = 0;
        #10; sel = 1; A = 0; B = 1;
        #10; sel = 1; A = 1; B = 0;
        #10; sel = 1; A = 1; B = 1;
        #10; $finish;
    end
    
endmodule
