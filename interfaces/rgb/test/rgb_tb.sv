`timescale 1ns / 1ns

module rgb_tb;
  parameter WIDTH = 'd480;
  parameter HEIGHT = 'd272;
  parameter COLOR_BITS = 'd8;
  parameter HOR_WIDTH = 'd4;
  parameter HOR_BPORCH = 'd43;
  parameter HOR_FPORCH = 'd8;
  parameter VER_WIDTH = 'd4;
  parameter VER_BPORCH = 'd12;
  parameter VER_FPORCH = 'd8;
  parameter HOR_POL_INVERTED = 1'b1;
  parameter VER_POL_INVERTED = 1'b1;
  parameter START_DELAY = 'd10;

  reg clk;
  reg reset;
  wire power;
  wire de;
  wire hsync;
  wire vsync;
  wire [COLOR_BITS-1:0] r;
  wire [COLOR_BITS-1:0] g;
  wire [COLOR_BITS-1:0] b;

  reg [2:0][COLOR_BITS-1:0] map[HEIGHT][WIDTH];
  integer i, j;
  initial begin
    for (i = 0; i < HEIGHT; i = i + 1) begin
      for (j = 0; j < WIDTH; j = j + 1) begin
        map[i][j] = {3{8'b11111100}};
      end
    end
  end

  rgb #(
      .WIDTH(WIDTH),
      .HEIGHT(HEIGHT),
      .COLOR_BITS(COLOR_BITS),
      .HOR_WIDTH(HOR_WIDTH),
      .HOR_BPORCH(HOR_BPORCH),
      .HOR_FPORCH(HOR_FPORCH),
      .VER_WIDTH(VER_WIDTH),
      .VER_BPORCH(VER_BPORCH),
      .VER_FPORCH(VER_FPORCH),
      .HOR_POL_INVERTED(HOR_POL_INVERTED),
      .VER_POL_INVERTED(VER_POL_INVERTED),
      .START_DELAY(START_DELAY)
  ) DUT (
      .clk(clk),
      .reset(reset),
      .power(power),
      .de(de),
      .hsync(hsync),
      .vsync(vsync),
      .r(r),
      .g(g),
      .b(b)
  );

  initial begin
    clk = 0;
    forever begin
      #5;
      clk = ~clk;
    end
  end

  initial begin
    reset = 1'b1;
    #10;
    reset = 1'b0;
    #10;
    #10000;
    $stop;
  end

endmodule
