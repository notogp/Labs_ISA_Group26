analyze -f vhdl -lib WORK ../src/register.vhd
analyze -f vhdl -lib WORK ../src/fir_unfolded_pipelined.vhd
set power_preserve_rtl_hier_names true
elaborate myfir_unfolded_pipelined -arch behavioural -lib WORK
create_clock -name MY_CLK -period 10.0 CLK  
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_timing > report_timing_10.txt
report_area > report_area_10.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/myfir_unfolded_pipelined.sdf
write -f verilog -hierarchy -output ../netlist/myfir_unfolded_pipelined.v
write_sdc ../netlist/myfir_unfolded_pipelined.sdc
quit


#CLK at 2.5 to met slack 0 