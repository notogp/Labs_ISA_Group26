ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/FIR_Filter.sdf
write -f verilog -hierarchy -output ../netlist/FIR_Filter.v
write_sdc ../netlist/FIR_Filter.sdc
quit
