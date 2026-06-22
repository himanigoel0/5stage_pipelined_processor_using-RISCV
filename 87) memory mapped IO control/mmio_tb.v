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
        rst = 1; gpio_in = 8'b10110011;   // 179 decimal
        #10; rst = 0;
        #300;
        $display("x5         = %d", uut.cpu.rf.rf[5]);
        $display("x6         = %d", uut.cpu.rf.rf[6]);
        $display("x7         = %d", uut.cpu.rf.rf[7]);
        $display("LED Output = %b", led);
        #20; $finish;
    end

endmodule