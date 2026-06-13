# Assignment: CPI (Cycles Per Instruction) Measurement for a 5-Stage Pipelined Processor

## Objective

To measure the CPI (Cycles Per Instruction) of a sample program executing on the implemented 5-stage pipelined RISC-V processor.

---

## Theory

CPI is a commonly used performance metric in processor design and is defined as:

CPI = Total Clock Cycles / Total Instructions Executed

A lower CPI generally indicates better processor performance because fewer clock cycles are required per instruction.

---

## Implementation

A cycle counter was added to the top-level processor module. The counter is reset during processor reset and increments on every positive clock edge.

```verilog
always @(posedge clk or posedge rst) begin
    if(rst)
        cycle_count <= 0;
    else
        cycle_count <= cycle_count + 1;
end
```

An instruction counter was also added. The counter increments whenever an instruction reaches its completion stage in the pipeline.

The retirement conditions used were:

* Register-writing instructions (ADD, SUB, ADDI, LW)
* Store instructions (SW)
* Branch instructions (BEQ)

```verilog
assign instr_retired =
       memwb_regwrite ||
       exmem_memwrite ||
       exmem_branch;
```

---

## Testbench

A dedicated testbench was created to:

1. Generate the processor clock.
2. Apply reset.
3. Allow the processor to execute the loaded sample program.
4. Display the cycle count, instruction count, and CPI value.

CPI was calculated using:

```verilog
cpi = cycle_count * 1.0 / instruction_count;
```

---

## Simulation Results

Observed Output:

Cycle Count       = 20

Instruction Count = 17

CPI               = 1.176471

---

## Discussion

The sample program itself contains only a small number of meaningful instructions.

However, after the program completes, the processor continues fetching instructions from the remaining locations of instruction memory.

Unused instruction memory locations are initialized as:

```verilog
32'h00000013
```

which corresponds to:

ADDI x0, x0, 0

This instruction acts as a NOP (No Operation).

Since the simulation was allowed to continue running for a fixed amount of time, additional NOP instructions were fetched and passed through the pipeline. These NOPs contributed to the observed instruction count.

Therefore, the measured instruction count is larger than the number of meaningful instructions originally present in the sample program.

The reported CPI corresponds to the entire simulated execution window, including the execution of these fetched NOP instructions.

---

## Conclusion

Cycle count measurement logic was successfully implemented and verified.

Instruction retirement counting was integrated into the processor and used to calculate CPI.

Simulation produced the following results:

* Total Cycles = 20
* Retired Instructions = 17
* CPI = 1.176471

The experiment demonstrates how processor performance can be evaluated using cycle counting and instruction retirement statistics in a pipelined processor.
