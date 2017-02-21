/* cpu/cpu.sv
 * QUAD.nibble CPU core
 */

module cpu(
    input  logic        clk,
    input  logic        resetn
);
    timeunit 1ns;
    timeprecision 1ns;

    // Register file (sixteen registers)
    logic [15:0] registers [15:0];
    // Status register
    logic [15:0] sreg;
    // Stack pointer
    logic [15:0] sp;
    // Program counter
    logic [15:0] pc;
    // Execution state
    parameter   IFD = 2'h0,
                EX  = 2'b1,
                MEM = 2'b2,
                WB  = 2'b3;
    logic  [1:0] state = IFD;
    // Fetched instruction (driven directly by program memory)
    logic [15:0] curr;
    // ALU interface lines
    logic  [4:0] alu_ctrl;
    logic [15:0] alu_a, alu_b;
    logic  [4:0] alu_flags; // SVNZC

    // Program memory
    progmem PROGMEM(
        .clk(clk),
        .resetn(resetn),
        .addr(pc),
        .din(16'h0),
        .dout(curr),
        .write_en(1'h0)
    );

    // Arithmetic logic unit
    alu ALU(
        .clk(clk),
        .resetn(resetn),
        .ctrl(alu_ctrl),
        .a(alu_a),
        .b(alu_b),
        .c(alu_flags[0]),
        .z(alu_flags[1]),
        .n(alu_flags[2]),
        .v(alu_flags[3]),
        .s(alu_flags[4])
    );

    always_ff @(posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            sreg <= 16'h1; // start with interrupts enabled
            sp <= 16'hfffe; // stack starts at the top of data memory
            pc <= 16'h400; // execution starts near the bottom of program memory
        end else begin
            state <= state + 1;
            case (state)
                // Instruction fetch and decode
                IFD: begin
                    case (curr[15:12]) // switch on nibble 3 (MSN)
                        4'h0: begin
                            case (curr[11:8]) // switch on nibble 2
                                4'h0: begin
                                    case (curr[11:8]) // switch on nibble 1
                                        4'h0: // not used
                                        4'h1: // brc
                                            //
                                        4'h2: // brz
                                            //
                                        4'h3: // brn
                                            //
                                        4'h4: // push
                                            //
                                        4'h5: // pop
                                            //
                                        4'h6: // gsp
                                            //
                                        4'h7: // ssp
                                            //
                                        4'h8: // gsr
                                            //
                                        4'h9: // ssr
                                            //
                                        4'ha: // sbsr
                                            //
                                        4'hb: // cbsr
                                            //
                                        4'hc: // not used
                                        4'hd: // swap
                                            //
                                        4'he: // nextpc
                                            //
                                        4'hf: // jmp
                                            //
                                        default: // should never happen
                                            //
                                    endcase
                                4'h1: // roli
                                    //
                                4'h2: // slli
                                    //
                                4'h3: // srli
                                    //
                                4'h4: // add
                                    //
                                4'h5: // sub
                                    //
                                4'h6: // mul
                                    //
                                4'h7: // rol
                                    //
                                4'h8: // and
                                    //
                                4'h9: // or
                                    //
                                4'ha: // xor
                                    //
                                4'hb: // nor
                                    //
                                4'hc: // stb
                                    //
                                4'hd: // stw
                                    //
                                4'he: // ldb
                                    //
                                4'hf: // ldw
                                    //
                                default: // should never happen
                                    //
                            endcase
                        end
                        4'h1: // bge
                            //
                        4'h2: // bne
                            //
                        4'h3: // beq
                            //
                        4'h4: // addi
                            //
                        4'h5: // subi
                            //
                        4'h6: // muli
                            //
                        4'h7: // not used
                        4'h8: // andi
                            //
                        4'h9: // andhi
                            //
                        4'ha: // ori
                            //
                        4'hb: // orhi
                            //
                        4'hc: // xori
                            //
                        4'hd: // xorhi
                            //
                        4'he: // bri
                            //
                        4'hf: // jmpi
                            //
                        default: // should never happen
                            //
                    endcase
                    end
                // Execute
                EX: begin
                    //
                    end
                // Memory access
                MEM: begin
                    //
                    end
                // Write back and update
                WB: begin
                    //
                    end
                default: // should never happen
                    //
            endcase
        end
    end
endmodule // cpu
