# Pipelined RISC-V Processor
This is a verilog code for a 5-stage pipelined RISC-V Processor with forwarding functionality. Here is the circuit diagramme of the processor.
![image](https://github.com/user-attachments/assets/9d113bb3-596b-410d-bbd4-0b2faaa26190)


## Features
- 32-bit Instruction Format
- Implemented 27 Instructions of the RV32I Core
- 5 Stage Pipeline Design
- Hazard Handling
- 
## Instruction Set Support
| Type | Instructions |
|------|--------|
| R    | ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND| 
| I    | JALR, LB, LH, LW, LBU, LHU, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI| 
| S    | SB, SH, SW | 
| B    | BEQ, BNE, BLT, BGE, BLTU, BGEU |
| U    | LUI, AUIPC |
| J    | JAL | 

## Design Steps
- Implement Load Word Instruction first
- Then Store Word Instruction
- Modify datapath and decoder to include R - type
- Add branch and store instructions (MUX for PC)
- Debug and Verify
- Pipeline the data path and the controller
- Design Hazard Unit
- Debug and verify
