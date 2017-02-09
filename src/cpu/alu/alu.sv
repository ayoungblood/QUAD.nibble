`include "alu_constants.sv"
import parameters::*;

module alu(
    input  logic        clk,
    input  logic        resetn,
    input  logic [3:0]  ctrl,
    input  logic [15:0] a,
    input  logic [15:0] b,
    output logic [15:0] y
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
                ADD:
                    y <= a + b;
                SUB:
                    y <= a - b;
		MUL:
			y <= a * b;
                NEG:
                    y <= ~a + 1;
                AND:
                    y <= a & b;
                OR:
                    y <= a | b;
                XOR:
                    y <= a ^ b;
                NOR:
                    y <= ~(a | b);
                SLL:
                    y <= a << b;
                SRL:
                    y <= a >> b;
                ROL:
                    y <= {a,a} >> (16-b);
                    // this probably won't synthesize well,
                    // needs to be converted to explicit barrel shifter
                SWP:
                    y <= {a[11:8],a[15:12],a[3:0],a[7:4]};
                default:
                    y <= 16'h0;
            endcase
	end
    end
endmodule // alu


