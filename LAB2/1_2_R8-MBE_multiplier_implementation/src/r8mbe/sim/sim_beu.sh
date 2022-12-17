source /eda/scripts/init_questa_core_prime
mkdir work
vlib work

vlog ../src/be.sv
vlog ../src/beu.sv

vlog ../tb/beu_tb.sv

# run the simulation script
#vsim work.beu_tb -c -voptargs="+acc" -do "source compile.tcl" #GUI
vsim work.beu_tb -voptargs="+acc" -do "source compile.tcl"  #NOGUI
