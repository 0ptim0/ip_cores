`timescale 1ns / 1ns

module rgb #(
    parameter X_WIDTH = 'd64,
    parameter Y_WIDTH = 'd64,
    parameter COLOR_BITS = 'd8
) (
    input clk,
    input reset,
    input [$clog2(X_WIDTH)-1:0] x,
    input [$clog2(Y_WIDTH)-1:0] y,
    input [3*COLOR_BITS-1:0] color,
    output reg [3*COLOR_BITS-1:0] r,
    output reg [3*COLOR_BITS-1:0] g,
    output reg [3*COLOR_BITS-1:0] b,
    output reg vsync,
    output reg hsync,
    output reg de,
    output reg disp

);

  enum {
    IDLE = 0,
    START = 1,
    VER_SYNC = 2,
    HOR_SYNC = 3,
    WRITE = 4,
    STOP = 5
  } state;

  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      r <= 'd0;
      g <= 'd0;
      b <= 'd0;
      vsync <= 1'b0;
      hsync <= 1'b0;
      de <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          state <= START;
        end
        START: begin
          de <= 1'b1;
          state <= VER_SYNC;
        end
        VER_SYNC: begin

        end
        HOR_SYNC: begin
        end
        WRITE: begin
        end
        STOP: begin
        end
      endcase
    end

  end

endmodule
