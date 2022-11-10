read_verilog -netlist ../netlist/myfir.v
read_saif -input ../saif/myfir_syn.saif -instance tb fir/UUT -unit ns -scale 1
create_clock -name MY_CLK -period 12.4 CLK
report_power > report_power_sw_act.txt