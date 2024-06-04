source ./tcl/yosys_common.tcl

set_flow_var out_dir "pre_map_design" "Output directory for synthesis"
set_flow_var top_module "counter" "top module"
set_flow_bool_var flatten 1 "flatten"
set_flow_var pre_map_out "./${lr_synth_out_dir}/generated/${lr_synth_top_module}.pre_map.v" "Pre-mapping netlist out"


set flatten_opt ""



yosys "read_verilog -defer -sv ./${lr_synth_out_dir}/generated/*.v"

yosys "synth $flatten_opt -top $lr_synth_top_module"
yosys "opt -purge"

yosys "write_verilog $lr_synth_pre_map_out"
