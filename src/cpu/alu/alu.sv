/* cpu/alu/alu.sv
 * QUAD.nibble arithmetic-logic unit
 * Performs 16-bit signed arithmetic as well as bitwise operations
 * Operations and flags are loosely based on AVR's 8-bit instruction set
 */

`include "alu_constants.sv"
import constants::*;

module alu(
    input  logic               clk,
    input  logic               resetn,
    input  logic         [3:0] ctrl,
    input  logic signed [15:0] a,
    input  logic signed [15:0] b,
    output logic signed [15:0] y,
    output logic               c, // carry flag
    output logic               z, // zero flag
    output logic               n, // negative flag
    output logic               v, // two's complement overflow
    output logic               s  // N ^ V, for signed tests
);
    timeunit 1ns;
    timeprecision 1ns;

    logic signed [15:0] a_reg, b_reg;

    always_comb begin
        // Z, N, and S flags are the same, regardless of operation
        // Z: Set if the result is 0x0000; cleared otherwise
        z = ((y == 0) ? 1'b1 : 1'b0) & resetn;
        // N: Set if the MSB of the result is set; cleared otherwise.
        n = (y[15]) & resetn;
        // Carry and overflow flags depend on operation
        case (ctrl)
            // Signed 16-bit addition
            ALU_OP_ADD: begin
                c = a_reg[15] & b_reg[15] | b_reg[15] & ~y[15] | ~y[15] & a_reg[15];
                v = a_reg[15] & b_reg[15] & ~y[15] | ~a_reg[15] & ~b_reg[15] & y[15];
                end
            // Signed 16-bit subtraction
            ALU_OP_SUB: begin
                c = ~a_reg[15] & b_reg[15] | b_reg[15] & y[15] | y[15] & ~a_reg[15];
                v = a_reg[15] & ~b_reg[15] & ~y[15] | ~a_reg[15] & b_reg[15] & y[15];
                end
            // Signed 16-bit x 16-bit -> 16-bit multiplication
            // Because the upper 16-bits are dropped, C and V are unhelpful
            // and are not modified
            ALU_OP_MUL: begin
                //c = 1'b0; //@FIXME
                //v = 1'b0; //@FIXME
                end
            ALU_OP_RSV: begin // unused op-code
                c = 1'b0;
                v = 1'b0;
                end
            // Logical AND
            ALU_OP_AND: begin
                c = 1'b0; // cannot carry, clear C
                v = 1'b0; // cannot overflow, clear V
                end
            // Logical OR
            ALU_OP_OR: begin
                c = 1'b0; // cannot carry, clear C
                v = 1'b0; // cannot overflow, clear V
                end
            // Logical exclusive-OR
            ALU_OP_XOR: begin
                c = 1'b0; // cannot carry, clear C
                v = 1'b0; // cannot overflow, clear V
                end
            // Logical NOR
            ALU_OP_NOR: begin
                c = 1'b0; // cannot carry, clear C
                v = 1'b0; // cannot overflow, clear V
                end
            // Logical left shift
            ALU_OP_SLL: begin
                // C is the last bit shifted out (on the left)
                c = (b_reg == 16'h0) ? 1'b0 : a_reg[16-b_reg[3:0]];
                v = 1'b0; // @FIXME
                end
            // Logical right shift
            ALU_OP_SRL: begin
                // C is the last bit shifted out (on the right)
                c = (b_reg == 16'h0) ? 1'b0 : a_reg[b_reg[3:0]-1];
                v = 1'b0; // @FIXME
                end
            // Logical left rotate
            ALU_OP_ROL: begin
                // C is the last bit rotated out (on the left)
                c = (b_reg == 16'h0) ? 1'b0 : a_reg[16-b_reg[3:0]];
                v = 1'b0; // @FIXME
                end
            // Swap nibbles within a word
            ALU_OP_SWP: begin
                c = 1'b0; // Cannot carry, clear C
                v = 1'b0; // Cannot overflow, clear V
                end
            // Unused opcodes clear C and V flags
            default: begin
                c = 1'b0;
                v = 1'b0;
                end
        endcase
        // S: N xor V, for signed tests.
        s = (n ^ v) & resetn;
        // Resets for C, V flags
        c = c & resetn;
        v = v & resetn;
    end

    always_ff @(posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            y <= 16'h0;
            a_reg <= 16'h0;
            b_reg <= 16'h0;
        end else begin
            case (ctrl)
                // Signed 16-bit addition
                ALU_OP_ADD:
                    y <= a + b;
                // Signed 16-bit subtraction
                ALU_OP_SUB:
                    y <= a - b;
                // Signed 16-bit x 16-bit -> 16-bit multiplication
                ALU_OP_MUL:
                    y <= a * b;
                // unused op-code, sets y to zero for now
                ALU_OP_RSV:
                    y <= 16'h0;
                // Logical AND
                ALU_OP_AND:
                    y <= a & b;
                // Logical OR
                ALU_OP_OR:
                    y <= a | b;
                // Logical exclusive-OR
                ALU_OP_XOR:
                    y <= a ^ b;
                // Logical NOR
                ALU_OP_NOR:
                    y <= a ~| b;
                // Logical left shift
                ALU_OP_SLL:
                    // modulo 16, cannot shift more than 15
                    y <= a << b[3:0];
                // Logical right shift
                ALU_OP_SRL:
                    // modulo 16, cannot shift more than 15
                    y <= a >> b[3:0];
                // Logical left rotate
                ALU_OP_ROL:
                    y <= {a,a} >> (16-b[3:0]);
                    // this probably won't synthesize well,
                    // needs to be converted to explicit barrel shifter
                // Swap nibbles within a word
                ALU_OP_SWP:
                    y <= {a[11:8],a[15:12],a[3:0],a[7:4]};
                // Unused opcodes set y to zero
                default:
                    y <= 16'h0;
            endcase
            a_reg <= a;
            b_reg <= b;
        end
    end
endmodule // alu
