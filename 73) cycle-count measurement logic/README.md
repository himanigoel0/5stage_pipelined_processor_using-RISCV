### Objective:
Implement cycle count measurement logic in the 5-stage pipelined processor.

### Implementation:
An 8-bit cycle counter was added to the top module. The counter resets to 0 during reset and increments on every positive edge of the clock.

### Verification:
A dedicated testbench was created to run the processor for a fixed duration. The simulation ran for 210 ns with reset active for the first 10 ns and a clock period of 10 ns.

### Result:
The cycle counter reported 20 cycles, matching the expected number of executed clock cycles.

### Output:
Cycle Count = 20

### Conclusion:
The cycle count measurement logic was successfully implemented and verified.
