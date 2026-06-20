`timescale 1ns / 1ps

module dummy_cache(
    input clk,
    input rst,
    input memread,               // lw request from processor

    output reg cache_miss,
    output reg cache_stall,
    output [1:0] miss_counter_debug
);

    reg [1:0] miss_counter;
    reg miss_serviced;
    
    assign miss_counter_debug = miss_counter;

    always @(posedge clk or posedge rst) begin
    
        if(rst) begin
            cache_miss    <= 0;
            cache_stall   <= 0;
            miss_counter  <= 0;
            miss_serviced <= 0;
        end

        else begin
            // First load generates a miss
            if(memread && !miss_serviced && !cache_stall) begin
                cache_miss    <= 1;
                cache_stall   <= 1;
                miss_counter  <= 2'd3;   // assuming 3-cycle miss penalty
                miss_serviced <= 1;
            end

            // Stall cycles
            else if(cache_stall) begin
                if(miss_counter > 1) begin
                    miss_counter <= miss_counter - 1;
                end
                else begin
                    miss_counter <= 0;
                    cache_stall  <= 0;
                    cache_miss   <= 0;
                end
            end
        end
    end
endmodule