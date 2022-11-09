analyze -f vhdl -lib WORK ../src/register.vhd
analyze -f vhdl -lib WORK ../src/fir.vhd
set power_preserve_rtl_hier_names true
elaborate myfir -arch behavioural -lib WORK
create_clock -name MY_CLK -period 12.4 CLK
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_area > report_area_12_4.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/myfir.sdf
write -f verilog -hierarchy -output ../netlist/myfir.v
write_sdc ../netlist/myfir.sdc
quit