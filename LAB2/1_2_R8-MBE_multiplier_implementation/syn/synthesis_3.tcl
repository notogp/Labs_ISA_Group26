analyze -f sverilog -lib WORK ../src/cf_math_pkg.sv
analyze -f sverilog -lib WORK ../src/lzc.sv
analyze -f sverilog -lib WORK ../src/rr_arb_tree.sv
analyze -f sverilog -lib WORK ../src/fpnew_pkg.sv
analyze -f sverilog -lib WORK ../src/fpnew_classifier.sv
analyze -f sverilog -lib WORK ../src/fpnew_rounding.sv
analyze -f sverilog -lib WORK ../src/fpnew_fma.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_fmt_slice.sv
analyze -f sverilog -lib WORK ../src/fpnew_opgroup_block.sv
analyze -f sverilog -lib WORK ../src/fpnew_top.sv


set power_preserve_rtl_hier_names true
elaborate fpnew_top -lib WORK

create_clock -name MY_CLK -period 2.69 clk_i
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk_i]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile_ultra
report_timing > report_timing_3.txt
report_area > report_area_3.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
#write_sdf ../netlist/myfir.sdf
write -f verilog -hierarchy -output ../netlist/fpnew_top_3.v
#write_sdc ../netlist/myfir.sdc
quit