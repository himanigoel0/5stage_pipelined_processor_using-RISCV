`timescale 1ns / 1ps

module mux_4x1_behavioral_tb();

    reg A, B, C, D;
    reg [1:0] sel;
    wire Y;
    
    mux_4x1_behavioral uut (.A(A), .B(B), .C(C), .D(D), .sel(sel), .Y(Y));
    
    initial begin
        A = 0; B = 0; C = 0; D = 0; sel = 2'b00;
        #10; A = 1; B = 0; C = 0; D = 0; sel = 2'b00;
        #10; A = 0; B = 0; C = 0; D = 0; sel = 2'b01;
        #10; A = 0; B = 1; C = 0; D = 0; sel = 2'b01;
        #10; A = 0; B = 0; C = 0; D = 0; sel = 2'b10;
        #10; A = 0; B = 0; C = 1; D = 0; sel = 2'b10;
        #10; A = 0; B = 0; C = 0; D = 0; sel = 2'b11;
        #10; A = 0; B = 0; C = 0; D = 1; sel = 2'b11;
        #10; $finish;
    end

endmodule
