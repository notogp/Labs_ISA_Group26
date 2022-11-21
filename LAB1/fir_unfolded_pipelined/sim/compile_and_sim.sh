source /eda/scripts/init_questa_core_prime

# compile everything
vlib work

# vhdl sources
vcom -work ./work ../src/*.vhd
# testbenches
vcom -work ./work ../tb/*.vhd
# final verilog top level tb
vlog -work ./work ../tb/*.v

# run the simulation script
#vsim work.tb_filter -c -voptargs="+acc" -do "source sim.tcl"
vsim work.tb_filter -voptargs="+acc" -do "source sim.tcl"
