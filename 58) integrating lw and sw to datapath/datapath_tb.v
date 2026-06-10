`timescale 1ns / 1ps

module datapath_tb();

    reg clk;
    reg rst;
    
    wire [31:0] pc_debug;
    wire [31:0] instruction_debug;
    wire [31:0] read_data1_debug;
    wire [31:0] read_data2_debug;
    wire [31:0] alu_result_debug;
    wire [31:0] mem_read_data_debug;
    wire [31:0] writeback_data_debug;

    datapath uut(
        .clk(clk),
        .rst(rst),
        .pc_debug(pc_debug),
        .instruction_debug(instruction_debug),
        .read_data1_debug(read_data1_debug),
        .read_data2_debug(read_data2_debug),
        .alu_result_debug(alu_result_debug),
        .mem_read_data_debug(mem_read_data_debug),
        .writeback_data_debug(writeback_data_debug)
    );

    // clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #20; rst = 0;

        // run for some cycles
        #200; $finish;
    end
    
//      Hex	        Instruction	        Expected Result
//  00A00093       	 addi x1,x0,10	    x1=10
//  01400113       	 addi x2,x0,20	    x2=20
//  002081B3       	 add x3,x1,x2	    x3=30
//  00302023       	 sw x3,0(x0)	    mem[0]=30
//  00002203       	 lw x4,0(x0)	    x4=30
//  00F0E293       	 ori x5,x1,15	    x5=15
//  0140A313       	 slti x6,x1,20	    x6=1
//  00108463       	 beq x1,x1,8	    branch taken
//  0080046F       	 jal x8,8	        x8=40
//  05800513       	 addi x10,x0,88	    x10=88

endmodule