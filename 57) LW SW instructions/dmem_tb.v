`timescale 1ns / 1ps

module dmem_tb();

    reg clk, memwrite, memread;
    reg [31:0] addr, write_data;
    wire [31:0] read_data;
    
    dmem uut (.clk(clk),
              .memwrite(memwrite),
              .memread(memread),
              .addr(addr),
              .write_data(write_data),
              .read_data(read_data));
              
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
    
        // Store 100 at address 28
        memwrite = 1;
        memread  = 0;
        addr = 28;
        write_data = 100;
        #10;
    
        // Read from address 28
        memwrite = 0;
        memread  = 1;
        addr = 28;
        
        
        #10; $finish;
    
    end

endmodule