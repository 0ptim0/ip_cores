dff:
	$(MAKE) sim MODULE=dff TESTCASE=dff_generic VERILOG_SOURCES=$(shell pwd)/../basic/dff.sv
glitch_filter:
	$(MAKE) sim MODULE=glitch_filter TESTCASE=glitch_filter VERILOG_SOURCES=$(shell pwd)/../basic/glitch_filter.sv

rgb:
	$(MAKE) sim MODULE=rgb TESTCASE=rgb VERILOG_SOURCES=$(shell pwd)/../interfaces/rgb.sv

include $(shell cocotb-config --makefiles)/Makefile.sim
