`timescale 1ns / 1ps

module rf_32x32_tb();
    reg clk, wr_en;
    reg [4:0] write_addr, read_addr1, read_addr2;
    reg [31:0] write_data;
    
    wire [31:0] read_data1, read_data2;
    
    rf_32x32 uut (clk, wr_en, write_addr, read_addr1, read_addr2, write_data, read_data1, read_data2);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        wr_en = 1; read_addr1 = 0; read_addr2 = 1;
        #00; write_addr = 0; write_data = 15;
        #10; write_addr = 1; write_data = 92;
        #10; write_addr = 2; write_data = 17;
        #10; write_addr = 3; write_data = 82;
        #10; write_addr = 4; write_data = 63;
        #10; write_addr = 5; write_data = 86;
        #10; write_addr = 6; write_data = 9;
        #10; write_addr = 7; write_data = 28;
        #10; write_addr = 8; write_data = 37;
        #10; write_addr = 9; write_data = 45;
        #10; write_addr = 10; write_data = 86;
        #10; write_addr = 11; write_data = 10;
        #10; write_addr = 12; write_data = 24;
        #10; write_addr = 13; write_data = 28;
        #10; write_addr = 14; write_data = 96;
        #10; write_addr = 15; write_data = 46;
        #10; write_addr = 16; write_data = 76;
        #10; wr_en = 0;     // hold operation
        #50; write_addr = 17; write_data = 71;
        #10; write_addr = 18; write_data = 62;
        #10; write_addr = 19; write_data = 14;
        #10; write_addr = 20; write_data = 91;
        #10; write_addr = 21; write_data = 77;
        #10; write_addr = 22; write_data = 66;
        #10; write_addr = 23; write_data = 55;
        #10; write_addr = 24; write_data = 44;
        #10; write_addr = 25; write_data = 33;
        #10; write_addr = 26; write_data = 22;
        #10; write_addr = 27; write_data = 11;
        #10; write_addr = 28; write_data = 70;
        #10; write_addr = 29; write_data = 80;
        #10; write_addr = 30; write_data = 28;
        #10; write_addr = 31; write_data = 57;
        #10; wr_en = 0;
        
        #10; read_addr1 = 0; read_addr2 = 1;
        #10; read_addr1 = 2; read_addr2 = 3;
        #10; read_addr1 = 4; read_addr2 = 5;
        #10; read_addr1 = 6; read_addr2 = 7;
        #10; read_addr1 = 8; read_addr2 = 9;
        #10; read_addr1 = 10; read_addr2 = 11;
        #10; read_addr1 = 12; read_addr2 = 13;
        #10; read_addr1 = 14; read_addr2 = 15;
        #10; read_addr1 = 16; read_addr2 = 17;
        #10; read_addr1 = 18; read_addr2 = 19;
        #10; read_addr1 = 20; read_addr2 = 21;
        #10; read_addr1 = 22; read_addr2 = 23;
        #10; read_addr1 = 24; read_addr2 = 25;
        #10; read_addr1 = 26; read_addr2 = 27;
        #10; read_addr1 = 28; read_addr2 = 29;
        #10; read_addr1 = 30; read_addr2 = 31;
        
        #10; $finish;
        
    end
    
endmodule
