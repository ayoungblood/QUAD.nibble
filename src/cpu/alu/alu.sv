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
    output logic signed [15:0] y
);
    timeunit 1ns;
    timeprecision 1ns;

    //always_comb begin
        //
    //end

    always_ff @(posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            y <= 16'h0;
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
        end
    end
endmodule // alu
