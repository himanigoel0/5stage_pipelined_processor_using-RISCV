`timescale 1ns / 1ps

module mmio_tb();

    reg clk;
    reg rst;

    reg [7:0] gpio_in;
    wire [7:0] gpio_out;
    wire [7:0] led;

    riscv_top uut(
        .clk(clk),
        .rst(rst),
        .gpio_in(gpio_in),
        .gpio_out(gpio_out),
        .led(led)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1; gpio_in = 8'b10110011;   // 179
        #10; rst = 0;
        #300;
        $display("================================");
        $display("FINAL PROCESSOR VALIDATION");
        $display("================================");

        $display("x1       = %d", uut.cpu.rf.rf[1]);
        $display("x2       = %d", uut.cpu.rf.rf[2]);
        $display("x3       = %d", uut.cpu.rf.rf[3]);
        $display("x4       = %d", uut.cpu.rf.rf[4]);
        
        $display("gpio_in  = %d", gpio_in);
        $display("x5       = %d", uut.cpu.rf.rf[5]);
        $display("gpio_out = %d", gpio_out);
        $display("led      = %d", led);

        $display("================================");

        #20; $finish;
    end

endmodule