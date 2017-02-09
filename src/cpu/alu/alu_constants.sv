package parameters;
	parameter [3:0]
	    ADD = 4'h0, // add B to A
	    SUB = 4'h1, // subtract B from A
	    MUL = 4'h2, // multiply B by A
	    NEG = 4'h3, // compute two's complement of A
	
	    AND = 4'h4, // bitwise A AND B
	    OR  = 4'h5, // bitwise A OR B
	    XOR = 4'h6, // bitwise A XOR B
	    NOR = 4'h7, // bitwise A NOR B
	
	    SLL = 4'h8, // logical left shift A by B
	    SRL = 4'h9, // logical right shift A by B
	    ROL = 4'ha, // right rotate A by B
	    SWP = 4'hb; // swap nibbles of A
endpackage
