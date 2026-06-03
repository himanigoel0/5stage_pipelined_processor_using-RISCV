`timescale 1ns / 1ps

// 16x8 ROM means 16 memory locations, each location stores 8 bit data.
// since we have 16 locations, we need 4 bits to represent address.

// ROM is read only. The output depends only on the address input, so it is modeled as combinational logic.
// And hence, we do not require any clk in this ROM.

// BEHAVIORAL VERILOG  

module rom_16x8(
    input [3:0] address,
    output reg [7:0] data
);

    reg [7:0] rom [15:0];
    
    initial begin
        rom[0] = 8'h01;
        rom[1] = 8'h21;
        rom[2] = 8'hA1;
        rom[3] = 8'h0C;
        rom[4] = 8'h5D;
        rom[5] = 8'hA9;
        rom[6] = 8'h98;
        rom[7] = 8'hB6;
        rom[8] = 8'hEE;
        rom[9] = 8'hF6;
        rom[10] = 8'h82;
        rom[11] = 8'h91;
        rom[12] = 8'hCC;
        rom[13] = 8'hAD;
        rom[14] = 8'hBC;
        rom[15] = 8'h12;
    end
    
    always @(*) begin
        data = rom[address];
    end

endmodule
