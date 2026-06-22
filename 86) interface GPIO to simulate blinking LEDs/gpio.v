module gpio(
    input clk,
    input rst,
    input [7:0] data,
    output reg [7:0] led
);

    reg toggle;

    always @(posedge clk) begin
        if (rst) toggle <= 0;
        else toggle <= ~toggle;
    end

    always @(*) begin
        if(toggle) led = data;
        else led = 8'b0;
    end

endmodule