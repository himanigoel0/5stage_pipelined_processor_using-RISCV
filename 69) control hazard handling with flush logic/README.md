# Control Hazard Handling using Flush Logic in a 5-Stage RV32I Pipelined Processor

## Objective

The objective of this assignment is to implement and integrate control hazard handling in a 5-stage RV32I pipelined processor using flush logic.

Control hazards occur when branch instructions alter the normal flow of execution. If a branch is taken, instructions that have already entered the pipeline from the sequential path become invalid and must be removed.

The purpose of this assignment is to detect taken branches and flush incorrect instructions from the pipeline.

---

# Pipeline Architecture

The processor follows a standard 5-stage pipeline:

1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execute (EX)
4. Memory Access (MEM)
5. Write Back (WB)

Pipeline registers used:

- IF/ID
- ID/EX
- EX/MEM
- MEM/WB

---

# Understanding Control Hazards

Consider the following example:

```assembly
BEQ x1, x2, TARGET
ADD x3, x4, x5
SUB x6, x7, x8
```

The processor fetches instructions sequentially before knowing whether the branch is taken.

If the branch condition evaluates to TRUE:

```assembly
BEQ x1, x2, TARGET
```

then:

```assembly
ADD x3, x4, x5
SUB x6, x7, x8
```

are wrong-path instructions.

These instructions must not execute.

This situation is called a Control Hazard.

---

# Solution

Flush logic is introduced.

Whenever a branch is detected as TAKEN:

1. Branch target address is calculated.
2. Program Counter is redirected.
3. Wrong instructions already present in the pipeline are replaced by NOPs.
4. Execution resumes from the branch target.

---

# Branch Detection Logic

The branch decision is generated using:

```verilog
assign branch_taken =
       idex_branch &&
       (idex_rd1 == idex_rd2);
```

Explanation:

- idex_branch indicates a branch instruction.
- idex_rd1 and idex_rd2 are source register values.
- For BEQ, branch is taken when both operands are equal.

---

# Flush Signal Generation

Flush signal is generated as:

```verilog
assign flush = branch_taken;
```

Whenever branch_taken becomes HIGH:

- IF/ID register is flushed.
- ID/EX register is flushed.

---

# IF/ID Register Modification

The IF/ID pipeline register was modified to support flushing.

```verilog
if(flush) begin
    pc_out    <= 32'd0;
    instr_out <= 32'h00000013;
end
```

The instruction inserted is:

```text
32'h00000013
```

which corresponds to:

```assembly
ADDI x0, x0, 0
```

This instruction performs no operation and acts as a NOP.

---

# ID/EX Register Modification

The ID/EX register was modified to support flush and stall functionality.

Flush block:

```verilog
else if(flush) begin

    regwrite_out <= 0;
    memread_out  <= 0;
    memwrite_out <= 0;
    branch_out   <= 0;
    jump_out     <= 0;

    alu_control_out <= 0;

    pc_out <= 0;
    read_data1_out <= 0;
    read_data2_out <= 0;
    imm_out <= 0;
    rd_out <= 0;
    opcode_out <= 0;
    rs1_out <= 0;
    rs2_out <= 0;

end
```

This effectively inserts a bubble into the pipeline.

---

# Program Counter Redirection

The next PC value is selected using:

```verilog
assign next_pc =
       branch_taken ?
       (idex_pc + idex_imm) :
       (pc + 32'd4);
```

Operation:

If branch is taken:

```text
PC = Branch Target Address
```

Otherwise:

```text
PC = PC + 4
```

---

# Integration into Top Module

The flush signal is connected to:

### IF/ID Register

```verilog
if_id_reg ifid(
    .flush(flush),
    ...
);
```

### ID/EX Register

```verilog
id_ex_reg idex(
    .flush(flush),
    ...
);
```

The branch decision controls both pipeline registers.

---

# Verification Methodology

Simulation was performed in Vivado.

The following signals were monitored:

- Clock
- Reset
- Program Counter (PC)
- Current Instruction
- Branch Taken
- Flush
- ALU Result
- Write Back Data

Waveforms were analyzed to verify correct flushing behavior.

---

# Expected Behavior

When a branch instruction is taken:

1. branch_taken becomes HIGH.
2. flush becomes HIGH.
3. IF/ID instruction becomes NOP.
4. ID/EX stage becomes a bubble.
5. Program Counter jumps to branch target.
6. Wrong-path instructions are discarded.

---

# Results

Simulation results confirmed:

✔ Correct branch detection.

✔ Correct flush signal generation.

✔ Successful insertion of NOP instructions.

✔ Removal of incorrect instructions from the pipeline.

✔ Correct redirection of Program Counter.

✔ Proper handling of control hazards.

---

# Advantages of Flush Logic

- Simple implementation.
- Easy integration into existing pipeline.
- Prevents execution of invalid instructions.
- Improves correctness of branch execution.

---

# Limitations

- Introduces branch penalty.
- Wastes a few clock cycles when branch is taken.
- Does not predict branch outcomes.

These limitations motivate the use of branch prediction techniques.

---

# Conclusion

Control hazard handling was successfully implemented in the RV32I pipelined processor using flush logic.

Whenever a branch instruction is taken, incorrect instructions already present in the pipeline are flushed and replaced with NOPs. The Program Counter is redirected to the correct branch target, ensuring correct program execution.

The implementation successfully resolves control hazards and improves the reliability of the pipelined processor.
