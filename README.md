# From Logic Gates to a Complete RV32I 5-Stage Pipelined RISC-V Processor in Verilog

This repository documents my complete journey from basic digital logic design to building a fully functional RV32I 5-stage pipelined RISC-V processor in Verilog HDL.

The project begins with fundamental combinational and sequential circuits such as adders, multiplexers, decoders, counters, FSMs, memories, and ALU design. These building blocks are then integrated step-by-step into a complete RISC-V processor featuring instruction execution, pipelining, hazard handling, forwarding, UART communication, GPIO interfacing, Memory-Mapped I/O (MMIO), and complete program execution.

All modules were designed, simulated, tested, and verified using Xilinx Vivado.

---

# Project Roadmap

## Phase 1: Combinational Logic Design

- Half Adder
- Full Adder
- Ripple Carry Adder
- Subtractor
- Multiplexers
- Demultiplexer
- Decoder
- Priority Encoder
- Comparators
- Parity Generator and Checker
- Binary ↔ Gray Code Converters

---

## Phase 2: Sequential Logic Design

- D Flip-Flop
- T Flip-Flop
- JK Flip-Flop
- Binary Counters
- Decade Counter
- Ring Counter
- Johnson Counter
- Shift Registers

---

## Phase 3: Finite State Machines

- Sequence Detector
- Vending Machine Controller
- Traffic Light Controller
- Password Lock System
- Digital Clock

---

## Phase 4: Memory Design

- ROM
- RAM
- Dual-Port RAM
- Register File

---

## Phase 5: Datapath Components

- Arithmetic Logic Unit (ALU)
- Overflow Detection
- Barrel Shifter
- Signed Multiplication
- Program Counter (PC)
- Instruction Memory

---

## Phase 6: Processor Development

- Fetch Stage
- Decode Stage
- Execute Stage
- Memory Stage
- Write Back Stage
- Control Unit
- Immediate Generator
- Register File Integration
- Instruction Execution

---

## Phase 7: Pipeline Implementation

- IF-ID Register
- ID-EX Register
- EX-MEM Register
- MEM-WB Register
- Complete 5-Stage Pipeline

---

## Phase 8: Hazard Handling

- Hazard Detection Unit
- Stall Generation
- Forwarding Unit
- Bubble Insertion
- Control Hazard Handling
- Static Branch Prediction

---

## Phase 9: RV32I Instruction Support

Implemented support for:

- R-Type Instructions
- I-Type Instructions
- Load Instructions
- Store Instructions
- Branch Instructions
- JAL
- LUI
- AUIPC
- ECALL

---

## Phase 10: Program Execution

- Arithmetic Programs
- Register Verification Programs
- Fibonacci Sequence Generation
- Array Sum Program
- Custom Assembly Programs

---

## Phase 11: Peripheral Interfaces

- UART Output Simulation
- GPIO Interface
- Memory-Mapped I/O (MMIO)

---

## Phase 12: Final Verification

- Arithmetic Validation
- Forwarding Validation
- Load Hazard Validation
- MMIO Validation
- End-to-End Processor Testing

---

# Final Processor Features

- RV32I 32-bit ISA Support
- 32-bit Datapath
- 5-Stage Pipeline
- Forwarding Unit
- Hazard Detection Unit
- Branch Handling Logic
- Register File (32 × 32)
- Instruction Memory
- Data Memory
- UART Interface
- GPIO Interface
- Memory-Mapped I/O
- ECALL Support
- LUI Support
- AUIPC Support
- Signed Multiplication Support
- Program Execution from Memory

---

# Pipeline Architecture

```text
          +---------+
          |   IF    |
          +---------+
               |
               v
          +---------+
          |   ID    |
          +---------+
               |
               v
          +---------+
          |   EX    |
          +---------+
               |
               v
          +---------+
          |  MEM    |
          +---------+
               |
               v
          +---------+
          |   WB    |
          +---------+
```

Pipeline Registers:

```text
IF/ID
ID/EX
EX/MEM
MEM/WB
```

---

# Memory-Mapped I/O

| Address | Function |
|----------|----------|
| 0xF0 | GPIO Output Register |
| 0xF1 | GPIO Input Register |

Example:

```assembly
lw   x5,241(x0)
addi x5,x5,1
sw   x5,240(x0)
ecall
```

Input:

```text
gpio_in = 179
```

Output:

```text
gpio_out = 180
led      = 180
```

---

# UART Interface

UART output simulation was implemented to observe processor-generated output frames during simulation.

Example:

```assembly
addi x5,x0,72
ecall
```

ASCII Value:

```text
72 = 'H'
```

Generated UART Frame:

```text
1010010000
```

---

# Verification Programs

The processor was validated using:

- Arithmetic Programs
- Forwarding Tests
- Load Hazard Tests
- Fibonacci Program
- Array Sum Program
- UART Validation
- GPIO Validation
- MMIO Validation

All programs produced expected outputs during simulation.

---

# Tools Used

- Verilog HDL
- Xilinx Vivado
- Vivado Simulator
- Git
- GitHub

---

# Learning Outcomes

This project provided hands-on experience in:

- Digital Logic Design
- Sequential Circuit Design
- Finite State Machines
- Memory Design
- ALU Design
- Computer Architecture
- RISC-V ISA
- RTL Design
- Pipelined Processor Design
- Hazard Resolution
- Peripheral Interfacing
- Verification and Debugging

---

# Repository Highlights

This repository contains 88+ progressively developed modules covering:

- Basic Digital Electronics
- Combinational Logic
- Sequential Logic
- FSM Design
- Memory Design
- Datapath Design
- RISC-V Architecture
- Pipelined Processor Design
- Peripheral Integration
- Final System Validation

The project demonstrates the complete path from logic gates to a functional RV32I 5-stage pipelined RISC-V processor.

---
