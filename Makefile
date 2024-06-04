VERILATOR_TB_PATH := ./src/sim_main.cpp
VERILATOR_SRC_DIR := ./src
TOP_NAME := tb



build:
	verilator -cc -Wno-NULLPORT -Wno-COMBDLY -Wno-PINMISSING -Wno-MODDUP --exe --trace --trace-structs --build --timing  $(VERILATOR_TB_PATH) ./rtl/*.sv -I$(VERILATOR_SRC_DIR) --top $(TOP_NAME) -j `nproc`

sim:
	./obj_dir/Vtb

syn:
	./syn_yosys.sh

clean:
	rm ./obj_dir -rf
	rm ./pre_map_design -rf
