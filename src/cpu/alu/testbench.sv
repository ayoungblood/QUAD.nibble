/* cpu/alu/testbench.sv
 * Testbench for cpu/alu/alu.sv
 */

`include "alu_constants.sv"
import constants::*;

module testbench();
    timeunit 1ns/1ns;

    logic               clk;
    logic               resetn;
    logic         [3:0] alu_ctrl;
    logic signed [15:0] op_a, op_b, result;
    logic         [4:0] flags; // SVNZC
    integer             expected = 0;
    logic         [4:0] expected_flags = 5'b10;

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
        .y(result),
        .c(flags[0]),
        .z(flags[1]),
        .n(flags[2]),
        .v(flags[3]),
        .s(flags[4])
    );

    // Instantiate scoreboard
    int_scoreboard CHECKER(
        .clk(clk),
        .resetn(resetn),
        .actual(result),
        .expected(expected),
        .actual_flags(flags),
        .expected_flags(expected_flags)
    );

    // Stimulus generation
    initial begin

        // reset everything
        resetn = 1'b0;
        alu_ctrl = 4'h0;
        op_a = 16'sh0;
        op_b = 16'sh0;

        @(posedge clk);
        resetn <= #2 1'b1; // de-assert reset

        // ADD
        @(posedge clk);
        alu_ctrl <= #1 ALU_OP_ADD;
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b0;
        @(posedge clk);
        op_a <= #1 16'h4000;
        op_b <= #1 16'h4000;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b01100;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b00010;
        @(posedge clk);
        op_a <= #1 16'h7fff;
        op_b <= #1 16'h7fff;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b01100;
        @(posedge clk);
        op_a <= #1 16'h8000;
        op_b <= #1 16'h1;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b10100;
        @(posedge clk);
        op_a <= #1 16'h7fff;
        op_b <= #1 16'h8000;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b10100;
        @(posedge clk);
        op_a <= #1 16'h4000;
        op_b <= #1 16'h4000;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b01100;
        @(posedge clk);
        op_a <= #1 16'h1;
        op_b <= #1 16'h7fff;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b01100;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h8000;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b11001;
        @(posedge clk);
        op_a <= #1 16'ha000;
        op_b <= #1 16'ha000;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b11001;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= $signed(op_a + op_b);
        expected_flags <= #10 5'b00010;

        // SUBTRACT
        @(posedge clk);
        alu_ctrl <= #1 ALU_OP_SUB;
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b10101;
        @(posedge clk);
        op_a <= #1 16'h8000;
        op_b <= #1 16'h1;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b11000;
        @(posedge clk);
        op_a <= #1 16'h7fff;
        op_b <= #1 16'h8000;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b01101;
        @(posedge clk);
        op_a <= #1 16'h4000;
        op_b <= #1 16'h4000;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b00010;
        @(posedge clk);
        op_a <= #1 16'h1;
        op_b <= #1 16'h7fff;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b10101;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h8000;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b00000;
        @(posedge clk);
        op_a <= #1 16'ha000;
        op_b <= #1 16'ha000;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b00010;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= $signed(op_a - op_b);
        expected_flags <= #10 5'b00010;

        // MULTIPLY
        @(posedge clk);
        alu_ctrl <= ALU_OP_MUL;
        op_a <= #1 16'h3;
        op_b <= #1 16'h4;
        expected <= op_a * op_b;
        @(posedge clk);
        op_a <= #1 16'h8000;
        op_b <= #1 16'h1;
        expected <= op_a * op_b;
        @(posedge clk);
        op_a <= #1 16'h7fff;
        op_b <= #1 16'h8000;
        expected <= op_a * op_b;
        @(posedge clk);
        op_a <= #1 16'h4000;
        op_b <= #1 16'h4000;
        expected <= op_a * op_b;
        @(posedge clk);
        op_a <= #1 16'h1;
        op_b <= #1 16'h7fff;
        expected <= op_a * op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h8000;
        expected <= op_a * op_b;
        @(posedge clk);
        op_a <= #1 16'ha000;
        op_b <= #1 16'ha000;
        expected <= op_a * op_b;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= op_a * op_b;

        // AND
        @(posedge clk);
        alu_ctrl <= ALU_OP_AND;
        op_a <= #1 16'h0;
        op_b <= #1 16'ha5a5;
        expected <= op_a & op_b;
        @(posedge clk);
        op_a <= #1 16'ha5a5;
        op_b <= #1 16'h0;
        expected <= op_a & op_b;
        @(posedge clk);
        op_a <= #1 16'h5a5a;
        op_b <= #1 16'ha5a5;
        expected <= op_a & op_b;
        @(posedge clk);
        op_a <= #1 16'h8080;
        op_b <= #1 16'h8080;
        expected <= op_a & op_b;
        @(posedge clk);
        op_a <= #1 16'hf00f;
        op_b <= #1 16'hf0f0;
        expected <= op_a & op_b;
        @(posedge clk);
        op_a <= #1 16'h0ff0;
        op_b <= #1 16'haa55;
        expected <= op_a & op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'hffff;
        expected <= op_a & op_b;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= op_a & op_b;

        // OR
        @(posedge clk);
        alu_ctrl <= ALU_OP_OR;
        op_a <= #1 16'h0;
        op_b <= #1 16'ha5a5;
        expected <= op_a | op_b;
        @(posedge clk);
        op_a <= #1 16'ha5a5;
        op_b <= #1 16'h0;
        expected <= op_a | op_b;
        @(posedge clk);
        op_a <= #1 16'h5a5a;
        op_b <= #1 16'ha5a5;
        expected <= op_a | op_b;
        @(posedge clk);
        op_a <= #1 16'h8080;
        op_b <= #1 16'h8080;
        expected <= op_a | op_b;
        @(posedge clk);
        op_a <= #1 16'hf00f;
        op_b <= #1 16'hf0f0;
        expected <= op_a | op_b;
        @(posedge clk);
        op_a <= #1 16'h0ff0;
        op_b <= #1 16'haa55;
        expected <= op_a | op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'hffff;
        expected <= op_a | op_b;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= op_a | op_b;

        // XOR
        @(posedge clk);
        alu_ctrl <= ALU_OP_XOR;
        op_a <= #1 16'h0;
        op_b <= #1 16'ha5a5;
        expected <= op_a ^ op_b;
        @(posedge clk);
        op_a <= #1 16'ha5a5;
        op_b <= #1 16'h0;
        expected <= op_a ^ op_b;
        @(posedge clk);
        op_a <= #1 16'h5a5a;
        op_b <= #1 16'ha5a5;
        expected <= op_a ^ op_b;
        @(posedge clk);
        op_a <= #1 16'h8080;
        op_b <= #1 16'h8080;
        expected <= op_a ^ op_b;
        @(posedge clk);
        op_a <= #1 16'hf00f;
        op_b <= #1 16'hf0f0;
        expected <= op_a ^ op_b;
        @(posedge clk);
        op_a <= #1 16'h0ff0;
        op_b <= #1 16'haa55;
        expected <= op_a ^ op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'hffff;
        expected <= op_a ^ op_b;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= op_a ^ op_b;

        // NOR
        @(posedge clk);
        alu_ctrl <= ALU_OP_NOR;
        op_a <= #1 16'h0;
        op_b <= #1 16'ha5a5;
        expected <= op_a |~ op_b;
        @(posedge clk);
        op_a <= #1 16'ha5a5;
        op_b <= #1 16'h0;
        expected <= op_a |~ op_b;
        @(posedge clk);
        op_a <= #1 16'h5a5a;
        op_b <= #1 16'ha5a5;
        expected <= op_a |~ op_b;
        @(posedge clk);
        op_a <= #1 16'h8080;
        op_b <= #1 16'h8080;
        expected <= op_a |~ op_b;
        @(posedge clk);
        op_a <= #1 16'hf00f;
        op_b <= #1 16'hf0f0;
        expected <= op_a |~ op_b;
        @(posedge clk);
        op_a <= #1 16'h0ff0;
        op_b <= #1 16'haa55;
        expected <= op_a |~ op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'hffff;
        expected <= op_a |~ op_b;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h0;
        expected <= op_a |~ op_b;

        // SHIFT LEFT
        @(posedge clk);
        alu_ctrl <= ALU_OP_SLL;
        op_a <= #1 16'hf0f0;
        op_b <= #1 16'h0;
        expected <= op_a << op_b;
        @(posedge clk);
        op_a <= #1 16'hf0f0;
        op_b <= #1 16'h8;
        expected <= op_a << op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h10;
        expected <= op_a << op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h20;
        expected <= op_a << op_b;
        @(posedge clk);
        op_a <= #1 16'hf5fa;
        op_b <= #1 16'h8000;
        expected <= op_a << op_b;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h8;
        expected <= op_a << op_b;

        // SHIFT RIGHT
        @(posedge clk);
        alu_ctrl <= ALU_OP_SRL;
        op_a <= #1 16'hf0f0;
        op_b <= #1 16'h0;
        expected <= op_a >> op_b;
        @(posedge clk);
        op_a <= #1 16'hf0f0;
        op_b <= #1 16'h8;
        expected <= op_a >> op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h10;
        expected <= op_a >> op_b;
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h20;
        expected <= op_a >> op_b;
        @(posedge clk);
        op_a <= #1 16'hf5fa;
        op_b <= #1 16'h8000;
        expected <= op_a >> op_b;
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h8;
        expected <= op_a >> op_b;

        // ROTATE LEFT
        @(posedge clk);
        alu_ctrl <= ALU_OP_ROL;
        op_a <= #1 16'hf0f0;
        op_b <= #1 16'h0;
        expected <= {op_a,op_a} >> (16-op_b);
        @(posedge clk);
        op_a <= #1 16'hf0f0;
        op_b <= #1 16'h8;
        expected <= {op_a,op_a} >> (16-op_b);
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h10;
        expected <= {op_a,op_a} >> (16-op_b);
        @(posedge clk);
        op_a <= #1 16'hffff;
        op_b <= #1 16'h20;
        expected <= {op_a,op_a} >> (16-op_b);
        @(posedge clk);
        op_a <= #1 16'hf5fa;
        op_b <= #1 16'h8000;
        expected <= {op_a,op_a} >> (16-op_b);
        @(posedge clk);
        op_a <= #1 16'h0;
        op_b <= #1 16'h8;
        expected <= {op_a,op_a} >> (16-op_b);

        @(posedge clk);
        alu_ctrl <= ALU_OP_SWP;
        op_a <= #1 16'h0f0f;
        op_b <= #1 16'h0;
        expected <= 16'hf0f0;
        @(posedge clk);
        op_a <= #1 16'h00ff;
        op_b <= #1 16'h5;
        expected <= 16'h00ff;
        @(posedge clk);
        op_a <= #1 16'h1234;
        op_b <= #1 16'h55;
        expected <= 16'h2143;
        @(posedge clk);
        op_a <= #1 16'h8080;
        op_b <= #1 16'h555;
        expected <= 16'h0808;

        #20;
        // for Modelsim, call $stop to halt but not exit interactive.
        $stop();
    end // initial stimulus
endmodule // testbench

// scoreboard
module int_scoreboard(
    input logic               clk,
    input logic               resetn,
    input logic signed [15:0] actual,
    input integer             expected,
    input logic         [4:0] actual_flags,
    input logic         [4:0] expected_flags
);
    timeunit 1ns/1ns;
    integer errors = 0;
    always begin
        // wait for end of reset
        @(posedge clk);
        @(posedge resetn);
        forever begin
            @(posedge clk);
            if (actual !== expected | actual_flags !== expected_flags) begin
                $display("%m: Error, expected=%d/%d, got=%d/%d at time=%t", expected, expected_flags, actual, actual_flags, $time);
                errors += 1;
            end
        end // forever
    end // always
endmodule // scoreboard
