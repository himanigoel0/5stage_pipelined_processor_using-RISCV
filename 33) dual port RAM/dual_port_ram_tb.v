`timescale 1ns / 1ps

module dual_port_ram_tb();
    reg clk;
    reg [3:0] write_address, read_address;
    reg [7:0] write_data;
    reg write_enable;
    wire [7:0] read_data;
    
    dual_port_ram uut (clk, write_address, read_address, write_data, write_enable, read_data);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        write_enable = 1; write_address = 0; write_data = 8'h12; read_address = 0;
        #10; write_address = 1; write_data = 8'h23;
        #10; write_address = 2; write_data = 8'hAB;
        #10; write_address = 3; write_data = 8'h8C;
        #10; write_address = 4; write_data = 8'h4D;
        #10; write_address = 5; write_data = 8'hB4;
        #10; write_address = 6; write_data = 8'h66;
        #10; write_address = 7; write_data = 8'h98;
        #10; write_address = 8; write_data = 8'hC4;
        #10; write_address = 9; write_data = 8'h98;
        #10; write_address = 10; write_data = 8'hD3;
        #10; write_address = 11; write_data = 8'hE4;
        #10; write_address = 12; write_data = 8'h15;
        #10; write_address = 13; write_data = 8'h02;
        #10; write_address = 14; write_data = 8'h1B;
        #10; write_address = 15; write_data = 8'hC7;
        #10; write_enable = 0;
        
        #10; read_address = 0;
        #10; read_address = 1; 
        #10; read_address = 2; 
        #10; read_address = 3; 
        #10; read_address = 4; 
        #10; read_address = 5; 
        #10; read_address = 6; 
        #10; read_address = 7; 
        #10; read_address = 8; 
        #10; read_address = 9; 
        #10; read_address = 10;
        #10; read_address = 11;
        #10; read_address = 12;
        #10; read_address = 13;
        #10; read_address = 14;
        #10; read_address = 15;
        
        // dual port ram, read and write at different addresses.
        #10; write_enable  = 1; write_address = 4'd5; write_data = 8'hAA; read_address  = 4'd2;

#10;
        
        #20; $finish;
        
    end
    
endmodule
