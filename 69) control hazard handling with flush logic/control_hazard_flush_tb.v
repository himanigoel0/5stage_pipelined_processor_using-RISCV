`timescale 1ns / 1ps

module control_hazard_flush_tb();

    reg clk;
    reg rst;

    wire [31:0] pc_debug;
    wire [31:0] instruction_debug;
    wire [31:0] read_data1_debug;
    wire [31:0] read_data2_debug;
    wire [31:0] alu_result_debug;
    wire [31:0] writeback_data_debug;

    // DUT
    add_sub_pipeline dut(
        .clk(clk),
        .rst(rst),

        .pc_debug(pc_debug),
        .instruction_debug(instruction_debug),

        .read_data1_debug(read_data1_debug),
        .read_data2_debug(read_data2_debug),

        .alu_result_debug(alu_result_debug),

        .writeback_data_debug(writeback_data_debug)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;     // 10ns period
    end

    // Reset
    initial begin
        rst = 1;

        #10;
        rst = 0;

        #100;
        $finish;
    end

endmodule