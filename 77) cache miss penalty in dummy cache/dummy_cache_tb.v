`timescale 1ns / 1ps

module dummy_cache_tb();

    reg clk;
    reg rst;
    reg memread;

    wire cache_miss;
    wire cache_stall;
    wire [1:0] miss_counter_debug;

    dummy_cache dut(
        .clk(clk),
        .rst(rst),
        .memread(memread),
        .cache_miss(cache_miss),
        .cache_stall(cache_stall),
        .miss_counter_debug(miss_counter_debug)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        // Reset
        rst = 1;
        memread = 0;

        #10;
        rst = 0;

        // Generate one load request
        #10;
        memread = 1;

        #10;
        memread = 0;

        // Observe miss penalty

        #100;
        $finish;

    end

endmodule