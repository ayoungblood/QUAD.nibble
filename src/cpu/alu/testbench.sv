// Testbench for cpu/alu/alu.sv
// Author: Akira Youngblood

`include "alu_constants.sv"
import parameters::*;

module testbench();
    timeunit 1ns;
    timeprecision 1ps;

    logic clk;
    logic resetn;
    logic [3:0] alu_ctrl;
    logic [15:0] op_a, op_b, result;

    // Generate clock and reset signals
    always begin
        clk = 1;
        forever begin
            #5;
            clk = ~clk;
        end // forever
    end // always

    // Instantiate DUT
    alu DUT(
        .clk(clk),
        .resetn(resetn),
        .ctrl(alu_ctrl),
        .a(op_a),
        .b(op_b),
        .y(result)
    );

    // Stimulus generation
    initial begin

        // reset everything
        resetn = 1'b0;
        alu_ctrl = 4'h0;
        op_a = 16'h0;
        op_b = 16'h0;
        result = 16'h0;

        @(posedge clk);
        resetn <= #2 1'b1; // de-assert reset

        @(posedge clk);
        alu_ctrl <= ADD;
        op_a <= #1 16'hf0;
        op_b <= #1 16'h0f;

        @(posedge clk);
        alu_ctrl <= SUB;
        op_a <= #1 16'h0100;
        op_b <= #1 16'h000f;

        @(posedge clk);
        alu_ctrl <= MUL;
        op_a <= #1 16'h0003;
        op_b <= #1 16'h0004;

        @(posedge clk);
        alu_ctrl <= NEG;

        @(posedge clk);


        #20;
        // for Modelsim, call $stop to halt but not exit interactive.
        $stop();
    end // initial stimulus
endmodule // testbench
