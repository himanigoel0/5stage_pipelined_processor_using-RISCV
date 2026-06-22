`timescale 1ns / 1ps

module riscv_top(
    input clk,
    input rst,
    input [7:0] gpio_in,
    output [7:0] gpio_out
);
    
    wire [31:0] pc_debug;
    wire [31:0] instruction_debug;    
    wire [31:0] read_data1_debug;
    wire [31:0] read_data2_debug;    
    wire [31:0] alu_result_debug;
    wire [31:0] writeback_data_debug;    
    wire [31:0] idex_rd1_debug;
    wire [31:0] idex_rd2_debug;    
    wire [31:0] alu_src1_debug;
    wire [31:0] alu_src2_forwarded_debug;    
    wire [1:0] forwardA_debug;
    wire [1:0] forwardB_debug;    
    wire stall_debug;    
    wire [4:0] memwb_rd_debug;
    wire memwb_regwrite_debug;    
    wire halt_debug;
    wire [31:0] uart_data;
    
    pipeline cpu(
                .clk(clk),
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
                .forwardB_debug(forwardB_debug),
                .stall_debug(stall_debug),
                .memwb_rd_debug(memwb_rd_debug),
                .memwb_regwrite_debug(memwb_regwrite_debug),
                .halt_debug(halt_debug),
                .uart_data(uart_data)
                );
                
    // Placeholder I/O connection   
    // Actual GPIO functionality will be added in the GPIO/MMIO tasks.
    reg [7:0] gpio;   
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            gpio <= 8'b0;
    end
          
    assign gpio_out = gpio;
    
    reg halt_d;
    always @(posedge clk or posedge rst) begin
        if(rst) halt_d <= 0;
        else halt_d <= halt_debug;
    end
    // halt_d is basically storing the previous value of halt_debug signal (flip-flop behaviour)
    
    wire uart_send;
    assign uart_send = halt_debug & ~halt_d;
    
    wire [9:0] tx_frame;

    uart uart_inst(
        .data(uart_data[7:0]),
        .tx_frame(tx_frame)
    );
    
    endmodule
