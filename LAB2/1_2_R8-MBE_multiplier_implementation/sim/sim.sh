source /eda/scripts/init_questa_core_prime
mkdir work
vlib work

vlog ../src/be.sv

vlog ../tb/be_tb.sv

# run the simulation script
vsim work.be_tb -c -voptargs="+acc" -do "source compile.tcl" #GUI
#vsim work.be_tb -voptargs="+acc" -do "source compile.tcl"  #NOGUI
