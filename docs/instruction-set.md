# Instruction Set Reference

There are sixteen registers, referenced as `r0` thru `r15`, with no restrictions on stored value.

All arithmetic is signed and assumes two's complement.

Instructions are designed for easy assembly-code level editing and programming. Opcodes, operands, and constants are separated at nibble boundaries. Instructions can be easily decoded by inspecting nibbles starting from the most-significant nibble (MSN).

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

## Status Register

| Bit | Name | Function |
|:---:|:----:|:---------|
| 0   | IE   | Global interrupt enable |
| 1   | C    | Carry |
| 2   | Z    | Zero |
| 3   | N    | Negative |
| 4   | V    | Two's complement overflow |
| 5   | S    | N XOR V, for signed tests |
| 6   | -    | Reserved |
| 7   | PD   | Power down |
| 8   | -    | Reserved |
| 9   | -    | Reserved |
| 10  | -    | Reserved |
| 11  | -    | Reserved |
| 12  | -    | Reserved |
| 13  | -    | Reserved |
| 14  | -    | Reserved |
| 15  | -    | Reserved |

Reserved bits may read 0 or 1.

The status register is modified by all ALU commands as follows:

C: set if there was a carry from the MSB of the result, cleared otherwise.  
Z: set if the result was 0x0000, cleared otherwise.  
N: set if the MSB of the result is set, cleared otherwise.  
V: set if a two's complement overflow occurred, cleared otherwise.  
S: N XOR V

ALU instructions that modify the status register:
- add
- addi
- and
- andi
- andhi
- mul
- muli
- neg
- nor
- or
- ori
- orhi
- rol
- roli
- sll
- slli
- srl
- srli
- sub
- subi
- swp
- xor
- xori
- xorhi

## Instruction Set Summary

| OP[15:12] | OP[11:8]    | OP[7:4]    | OP[3:0]    | Type                | Mnemonic | Description                                                             |
|-----------|-------------|------------|------------|---------------------|----------|-------------------------------------------------------------------------|
| 0x0       | 0x0         | 0x0        | rA         | Reg Direct, Single  |          |                                                                         |
| 0x0       | 0x0         | 0x1        | rA         | Reg Direct, Single  | brc      | branch if carry; if (SREG.C), PC = PC + 2 + rA << 2                     |
| 0x0       | 0x0         | 0x2        | rA         | Reg Direct, Single  | brz      | branch if zero; if (SREG.Z), PC = PC + 2 + rA << 2                      |
| 0x0       | 0x0         | 0x3        | rA         | Reg Direct, Single  | brn      | branch if negative; if (SREG.N), PC = PC + 2 + rA << 2                  |
| 0x0       | 0x0         | 0x4        | rA         | Reg Direct, Single  | push     | store rA on the stack and post decrement by 2; *SP = rA, SP -= 2        |
| 0x0       | 0x0         | 0x5        | rA         | Reg Direct, Single  | pop      | load rA from the stack and post increment by 2; rA = *SP, SP += 2       |
| 0x0       | 0x0         | 0x6        | rA         | Reg Direct, Single  |          |                                                                         |
| 0x0       | 0x0         | 0x7        | rA         | Reg Direct, Single  |          |                                                                         |
| 0x0       | 0x0         | 0x8        | rA         | Reg Direct, Single  | sget     | store the status register in rA; rA = SREG                              |
| 0x0       | 0x0         | 0x9        | rA         | Reg Direct, Single  | sput     | set the status register to rA; SREG = rA                                |
| 0x0       | 0x0         | 0xa        | rA         | Reg Direct, Single  | sset     | set a bit in the status register; SREG |= 1<<rA                         |
| 0x0       | 0x0         | 0xb        | rA         | Reg Direct, Single  | sclr     | clear a bit in the status register; SREG &= ~(1<<rA)                    |
| 0x0       | 0x0         | 0xc        | rA         | Reg Direct, Single  | neg      | two's complement negation; rA = ~rA + 1                                 |
| 0x0       | 0x0         | 0xd        | rA         | Reg Direct, Single  | swap     | swap nibbles; rA = (rA[11:8]:rA[15:12]:rA[3:0]:rA[7:4])                 |
| 0x0       | 0x0         | 0xe        | rA         | Reg Direct, Single  | nextpc   | gets the address of the next instruction; rA = PC + 2                   |
| 0x0       | 0x0         | 0xf        | rA         | Reg Direct, Single  | jmp      | jump; PC = rA                                                           |
| 0x0       | 0x1         | IMM4[3:0]  | rA         | Immediate 4, Single | roli     | bitwise left rotate; rA = lrotate(rA,IMM4)                              |
| 0x0       | 0x2         | IMM4[3:0]  | rA         | Immediate 4, Single | slli     | logical left shift; rA = rA << IMM4                                     |
| 0x0       | 0x3         | IMM4[3:0]  | rA         | Immediate 4, Single | srli     | logical right shift; rA = rA >> IMM4                                    |
| 0x0       | 0x4         | rB         | rA         | Reg Direct, Dual    | add      | add rB to rA and place result in rA; rA = rA + rB                       |
| 0x0       | 0x5         | rB         | rA         | Reg Direct, Dual    | sub      | subtract rB from rA and place result in rA; rA = rA - rB                |
| 0x0       | 0x6         | rB         | rA         | Reg Direct, Dual    | mul      | multiply rB by rA and place result in rA; rA = rA * rB                  |
| 0x0       | 0x7         | rB         | rA         | Reg Direct, Dual    |          |                                                                         |
| 0x0       | 0x8         | rB         | rA         | Reg Direct, Dual    | and      | bitwise AND; rA = rA & rB                                               |
| 0x0       | 0x9         | rB         | rA         | Reg Direct, Dual    | or       | bitwise OR; rA = rA | rB                                                |
| 0x0       | 0xa         | rB         | rA         | Reg Direct, Dual    | xor      | bitwise XOR; rA = rA ^ rB                                               |
| 0x0       | 0xb         | rB         | rA         | Reg Direct, Dual    | nor      | bitwise NOR; rA = ~(rA | rB)                                            |
| 0x0       | 0xc         | rB         | rA         | Reg Direct, Dual    | stb      | store rA to byte pointed to by rB; MEM[rB] = rA[7:0]                    |
| 0x0       | 0xd         | rB         | rA         | Reg Direct, Dual    | stw      | store rA to word pointed to by rB; MEM[rB+1..rB] = rA[15:0]             |
| 0x0       | 0xe         | rB         | rA         | Reg Direct, Dual    | ldb      | load rA with byte pointed to by rB; rA = (0x00:MEM[rB])                 |
| 0x0       | 0xf         | rB         | rA         | Reg Direct, Dual    | ldw      | load rA with word pointed to by rB; rA = MEM[rB+1..rB]                  |
| 0x1       | IMM4[3:0]   | rB         | rA         | Immediate 4, Dual   | bge      | branch if greater than or equal; if (rB >= rA), PC = PC + 2 + IMM4 << 2 |
| 0x2       | IMM4[3:0]   | rB         | rA         | Immediate 4, Dual   |          |                                                                         |
| 0x3       | IMM4[3:0]   | rB         | rA         | Immediate 4, Dual   | beq      | branch if equal; if (rB == rA), PC = PC + 2 + IMM4 << 2                 |
| 0x4       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | addi     | add IMM8 to rA and place result in rA; rA = rA + IMM8                   |
| 0x5       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | subi     | subtract IMM8 from rA and place result in rA; rA = rA - IMM8            |
| 0x6       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | muli     | multiply rA by IMM8 and place result in rA; rA = rA * IMM8              |
| 0x7       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         |          |                                                                         |
| 0x8       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | andi     | bitwise AND low; rA = rA & (0x00:IMM8)                                  |
| 0x9       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | andhi    | bitwise AND high; rA = rA & (IMM8:0x00)                                 |
| 0xa       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | ori      | bitwise OR low; rA = rA | (0x00:IMM8)                                   |
| 0xb       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | orhi     | bitwise OR high; rA = rA | (IMM8:0x00)                                  |
| 0xc       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | xori     | bitwise XOR low; rA = rA ^ (0x00:IMM8)                                  |
| 0xd       | IMM8[7:4]   | IMM8[3:0]  | rA         | Immediate 8         | xorhi    | bitwise XOR high; rA = rA ^ (IMM8:0x00)                                 |
| 0xe       | IMM12[11:8] | IMM12[7:4] | IMM12[3:0] | Immediate 12        | bri      | branch immediate; PC = PC + 2 + IMM12 << 2                              |
| 0xf       | IMM12[11:8] | IMM12[7:4] | IMM12[3:0] | Immediate 12        | jmpi     | jump immediate; PC = (PC[15:13]:IMM12 << 2)                             |

## Instruction Set Details

#### add - Add without carry

Adds two registers `rB` and `rA` and places the result in the destination register `rA`.

Operation: `rA <= rB + rA`  
Program counter: `PC <= PC + 1`  
16-bit opcode: `0000 0100 BBBB AAAA`

#### addi - Add immediate without carry

Adds a register `rA` and 8-bit immediate value `IMM8` and places the result in the destination register `rA`.

Operation: `rA <= rA + IMM8`  
Program counter: `PC <= PC + 1`  
16-bit opcode: `0100 IIII IIII AAAA`

#### and - Logical AND

Performs a logical bitwise AND on two registers `rB` and `rA` and places in the result in the destination register `rA`.

Operation: `rA <= rB & rA`  
Program counter: `PC <= PC + 1`  
16-bit opcode: `0000 1000 BBBB AAAA`

#### andi - Logical AND immediate

Performs logical bitwise AND on a register `rA` and 8-bit immediate value `IMM8` and places the result in the destination register `rA`.

Operation: `rA <= rA & (0x00:IMM8)`  
Program counter: `PC <= PC + 1`  
16-bit opcode: `1000 IIII IIII AAAA`

#### andhi - Logical AND immediate, high half-word

Performs logical bitwise AND on a register `rA` and 8-bit immediate value `IMM8` shifted into the upper half-word and places the result in the destination register `rA`.

Operation: `rA <= rA & (IMM8:0x00)`  
Program counter: `PC <= PC + 1`  
16-bit opcode: `1001 IIII IIII AAAA`

#### mul - Multiply

Multiplies register `rB` with register `rA` and places the result in the destination register `rA`.

Operation: `rA <= rB x rA`  
Program counter: `PC <= PC + 1`  
16-bit opcode: `0000 0110 BBBB AAAA`

#### muli - Multiply immediate

Multiplies register `rA` with 8-bit immediate value `IMM8` and places the result in the destination register `rA`.

Operation: `rA <= rA x IMM8`  
Program counter: `PC <= PC + 1`  
16-bit opcode: `0110 IIII IIII AAAA`
