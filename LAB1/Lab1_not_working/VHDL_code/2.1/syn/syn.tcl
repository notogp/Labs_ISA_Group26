analyze -f vhdl -lib WORK ../components/constants.vhd
analyze -f vhdl -lib WORK ../components/FF.vhd
analyze -f vhdl -lib WORK ../components/reg.vhd
analyze -f vhdl -lib WORK ../src/FIR_cu.vhd
analyze -f vhdl -lib WORK ../src/FIR_dp.vhd
analyze -f vhdl -lib WORK ../src/FIR_Filter.vhd
set power_preserve_rtl_hier_names true
elaborate FIR_Filter -arch behavioural -lib WORK
create_clock -name MY_CLK -period 12.4 CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile 
report_timing > f_4_timing.txt
report_area > f_4_area.txt
