`timescale 1ns / 1ps

module imem_32_tb();

    reg [31:0] address;
    wire [31:0] instruction;

    imem_32 uut(
        .address(address),
        .instruction(instruction)
    );

    initial begin

        address = 0;
        #10; address = 4;
        #10; address = 8;
        #10; address = 12;
        #10; address = 16;
        #10; address = 20;
        #10; address = 200;

        #10; $finish;

    end

endmodule