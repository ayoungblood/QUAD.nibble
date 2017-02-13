/* cpu/alu/testbench.sv
 * Testbench for cpu/alu/alu.sv
 *
 * To simulate with Modelsim:
 *   cd .../src/cpu/alu/
 *   vlib quad_nibble
 *   do testbench.tcl
 */

module testbench();
    timeunit 1ns;
    timeprecision 1ps;

    logic clk;
    logic resetn;
    logic mem_write_en;
    logic [3:0]  mem_addr;
    logic [15:0] mem_din, mem_dout;

    // Generate clock
    always begin
        clk = 1;
        forever begin
            #5;
            clk = ~clk;
        end // forever
    end // always

    // Instantiate DUT
    progmem DUT(
        .clk(clk),
        .resetn(resetn),
        .addr(mem_addr),
        .din(mem_din),
        .dout(mem_dout),
        .write_en(mem_write_en)
    );

    // Stimulus generation
    initial begin

        // reset everything
        resetn = 1'b0;
        mem_addr = 16'h0;
        mem_din = 16'h0;
        mem_write_en = 1'b0;

        @(posedge clk);
        resetn <= #2 1'b1; // de-assert reset

        @(posedge clk);

        @(posedge clk);

        @(posedge clk);

        @(posedge clk);

        @(posedge clk);

        #20;
        // for Modelsim, call $stop to halt but not exit interactive.
        $stop();
    end // initial stimulus
endmodule // testbench
