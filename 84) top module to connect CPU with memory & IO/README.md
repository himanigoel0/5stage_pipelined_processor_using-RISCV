# Building a top module to connect CPU with memory & I/O

A top-level integration module (riscv_top) was created.

The module instantiates the RV32I 5-stage pipelined CPU and provides external GPIO interfaces for future peripheral integration.

Instruction memory and data memory remain connected within the processor subsystem, while GPIO ports are exposed at the system level for upcoming UART and memory-mapped I/O extensions.
