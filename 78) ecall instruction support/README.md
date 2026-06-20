# ECALL Instruction Support in 5-Stage Pipelined RV32I Processor

## Objective

The objective of this task is to extend the existing 5-stage pipelined RV32I processor by adding support for the ECALL (Environment Call) instruction and verifying its behavior through simulation waveforms.

---

# Introduction

ECALL stands for:

```text
Environment Call
```

It is a special RISC-V instruction used by software to request services from the execution environment or operating system.

In a complete RISC-V system, ECALL is typically used for:

* System calls
* Printing output
* Reading input
* File operations
* Program termination
* Operating system services

---

# Real Processor Behavior

In a real RISC-V processor, execution of an ECALL instruction causes an exception (trap).

The processor transfers control to the operating system:

```text
User Program
      ↓
    ECALL
      ↓
 Exception/Trap
      ↓
 Operating System
      ↓
 Return to Program
```

Therefore, ECALL itself does not terminate the processor.

Instead, it requests a service from the operating system.

---

# Simplified Implementation

Our processor does not implement:

* Operating System
* Trap Handler
* CSR Registers
* Privilege Modes
* Exception Handling

Therefore, a simplified behavior was implemented.

When an ECALL instruction is detected:

```text
ECALL Detected
      ↓
HALT Signal Generated
      ↓
PC Updates Disabled
      ↓
Processor Stops Execution
```

Thus, ECALL behaves as a halt instruction in our processor.

---

# ECALL Instruction Encoding

Machine Code:

```text
00000073
```

Opcode:

```text
1110011
```

This opcode was added to the control unit.

---

# Control Unit Modifications

A new control signal was introduced:

```verilog
output reg ecall;
```

Default value:

```verilog
ecall = 0;
```

Additional case added:

```verilog
7'b1110011: begin
    ecall = 1;
end
```

When the decoder encounters opcode:

```text
1110011
```

the control unit asserts the ECALL signal.

---

# Halt Signal Generation

Initially, the halt signal was generated using:

```verilog
assign halt = ecall;
```

However, this implementation was incorrect.

---

# Why Direct Assignment Failed

The ECALL signal exists only while the instruction is present in the Decode stage.

Therefore:

```text
ECALL in Decode
      ↓
ecall = 1
      ↓
halt = 1
```

Only for one clock cycle.

After the instruction leaves Decode:

```text
ecall = 0
```

and therefore:

```text
halt = 0
```

again.

As a result, the processor resumed execution instead of stopping permanently.

---

# Correct Solution

The halt signal was converted into a register.

```verilog
reg halt;
```

The following logic was implemented:

```verilog
always @(posedge clk or posedge rst)
begin

    if(rst)
        halt <= 0;

    else if(ecall)
        halt <= 1;

end
```

---

# Why This Works

Initially:

```text
halt = 0
```

When ECALL is decoded:

```text
halt = 1
```

Once set, the halt register remains asserted because no logic exists that clears it.

Thus:

```text
0 → 1 → 1 → 1 → 1 → 1 ...
```

This permanently halts processor execution.

---

# PC Freeze Mechanism

The PC module already contains an enable signal:

```verilog
.en(~stall & !halt)
```

When:

```text
halt = 1
```

the enable signal becomes:

```text
0
```

and therefore:

```text
PC stops updating.
```

---

# Pipeline Observation

An interesting observation was made during simulation.

The ECALL instruction was fetched at:

```text
PC = 8
```

However, the processor stopped at:

```text
PC = 16
```

instead of PC = 8.

---

# Why Did This Happen?

The processor cannot determine instruction type during the Fetch stage.

At:

```text
PC = 8
```

the processor only fetches raw instruction bits:

```text
00000073
```

The meaning of the instruction becomes known only after reaching the Decode stage.

Pipeline timeline:

```text
Cycle 1
PC=8
Fetch ECALL

Cycle 2
Decode ECALL
Generate ecall signal

Cycle 3
halt register set

Cycle 4
PC updates disabled
```

During this interval, the PC had already advanced to later addresses.

Therefore, the processor finally froze at:

```text
PC = 16
```

This behavior is expected in a pipelined processor.

---

# Waveform Verification

Simulation results show:

* ECALL instruction fetched successfully.
* ECALL decoded correctly.
* Halt signal asserted.
* Program Counter stopped updating.
* Processor execution permanently halted.

Observed behavior:

```text
PC:
0 → 4 → 8 → 12 → 16 → 16 → 16 → 16 ...
```

Observed halt signal:

```text
halt:
0 → 0 → 0 → 1 → 1 → 1 → 1 ...
```

This confirms successful implementation.

---

# Conclusion

Support for the ECALL instruction was successfully added to the 5-stage pipelined RV32I processor.

The control unit correctly detects opcode:

```text
1110011
```

and generates an ECALL signal.

A registered halt mechanism was implemented to permanently stop execution. Simulation waveforms verify that the processor correctly halts after ECALL detection and prevents further PC updates.

Thus, ECALL support was successfully integrated and verified.
