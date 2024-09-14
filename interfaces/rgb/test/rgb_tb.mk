.PHONY: all clean compile run

SRC+="../hdl/rgb.sv"
SRC+="rgb_tb.sv"

all: compile run

clean:
	vdel -all

compile:
	vlib work
	vlog -sv $(SRC)

run:
	vsim -gui -suppress 10000 -quiet work.rgb_tb -do "rgb_tb.do" -do "run -all"\
