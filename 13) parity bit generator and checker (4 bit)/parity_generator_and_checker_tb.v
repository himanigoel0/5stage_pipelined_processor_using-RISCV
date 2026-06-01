`timescale 1ns / 1ps

module parity_generator_and_checker_tb();
    reg [3:0] D;
    reg P_in;
    wire P, E;
    
    parity_generator_and_checker uut (.D(D), .P_in(P_in), .P(P), .E(E));
    
    initial begin
             D = 4'b0000; P_in = 1'b1;
        #10; D = 4'b0001; P_in = 1'b1;
        #10; D = 4'b0010; P_in = 1'b1;
        #10; D = 4'b0011; P_in = 1'b1;
        #10; D = 4'b0100; P_in = 1'b1;
        #10; D = 4'b0101; P_in = 1'b1;
        #10; D = 4'b0110; P_in = 1'b1;
        #10; D = 4'b0111; P_in = 1'b1;
        #10; D = 4'b1000; P_in = 1'b1;
        #10; D = 4'b1001; P_in = 1'b1;
        #10; D = 4'b1010; P_in = 1'b1;
        #10; D = 4'b1011; P_in = 1'b1;
        #10; D = 4'b1100; P_in = 1'b1;
        #10; D = 4'b1101; P_in = 1'b1;
        #10; D = 4'b1110; P_in = 1'b1;
        #10; D = 4'b1111; P_in = 1'b1;
        #10; D = 4'b0000; P_in = 1'b0;
        #10; D = 4'b0001; P_in = 1'b0;
        #10; D = 4'b0010; P_in = 1'b0;
        #10; D = 4'b0011; P_in = 1'b0;
        #10; D = 4'b0100; P_in = 1'b0;
        #10; D = 4'b0101; P_in = 1'b0;
        #10; D = 4'b0110; P_in = 1'b0;
        #10; D = 4'b0111; P_in = 1'b0;
        #10; D = 4'b1000; P_in = 1'b0;
        #10; D = 4'b1001; P_in = 1'b0;
        #10; D = 4'b1010; P_in = 1'b0;
        #10; D = 4'b1011; P_in = 1'b0;
        #10; D = 4'b1100; P_in = 1'b0;
        #10; D = 4'b1101; P_in = 1'b0;
        #10; D = 4'b1110; P_in = 1'b0;
        #10; D = 4'b1111; P_in = 1'b0;
        
        #10; $finish;
        
        
    end
    
endmodule
