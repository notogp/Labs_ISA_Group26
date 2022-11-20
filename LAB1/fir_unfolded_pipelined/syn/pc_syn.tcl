read_verilog -netlist ../innovus/myfir_unfolded_pipelined.v
read_saif -input ../saif/myfir_syn_unfolded_pipelined_innovus.saif -instance tb_filter/UUT -unit ns -scale 1
create_clock -name MY_CLK -period 10.0 CLK
report_power > report_power_sw_act_unfolded_pipelined_innovus.txt