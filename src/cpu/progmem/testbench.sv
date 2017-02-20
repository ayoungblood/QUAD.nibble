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
    logic mem_we;
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
        .write_en(mem_we)
    );

    // Stimulus generation
    initial begin

        // reset everything
        resetn = 1'b0;
        mem_addr = 16'h0;
        mem_din = 16'h0;
        mem_we = 1'b0;

        @(posedge clk);
        resetn <= #2 1'b1; // de-assert reset

        @(posedge clk);
        mem_din  <= #1 16'h55;
        mem_addr <= #1 16'h55;

        @(posedge clk);
        mem_we   <= #1 1'b1;
        mem_din  <= #1 16'h6;
        mem_addr <= #1 16'h3;

        @(posedge clk);
        mem_we   <= #1 1'b1;
        mem_din  <= #1 16'h8;
        mem_addr <= #1 16'h4;

        @(posedge clk);
        mem_we   <= #1 1'b1;
        mem_din  <= #1 16'ha;
        mem_addr <= #1 16'h5;

        @(posedge clk);

        @(posedge clk);

        #20;
        // for Modelsim, call $stop to halt but not exit interactive.
        $stop();
    end // initial stimulus
endmodule // testbench
