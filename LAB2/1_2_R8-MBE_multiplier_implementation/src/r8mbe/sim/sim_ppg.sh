source /eda/scripts/init_questa_core_prime
mkdir work
vlib work

vlog ../src/ppg.sv

vlog ../tb/ppg_tb.sv

# run the simulation script
#vsim work.ppg_tb -c -voptargs="+acc" -do "source compile.tcl" #GUI
vsim work.ppg_tb -voptargs="+acc" -do "source compile.tcl"  #NOGUI
