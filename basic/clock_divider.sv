`timescale 1ns / 1ns

module clock_divider #(
    parameter FREQ_IN  = 'd1_000_000,
    parameter FREQ_OUT = 'd1
) (
    input clk,
    input reset,
    output reg out
);

  reg [31:0] cnt;

  localparam DIVIDER = FREQ_IN / FREQ_OUT;

  always @(posedge clk) begin
    if (reset) begin
      out <= 1'b0;
      cnt <= 32'd0;
    end else begin
      if (cnt == DIVIDER / 2 - 1) begin
        out <= out ^ 1;
        cnt <= 32'd0;
      end else begin
        cnt <= cnt + 32'd1;
      end
    end
  end

endmodule
