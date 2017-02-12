/* cpu/alu/alu.sv
 * QUAD.nibble arithmetic-logic unit
 * Performs 16-bit signed arithmetic as well as bitwise operations
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
        // Carry and overflow flags depend on operation
        case (ctrl)
            ALU_OP_ADD: begin
                c = (a_reg[15] & b_reg[15] | b_reg[15] & ~y[15] | ~y[15] & a_reg[15]);
                v = (a_reg[15] & b_reg[15] & ~y[15] | ~a_reg[15] & ~b_reg[15] & y[15]);
                end
            ALU_OP_SUB: begin
                c = (~a_reg[15] & b_reg[15] | b_reg[15] & y[15] | y[15] & ~a_reg[15]);
                v = (a_reg[15] & ~b_reg[15] & ~y[15] | ~a_reg[15] & b_reg[15] & y[15]);
                end
            ALU_OP_MUL: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_RSV: begin // unused op-code
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_AND: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_OR: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_XOR: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_NOR: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_SLL: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_SRL: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_ROL: begin
                c = 1'b0;
                v = 1'b0;
                end
            ALU_OP_SWP: begin
                c = 1'b0;
                v = 1'b0;
                end
            default: begin
                c = 1'b0;
                v = 1'b0;
                end
        endcase
        // Z, N, and S flags are the same, regardless of operation
        z = ((y == 0) ? 1'b1 : 1'b0) & resetn;
        n = (y[15]) & resetn;
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
                ALU_OP_ADD:
                    y <= a + b;
                ALU_OP_SUB:
                    y <= a - b;
                ALU_OP_MUL:
                    y <= a * b;
                ALU_OP_RSV: // unused op-code, performs two's complement negation for now
                    y <= ~a + 1;
                ALU_OP_AND:
                    y <= a & b;
                ALU_OP_OR:
                    y <= a | b;
                ALU_OP_XOR:
                    y <= a ^ b;
                ALU_OP_NOR:
                    y <= ~(a | b);
                ALU_OP_SLL:
                    y <= a << b;
                ALU_OP_SRL:
                    y <= a >> b;
                ALU_OP_ROL:
                    y <= {a,a} >> (16-b);
                    // this probably won't synthesize well,
                    // needs to be converted to explicit barrel shifter
                ALU_OP_SWP:
                    y <= {a[11:8],a[15:12],a[3:0],a[7:4]};
                default:
                    y <= 16'h0;
            endcase
            a_reg <= a;
            b_reg <= b;
        end

    end
endmodule // alu
