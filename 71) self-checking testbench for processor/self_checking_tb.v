`timescale 1ns / 1ps

module self_checking_tb();

reg clk;
reg rst;

wire [31:0] pc_debug;
wire [31:0] instruction_debug;
wire [31:0] read_data1_debug;
wire [31:0] read_data2_debug;
wire [31:0] alu_result_debug;
wire [31:0] writeback_data_debug;

integer errors;

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
    forever #5 clk = ~clk;
end

initial begin

    errors = 0;

    rst = 1;
    #20;

    rst = 0;

    // Wait for pipeline execution
    #250;

    //----------------------------------
    // Check x1
    //----------------------------------

    if(dut.rf.rf[1] != 32'd5) begin
        $display("FAIL : x1 = %0d (Expected 5)",
                 dut.rf.rf[1]);
        errors = errors + 1;
    end
    else
        $display("PASS : x1 = %0d",
                 dut.rf.rf[1]);

    //----------------------------------
    // Check x2
    //----------------------------------

    if(dut.rf.rf[2] != 32'd10) begin
        $display("FAIL : x2 = %0d (Expected 10)",
                 dut.rf.rf[2]);
        errors = errors + 1;
    end
    else
        $display("PASS : x2 = %0d",
                 dut.rf.rf[2]);

    //----------------------------------
    // Check x3
    //----------------------------------

    if(dut.rf.rf[3] != 32'd15) begin
        $display("FAIL : x3 = %0d (Expected 15)",
                 dut.rf.rf[3]);
        errors = errors + 1;
    end
    else
        $display("PASS : x3 = %0d",
                 dut.rf.rf[3]);

    //----------------------------------
    // Final Result
    //----------------------------------

    if(errors == 0) begin
        $display("================================");
        $display("      ALL TESTS PASSED");
        $display("================================");
    end

    if(errors > 0) begin
        $display("================================");
        $display(" TEST FAILED : %0d Errors Found",
                 errors);
        $display("================================");
    end

    $finish;

end

endmodule

