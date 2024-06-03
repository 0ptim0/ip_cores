`timescale 1ns / 1ns

module mux #(
    parameter SIZE = 'd1,
    parameter CHANNELS = 'd2,
    parameter WIDTH = $clog2(CHANNELS << 1)
) (
    input [SIZE-1:0] in[CHANNELS-1:0],
    input [WIDTH-1:0] sel,
    output reg [SIZE-1:0] out
);

  always_comb begin
    if (sel < CHANNELS) out = in[sel];
    else out = '0;
  end

endmodule
