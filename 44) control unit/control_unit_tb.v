`timescale 1ns / 1ps

module control_unit_tb();

    reg [3:0] operation;
    wire regwrite;
    wire [3:0] alucontrol;

    control_unit uut (operation, regwrite, alucontrol);
    
    initial begin
        operation = 4'd0;
        #10; operation = 4'd1;
        #10; operation = 4'd2;
        #10; operation = 4'd3;
        #10; operation = 4'd4;
        #10; operation = 4'd5;
        #10; operation = 4'd6;
        #10; operation = 4'd7;
        #10; operation = 4'd8;
        #10; operation = 4'd9;
        #10; operation = 4'd10;
        #10; operation = 4'd11;
        #10; $finish;
    end
    
endmodule
