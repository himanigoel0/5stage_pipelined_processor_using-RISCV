`timescale 1ns / 1ps

module add_sub_pipeline_tb();
    
    reg clk, rst;
    
    wire [31:0] pc_debug, instruction_debug;
    wire [31:0] read_data1_debug, read_data2_debug;
    wire [31:0] alu_result_debug, writeback_data_debug;
    
    wire [31:0] idex_rd1_debug, idex_rd2_debug;
    wire [31:0] alu_src1_debug, alu_src2_forwarded_debug;
    wire [1:0] forwardA_debug, forwardB_debug;
    
    add_sub_pipeline uut (.clk(clk),
                          .rst(rst),
                          .pc_debug(pc_debug),
                          .instruction_debug(instruction_debug),
                          .read_data1_debug(read_data1_debug),
                          .read_data2_debug(read_data2_debug),
                          .alu_result_debug(alu_result_debug),
                          .writeback_data_debug(writeback_data_debug),
                          .idex_rd1_debug(idex_rd1_debug),
                          .idex_rd2_debug(idex_rd2_debug),
                          .alu_src1_debug(alu_src1_debug),
                          .alu_src2_forwarded_debug(alu_src2_forwarded_debug),
                          .forwardA_debug(forwardA_debug),
                          .forwardB_debug(forwardB_debug));
                          
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1;
        #10; rst = 0;
        #200;
        $display("x1=%d", uut.rf.rf[1]);
        $display("x2=%d", uut.rf.rf[2]);
        $display("x3=%d", uut.rf.rf[3]);
        $display("x4=%d", uut.rf.rf[4]);
        $display("x5=%d", uut.rf.rf[5]);
        #10; $finish;
    end
    
    // since we have combinational alu, we are getting the result of ex stage within the same clk cycle only as decode. 
    // so, cycle 1 -> fetch
    //     cycle 2 -> decode + (execute due to combinational alu)
    //     cycle 3 -> mem not used in add/sub, but we see one clk delay due to ex/mem reg
    //     cycle 4 -> so we directly see writeback.
    
endmodule
