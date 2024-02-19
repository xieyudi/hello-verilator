.PHONY: clean sim run wave

export PRJ_ROOT ?= ${PWD}
SRC_ROOT = $(PRJ_ROOT)/rtl
TB_ROOT = $(PRJ_ROOT)/tb
SIM_ROOT = $(PRJ_ROOT)/sim/verilator/obj_dir

SRC = $(shell find $(SRC_ROOT) $(TB_ROOT) -type f -name '*.cpp' -or -name '*.f' -or -name '*.v' -or -name '*.sv')

CYCLES ?= 1000

sim: $(SRC) $(SIM_ROOT)
	verilator --trace -sv --autoflush --cc --Mdir $(SIM_ROOT) $(TB_ROOT)/tb_top.sv -f $(SRC_ROOT)/flist.f --exe $(TB_ROOT)/sim_main.cpp --top-module tb_top
	$(MAKE) -C $(SIM_ROOT) -f Vtb_top.mk

run: sim
	cd $(SIM_ROOT) && ./Vtb_top $(CYCLES)

wave: run
	gtkwave $(SIM_ROOT)/sim.vcd &

clean:
	rm -rf $(SIM_ROOT)

$(SIM_ROOT):
	mkdir -p $@