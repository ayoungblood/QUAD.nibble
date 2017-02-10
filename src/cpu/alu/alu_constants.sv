package parameters;
    parameter [3:0]
        ALU_OP_ADD = 4'h0, // add B to A
        ALU_OP_SUB = 4'h1, // subtract B from A
        ALU_OP_MUL = 4'h2, // multiply B by A
        ALU_OP_NEG = 4'h3, // compute two's complement of A

        ALU_OP_AND = 4'h4, // bitwise A AND B
        ALU_OP_OR  = 4'h5, // bitwise A OR B
        ALU_OP_XOR = 4'h6, // bitwise A XOR B
        ALU_OP_NOR = 4'h7, // bitwise A NOR B

        ALU_OP_SLL = 4'h8, // logical left shift A by B
        ALU_OP_SRL = 4'h9, // logical right shift A by B
        ALU_OP_ROL = 4'ha, // right rotate A by B
        ALU_OP_SWP = 4'hb; // swap nibbles of A
endpackage
