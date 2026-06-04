`timescale 1ns / 1ps

module register_file_8x8_wr_en_tb();
    reg clk, wr_en;
    reg [2:0] write_addr;
    reg [7:0] write_data;
    reg [2:0] read_addr1, read_addr2;
    wire [7:0] read_data1, read_data2;

    register_file_8x8_wr_en uut (clk, wr_en, write_addr, write_data, read_addr1, read_addr2, read_data1, read_data2);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        // writing to each port initially because they are 0 by default.
        wr_en = 1; write_addr = 3'b000; write_data = 8'hAB; read_addr1 = 0; read_addr2 = 0;
        #10; write_addr = 3'b001; write_data = 8'h20;
        #10; write_addr = 3'b010; write_data = 8'h1C;
        #10; write_addr = 3'b011; write_data = 8'h8D;
        #10; write_addr = 3'b100; write_data = 8'hB5;
        #10; write_addr = 3'b101; write_data = 8'h67;
        #10; write_addr = 3'b110; write_data = 8'h9B;
        #10; write_addr = 3'b111; write_data = 8'h3E;
        
        // reading the rf using 2 simultaneous read ports
        #10; wr_en = 0; read_addr1 = 3'b000; read_addr2 = 3'b001;
        #10; read_addr1 = 3'b010; read_addr2 = 3'b011;
        #10; read_addr1 = 3'b100; read_addr2 = 3'b101;
        #10; read_addr1 = 3'b110; read_addr2 = 3'b111;
        
        // read and write together, using all the 3 ports together.
        #10; wr_en = 1; write_addr = 3'b101; write_data = 8'h12; read_addr1 = 3'b010; read_addr2 = 3'b111;
        #10; wr_en = 1; write_addr = 3'b110; write_data = 8'h87; read_addr1 = 3'b101; read_addr2 = 3'b001;
        #10; wr_en = 1; write_addr = 3'b100; write_data = 8'h91; read_addr1 = 3'b110; read_addr2 = 3'b011;
        #10; wr_en = 1; write_addr = 3'b010; write_data = 8'hD4; read_addr1 = 3'b100; read_addr2 = 3'b001;
        #10; wr_en = 0;
        
        // test overwrite;
        #10; read_addr1 = 3'b101; read_addr2 = 3'b110;
        
        #20; $finish;
        
    end
    
endmodule
