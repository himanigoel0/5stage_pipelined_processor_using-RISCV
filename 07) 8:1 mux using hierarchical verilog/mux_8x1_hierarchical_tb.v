`timescale 1ns / 1ps

module mux_8x1_hierarchical_tb();
    reg A, B, C, D ,E, F, G, H;
    reg [2:0] sel;
    wire Y;
    
    
    mux_8x1_hierarchical uut (A, B, C, D ,E, F, G, H, sel, Y);
    
    initial begin
        A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b000;
        #10; A = 1; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b000;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b001;
        #10; A = 0; B = 1; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b001;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b010;
        #10; A = 0; B = 0; C = 1; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b010;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b011;
        #10; A = 0; B = 0; C = 0; D = 1; E = 0; F = 0; G = 0; H = 0; sel = 3'b011;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b100;
        #10; A = 0; B = 0; C = 0; D = 0; E = 1; F = 0; G = 0; H = 0; sel = 3'b100;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b101;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 1; G = 0; H = 0; sel = 3'b101;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b110;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 1; H = 0; sel = 3'b110;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 0; sel = 3'b111;
        #10; A = 0; B = 0; C = 0; D = 0; E = 0; F = 0; G = 0; H = 1; sel = 3'b111;
        #10; $finish;
    end
    
endmodule
