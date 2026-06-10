`timescale 1ns / 1ps

module if_id_reg_tb();
    reg clk;
    reg rst;
    reg [31:0] pc_in;
    reg [31:0] instr_in;
    wire [31:0] pc_out;
    wire [31:0] instr_out;
    
    if_id_reg uut (clk, rst, pc_in, instr_in, pc_out, instr_out);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1; pc_in = 0; instr_in = 32'd79;
        #10; rst = 0; pc_in = 100; instr_in = 32'h00A00093; 
        #50; $finish;
    end

endmodule
