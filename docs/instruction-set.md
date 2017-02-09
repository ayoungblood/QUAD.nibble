# Instruction Set Reference

There are sixteen registers, referenced as `r0` thru `r15`, with no restrictions on stored value.

All arithmetic is signed and assumes two's complement.

Instructions are designed for easy assembly-code level editing and programming. Opcodes, operands, and constants are separated at nibble boundaries wherever possible. Instructions can be easily decoded by inspecting nibbles starting from the most-significant nibble (MSN).

There is a single 16-bit status register which provides ALU status bits and processor control.

## Addressing Modes

### Register Direct, Single Operand

| [15:12] | [11:8]  | [7:4]   | [3:0]   |
|:-------:|:-------:|:-------:|:-------:|
| OPCODE  | OPCODE  | OPCODE  | rA      |

Operand is contained in register `rA`; result is stored in register `rA`.

### Register Direct, Dual Operand

| [15:12] | [11:8]  | [7:4]   | [3:0]   |
|:-------:|:-------:|:-------:|:-------:|
| OPCODE  | OPCODE  | rB      | rA      |

Operands are contained in registers `rB`, and `rA`; result is stored in register `rA`.

### Immediate 4, Single Operand

| [15:12] | [11:8]  | [7:4]   | [3:0]   |
|:-------:|:-------:|:-------:|:-------:|
| OPCODE  | OPCODE  | IMM4    | rA      |

Operands are contained in register `rA` and a 4-bit constant value `IMM4`; result is stored in register `rA`.

### Immediate 4, Dual Operands

| [15:12] | [11:8]  | [7:4]   | [3:0]   |
|:-------:|:-------:|:-------:|:-------:|
| OPCODE  | IMM4    | rB      | rA      |

Operands are contained in registers `rB`, `rA`, and a 4-bit constant value `IMM4`; result is stored in register `rA`.

### Immediate 8

| [15:12] | [11:8]    | [7:4]     | [3:0]   |
|:-------:|:---------:|:---------:|:-------:|
| OPCODE  | IMM8[7:4] | IMM8[3:0] | rA      |

Operands are contained in registers `rA` and an 8-bit constant value `IMM8`; result is stored in register `rA`.

### Immediate 12

| [15:12] | [11:8]      | [7:4]      | [3:0]      |
|:-------:|:-----------:|:----------:|:----------:|
| OPCODE  | IMM12[11:8] | IMM12[7:4] | IMM12[3:0] |

Operand is a single 12-bit constant value `IMM12`. Instructions of this format do not have a result; this format is reserved for `bri` and `jmpi` instructions.

## Instruction Set Summary

## Instruction Set Details
