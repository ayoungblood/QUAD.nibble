/* cpu/alu/testbench.sv
 * Testbench for cpu/alu/alu.sv
 */

`include "alu_constants.sv"
import constants::*;

module testbench();
    timeunit 1ns/1ns;

    logic clk;
    logic resetn;
    logic [3:0] alu_ctrl;
    logic [15:0] op_a, op_b, result;
    integer expected = 0;

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

    // Instantiate scoreboard
    int_scoreboard CHECKER(
        .clk(clk),
        .resetn(resetn),
        .actual(result),
        .expected(expected)
    );

    // Stimulus generation
    initial begin

        // reset everything
        resetn = 1'b0;
        alu_ctrl = 4'h0;
        op_a = 16'h0;
        op_b = 16'h0;
        //result = 16'h0;

        @(posedge clk);
        resetn <= #2 1'b1; // de-assert reset

        // ADD
        @(posedge clk);
		alu_ctrl <= #1 ALU_OP_ADD;
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2a;
        expected <= op_a + op_b;
        @(posedge clk);
		op_a <= #1 16'h1;
        op_b <= #1 16'h8000;
        expected <= op_a + op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
        expected <= op_a + op_b;
        @(posedge clk);
		op_a <= #1 16'h1;
        op_b <= #1 16'hffff;
        expected <= op_a + op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
        expected <= op_a + op_b;
        @(posedge clk);
		op_a <= #1 16'h1;
        op_b <= #1 16'hffff;
        expected <= op_a + op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
        expected <= op_a + op_b;
        @(posedge clk);
		op_a <= #1 16'h1;
        op_b <= #1 16'hffff;
        expected <= op_a + op_b;

		// SUBTRACT
        @(posedge clk);
        alu_ctrl <= #1 ALU_OP_SUB;
        op_a <= #1 16'h3;
        op_b <= #1 16'h5;
		expected <= op_a - op_b;
		@(posedge clk);
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2;
		expected <= op_a - op_b;
		@(posedge clk);
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2;
		expected <= op_a - op_b;
		@(posedge clk);
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2;
		expected <= op_a - op_b;
		@(posedge clk);
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2;
		expected <= op_a - op_b;
		@(posedge clk);
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2;
		expected <= op_a - op_b;
		@(posedge clk);
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2;
		expected <= op_a - op_b;
		@(posedge clk);
        op_a <= #1 16'h2a;
        op_b <= #1 16'h2;
		expected <= op_a - op_b;
		
		// MULTIPLY
        @(posedge clk);
        alu_ctrl <= ALU_OP_MUL;
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;
		@(posedge clk);
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a * op_b;

        @(posedge clk);
        alu_ctrl <= ALU_OP_AND;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a & op_b;

		@(posedge clk);
        alu_ctrl <= ALU_OP_OR;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a | op_b;

		@(posedge clk);
        alu_ctrl <= ALU_OP_XOR;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a ^ op_b;

		@(posedge clk);
        alu_ctrl <= ALU_OP_NOR;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= ~(op_a | op_b);

		@(posedge clk);
        alu_ctrl <= ALU_OP_SLL;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a << op_b;

		@(posedge clk);
        alu_ctrl <= ALU_OP_SRL;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= op_a >> op_b;

		@(posedge clk);
        alu_ctrl <= ALU_OP_ROL;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= {op_a,op_a} >> (16-op_b);

		@(posedge clk);
        alu_ctrl <= ALU_OP_SWP;
		op_a <= #1 16'h3;
        op_b <= #1 16'h4;
		expected <= {op_a[11:8],op_a[15:12],op_a[3:0],op_a[7:4]};


        #20;
        // for Modelsim, call $stop to halt but not exit interactive.
        $stop();
    end // initial stimulus
endmodule // testbench

// scoreboard
module int_scoreboard(
    input logic clk,
    input logic resetn,
    input logic [15:0] actual,
    input integer expected
);
    timeunit 1ns/1ns;
    integer errors = 0;
    always begin

        // wait for end of reset
        @(posedge clk);
        @(posedge resetn);
        forever begin
            @(posedge clk);
            if (actual !== expected) begin
                $display("%m: Error, expected=%d, got=%d at time=%t", expected, actual, $time);
                errors += 1;
            end
        end // forever
    end // always

endmodule // scoreboard

