source /eda/scripts/init_questa_core_prime > /dev/null
source /eda/scripts/init_design_vision > /dev/null

vcom -work ./work ../tb/clk_gen.vhd
vcom -work ./work ../tb/data_maker_new_unfolded.vhd
vcom -work ./work ../tb/data_sink_unfolded.vhd
vlog -work ./work ../innovus/myfir_unfolded_pipelined.v
vlog -work ./work ../tb/tb_filter_unfolded_pipelined.v
vsim -c -do swa_innovus.tcl

vcd2saif -input ../vcd/myfir_syn_unfolded_pipelined_innovus.vcd -output ../saif/myfir_syn_unfolded_pipelined_innovus.saif
