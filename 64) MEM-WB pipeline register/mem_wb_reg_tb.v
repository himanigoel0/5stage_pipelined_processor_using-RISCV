`timescale 1ns / 1ps

module mem_wb_reg_tb();

    reg clk, rst;
    reg [31:0] alu_result_in;  
    reg [31:0] mem_data_read_in; 
    reg [4:0] rd_in;       
    reg regwrite_in;     
    
    wire [31:0] alu_result_out;
    wire [31:0] mem_data_read_out;
    wire [4:0] rd_out;
    wire regwrite_out;
    
    mem_wb_reg uut(
                .clk(clk),
                .rst(rst),
                .alu_result_in(alu_result_in),
                .mem_data_read_in(mem_data_read_in),
                .rd_in(rd_in),
                .regwrite_in(regwrite_in),
                .alu_result_out(alu_result_out),
                .mem_data_read_out(mem_data_read_out),
                .rd_out(rd_out),
                .regwrite_out(regwrite_out)
            );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        alu_result_in = 0;
        mem_data_read_in = 0;
        rd_in = 0;
        regwrite_in = 0;
        
        #10;
        rst = 0;
        alu_result_in = 32'd56;
        mem_data_read_in = 32'd34;
        rd_in = 5'd7;
        regwrite_in = 1;
        
        #10; $finish;        
    end

endmodule
