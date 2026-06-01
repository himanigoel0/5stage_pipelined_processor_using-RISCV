`timescale 1ns / 1ps

module parity_generator_and_checker_tb();
    reg [3:0] D;
    reg P_in;
    wire P, E;
    
    parity_generator_and_checker uut (.D(D), .P_in(P_in), .P(P), .E(E));
    
    initial begin
             D = 0000; P_in = 1;
        #10; D = 0001; P_in = 1;
        #10; D = 0010; P_in = 1;
        #10; D = 0011; P_in = 1;
        #10; D = 0100; P_in = 1;
        #10; D = 0101; P_in = 1;
        #10; D = 0110; P_in = 1;
        #10; D = 0111; P_in = 1;
        #10; D = 1000; P_in = 1;
        #10; D = 1001; P_in = 1;
        #10; D = 1010; P_in = 1;
        #10; D = 1011; P_in = 1;
        #10; D = 1100; P_in = 1;
        #10; D = 1101; P_in = 1;
        #10; D = 1110; P_in = 1;
        #10; D = 1111; P_in = 1;
        #10; D = 0000; P_in = 0;
        #10; D = 0001; P_in = 0;
        #10; D = 0010; P_in = 0;
        #10; D = 0011; P_in = 0;
        #10; D = 0100; P_in = 0;
        #10; D = 0101; P_in = 0;
        #10; D = 0110; P_in = 0;
        #10; D = 0111; P_in = 0;
        #10; D = 1000; P_in = 0;
        #10; D = 1001; P_in = 0;
        #10; D = 1010; P_in = 0;
        #10; D = 1011; P_in = 0;
        #10; D = 1100; P_in = 0;
        #10; D = 1101; P_in = 0;
        #10; D = 1110; P_in = 0;
        #10; D = 1111; P_in = 0;
        
        #10; $finish;
        
        
    end
    
endmodule
