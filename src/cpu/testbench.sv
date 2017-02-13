/* cpu/testbench.sv
 * Testbench for cpu/cpu.sv
 */

module testbench();
    timeunit 1ns/1ns;

    logic               clk;
    logic               resetn;

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
        .resetn(resetn)
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

        #20;
        // for Modelsim, call $stop to halt but not exit interactive.
        $stop();
    end // initial stimulus
endmodule // testbench
