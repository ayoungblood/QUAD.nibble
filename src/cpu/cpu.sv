/* cpu/cpu.sv
 * QUAD.nibble CPU core
 */

module cpu(
    input  logic        clk,
    input  logic        resetn
);
    timeunit 1ns;
    timeprecision 1ns;

    // Register file (sixteen registers)
    logic [15:0] registers [15:0];
    // Status register
    logic [15:0] sreg;
    // Stack pointer
    logic [15:0] sp;
    // Program counter
    logic [15:0] pc;
    // Execution state
    parameter   IFD = 2'h0,
                EX  = 2'b1,
                MEM = 2'b2,
                WB  = 2'b3;
    logic  [1:0] state = IFD;

    always_ff @(posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            sreg <= 16'h0001; // start with interrupts enabled
            sp <= 16'hfffe; // stack starts at the top of data memory
            pc <= 16'h400; // execution starts near the bottom of program memory
        end else begin
            state <= state + 1;
        end
    end
endmodule // cpu
