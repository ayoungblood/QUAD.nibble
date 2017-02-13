/* cpu/progmem/progmem.sv
 * QUAD.nibble program memory
 */

module progmem(
    input  logic        clk,
    input  logic        resetn,
    input  logic [15:0] addr,
    input  logic [15:0] din,
    output logic [15:0] dout,
    input  logic        write_en
);
    timeunit 1ns;
    timeprecision 1ns;

    logic [15:0] mem [511:0];

    always_ff @(posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            dout <= 16'h0;
        end else begin
            if (write_en) begin
                mem[addr(9:0)] <= din;
            end
            dout <= mem[addr(9:0)];
        end
    end
endmodule
