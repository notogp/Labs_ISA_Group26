source /eda/scripts/init_questa_core_prime > /dev/null
source /eda/scripts/init_design_vision > /dev/null

vcom -work ./work ../tb/clk_gen.vhd
vcom -work ./work ../tb/data_maker_new.vhd
vcom -work ./work ../tb/data_sink.vhd
vlog -work ./work ../netlist/myfir.v
vlog -work ./work ../tb/tb_fir.v
vsim -c -do swa.tcl

vcd2saif -input ../vcd/myfir_syn.vcd -output ../saif/myfir_syn.saif
