`timescale 1ns / 1ns

module rgb #(
    parameter WIDTH = 'd64,
    parameter HEIGHT = 'd64,
    parameter COLOR_BITS = 'd8,
    parameter HOR_WIDTH = 'd4,
    parameter HOR_BPORCH = 'd43,
    parameter HOR_FPORCH = 'd8,
    parameter VER_WIDTH = 'd4,
    parameter VER_BPORCH = 'd12,
    parameter VER_FPORCH = 'd8,
    parameter HOR_POL_INVERTED = 1'b1,
    parameter VER_POL_INVERTED = 1'b1,
    parameter START_DELAY = 'd1000
) (
    input clk,
    input reset,
    input [2:0][COLOR_BITS-1:0] map[HEIGHT][WIDTH],
    output reg power,
    output reg de,
    output reg hsync,
    output reg vsync,
    output reg [COLOR_BITS-1:0] r,
    output reg [COLOR_BITS-1:0] g,
    output reg [COLOR_BITS-1:0] b
);

  enum {
    IDLE   = 0,
    START  = 1,
    UPDATE = 2,
    STOP   = 3
  } state;

  parameter HOR_SYNC_VALUE = HOR_BPORCH + WIDTH + HOR_FPORCH;
  parameter VER_SYNC_VALUE = VER_BPORCH + HEIGHT + VER_FPORCH;

  integer i;
  reg [$clog2(HOR_SYNC_VALUE)-1:0] x_i;
  reg [$clog2(VER_SYNC_VALUE)-1:0] y_i;
  reg [15:0] start_delay;

  always_ff @(posedge clk) begin
    if (reset) begin
      for (int i = 0; i < COLOR_BITS; ++i) begin
        r[i] <= 'd0;
        g[i] <= 'd0;
        b[i] <= 'd0;
      end
      vsync <= 1'b0;
      hsync <= 1'b0;
      de <= 1'b0;
      power <= 1'b0;
      x_i <= 'd0;
      y_i <= 'd0;
      start_delay <= START_DELAY;
      state <= IDLE;
    end else begin
      r <= map[y_i][x_i][0];
      g <= map[y_i][x_i][1];
      b <= map[y_i][x_i][2];
      hsync <= x_i <= HOR_WIDTH ? ~HOR_POL_INVERTED : HOR_POL_INVERTED;
      vsync <= y_i <= VER_WIDTH ? ~VER_POL_INVERTED : VER_POL_INVERTED;
      de <= x_i >= HOR_BPORCH &&
            x_i <= HOR_SYNC_VALUE - HOR_FPORCH &&
            y_i >= VER_BPORCH &&
            y_i <= VER_SYNC_VALUE - VER_FPORCH;

      case (state)
        IDLE: begin
          power <= 1'b1;
          state <= START;
        end
        START: begin
          if (start_delay > 'd0) start_delay <= start_delay - 'd1;
          else state <= UPDATE;
        end
        UPDATE: begin
          if (x_i == HOR_SYNC_VALUE) begin
            x_i <= 'd0;
            y_i <= y_i + 'd1;
          end else if (y_i == VER_SYNC_VALUE) begin
            x_i <= 'd0;
            y_i <= 'd0;
          end else begin
            x_i <= x_i + 'd1;
          end
        end
        STOP: begin
        end
        default: begin
        end
      endcase
    end
  end

endmodule
