`timescale 1ns / 1ps

module int_mul_tb();
    reg clk, rst;
    wire [31:0] num1, num2;
    wire [31:0] product;
    wire [31:0] pc, instruction;
    
    pipeline uut (.clk(clk),
                  .rst(rst),
                  .pc_debug(pc),
                  .instruction_debug(instruction),
                  .read_data1_debug(num1),
                  .read_data2_debug(num2),
                  .alu_result_debug(product));
                  
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #10; rst = 0;
        #100; $display("x1=%d", uut.rf.rf[1]);
        $display("x2=%d", uut.rf.rf[2]);
        $display("x3=%d", uut.rf.rf[3]);
        $display("x4=%d", uut.rf.rf[4]);
        $display("x5=%d", uut.rf.rf[5]);
        $display("x6=%d", uut.rf.rf[6]);
        $display("x7=%d", uut.rf.rf[7]);
        #10; $finish;
    end
    
endmodule
