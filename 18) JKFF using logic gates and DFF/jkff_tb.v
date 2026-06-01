`timescale 1ns / 1ps

module jkff_tb();
    reg clk, rst, J, K;
    wire Q;
    
    jkff uut (.J(J), .K(K), .clk(clk), .rst(rst), .Q(Q));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1; J = 0; K = 0;
        #10; rst = 0; J = 1; K = 0;
        #10; J = 1; K = 1;  // toggle
        #10; J = 0; K = 1;  // rst
        #10; J = 1; K = 0;  // set
        #10; J = 0; K = 0;  // hold
        #14; rst = 1;       // async rst
        #10; $finish;
        
    end

endmodule
