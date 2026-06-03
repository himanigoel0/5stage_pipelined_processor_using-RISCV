`timescale 1ns / 1ps

// synchronous write, asynchronous read.
module ram_16x8_tb();
    reg clk, write_enable;
    reg [7:0] write_data;
    reg [3:0] address;
    wire [7:0] data;
    
    ram_16x8 uut (clk, write_enable, write_data, address, data);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        write_enable = 0; address = 0; write_data = 0;
        #10; write_enable = 1; write_data = 8'h12;
        #10; address = 4'd1; write_data = 8'hAC;
        #10; address = 4'd2; write_data = 8'h45;
        #10; address = 4'd3; write_data = 8'h12;
        #10; address = 4'd4; write_data = 8'hD8;
        #10; address = 4'd5; write_data = 8'hAB;
        #10; address = 4'd6; write_data = 8'hFF;
        #10; address = 4'd7; write_data = 8'h98;
        #10; address = 4'd8; write_data = 8'h82;
        #10; address = 4'd9; write_data = 8'h4C;
        #10; address = 4'd10; write_data = 8'hB1;
        #10; address = 4'd11; write_data = 8'h61;
        #10; address = 4'd12; write_data = 8'hA0;
        #10; address = 4'd13; write_data = 8'h65;
        #10; address = 4'd14; write_data = 8'hF1;
        #10; address = 4'd15; write_data = 8'h20;
        #10; write_enable = 0;
        
        #10; address = 4'd0;
        #10; address = 4'd1;
        #10; address = 4'd2;
        #10; address = 4'd3;
        #10; address = 4'd4;
        #10; address = 4'd5;
        #10; address = 4'd6;
        #10; address = 4'd7;
        #10; address = 4'd8;
        #10; address = 4'd9;
        #10; address = 4'd10;
        #10; address = 4'd11;
        #10; address = 4'd12;
        #10; address = 4'd13;
        #10; address = 4'd14;
        #10; address = 4'd15;
        
        // overwrite data
        #10; write_enable = 1; address = 4'd12; write_data = 34;
        #10; write_enable = 0;
        
        #20; $finish;
        
    end
    
endmodule
