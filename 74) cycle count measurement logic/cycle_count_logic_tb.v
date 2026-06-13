`timescale 1ns / 1ps

module cycle_count_logic_tb();

    reg clk;
    reg rst;

    wire [7:0] cycle_count;

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

        .cycle_count(cycle_count),

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
        forever #5 clk = ~clk;   // 10ns period
    end

    // Stimulus
    initial begin

        rst = 1;
        #10;

        rst = 0;

        #200;

        $display("--------------------------------");
        $display("Cycle Count = %0d", cycle_count);
        $display("--------------------------------");

        $finish;

    end

endmodule