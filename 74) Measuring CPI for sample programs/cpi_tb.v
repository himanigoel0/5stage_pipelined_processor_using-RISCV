`timescale 1ns / 1ps

module cpi_tb();

    reg clk;
    reg rst;

    wire [7:0] cycle_count;
    wire [7:0] instruction_count;

    wire [31:0] pc_debug;
    wire [31:0] instruction_debug;
    wire [31:0] read_data1_debug;
    wire [31:0] read_data2_debug;
    wire [31:0] alu_result_debug;
    wire [31:0] writeback_data_debug;

    real cpi;   // because we need it for calculation further, and it would be a real number.

    add_sub_pipeline dut(
        .clk(clk),
        .rst(rst),
        .cycle_count(cycle_count),
        .instruction_count(instruction_count),
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
        forever #5 clk = ~clk;   // 10ns clock period
    end

    // Test sequence
    initial begin

        rst = 1;
        #10; rst = 0;

        // Let processor run
        #200;

        if(instruction_count != 0)
            cpi = cycle_count * 1.0 / instruction_count;
        else
            cpi = 0;

        $display("====================================");
        $display("Cycle Count       = %0d", cycle_count);
        $display("Instruction Count = %0d", instruction_count);
        $display("CPI               = %0f", cpi);
        $display("====================================");

        $finish;

    end

endmodule