`timescale 1ns / 1ps

module writeback_tb();
    reg clk;
    reg wr_en;

    // ALU inputs
    reg signed [7:0] num1, num2;
    reg [3:0] operation;
    reg [1:0] opselect;
    reg [2:0] shift_amt;

    // RF signals
    reg [2:0] write_addr;
    reg [2:0] read_addr1, read_addr2;

    wire [15:0] result;
    wire carry, overflow;

    wire [7:0] read_data1, read_data2;
                                 
    initial clk = 0;
    always #5 clk = ~clk;
    
    // ALU
    alu alu_inst(
        .num1(num1),
        .num2(num2),
        .operation(operation),
        .opselect(opselect),
        .shift_amt(shift_amt),
        .result(result),
        .carry(carry),
        .overflow(overflow)
    );

    // Register File
    register_file_8x8_wr_en rf_inst(
        .clk(clk),
        .wr_en(wr_en),
        .write_addr(write_addr),
        .write_data(result[7:0]),    // <- actual writeback
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
                                 
    initial begin

        // -----------------------
        // ADD : 20 + 30 = 50
        // Write result into R1
        // -----------------------

        wr_en      = 1;
        num1       = 20;
        num2       = 30;
        operation  = 4'b0010;   // ADD
        opselect   = 0;
        shift_amt  = 0;
        write_addr = 3'd1;
        read_addr1 = 3'd1;
        read_addr2 = 3'd0;

        // Read back R1

        // -----------------------
        // SUB : 20 - 30 = -10
        // Write result into R2
        // -----------------------

        #10;
        num1       = 20;
        num2       = 30;
        operation  = 4'b0011;   // SUB
        write_addr = 3'd2;
        read_addr1 = 3'd2;

        // Read back R2

        #10; $finish;

    end
    
endmodule
