`timescale 1ns / 1ps

module imem_tb();

    reg [7:0] address;
    wire [15:0] instruction;
    
    imem uut (address, instruction);
    
    initial begin
        address = 0;
        #10; address = 1;
        #10; address = 2;
        #10; address = 3;
        #10; address = 4;
        #10; address = 5;
        #10; address = 6;
        #10; address = 7;
        #10; address = 8;
        #10; address = 9;
        #10; address = 10;
        #10; address = 11;
        #10; address = 25;
        #10; address = 100;
        #10; address = 255;
        #10; $finish;
    end

endmodule
