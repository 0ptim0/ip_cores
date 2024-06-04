module glitch_filter #(
    parameter RISE_TIME = 10,
    parameter FALL_TIME = 10
) (
    input  wire clk,
    input  wire reset,
    input  wire i,
    output reg  o
);

  reg [31:0] high_counter;
  reg [31:0] low_counter;
  reg stable_high;
  reg stable_low;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      o <= 0;
      high_counter <= 0;
      low_counter <= 0;
      stable_high <= 0;
      stable_low <= 0;
    end else begin
      if (i) begin
        high_counter <= high_counter + 1;
        low_counter  <= 0;
        if (high_counter >= RISE_TIME - 1) begin
          stable_high <= 1;
        end
      end else begin
        low_counter  <= low_counter + 1;
        high_counter <= 0;
        if (low_counter >= FALL_TIME - 1) begin
          stable_low <= 1;
        end
      end

      if (stable_high) begin
        o <= 1;
        stable_low <= 0;
      end else if (stable_low) begin
        o <= 0;
        stable_high <= 0;
      end
    end
  end
endmodule
