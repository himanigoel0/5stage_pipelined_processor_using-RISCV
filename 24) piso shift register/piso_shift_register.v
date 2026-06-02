`timescale 1ns / 1ps

module piso_shift_register(
    input clk, rst, load,
    input [3:0] parallel_in,
    output serial_out
);
    reg [3:0] Q;

    // whenever load signal is high, we load the parallel_in to the register.
    always @(posedge clk or posedge rst) begin
        if (rst) Q <= 4'b0000;
        else if (load) Q <= parallel_in;
        else begin
            Q[3] <= 1'b0;
            Q[2] <= Q[3];
            Q[1] <= Q[2];
            Q[0] <= Q[1];
        end
    end
    // we could also do Q <= {1'b0, Q[3:1]};
    
    assign serial_out = Q[0];
    // this will ensure that we have the currentmost value of the LSB. 
    // Else, Q[0] may be undefined until the first clk edge.
    
endmodule
