source /eda/scripts/init_questa_core_prime
rm -rf work/
mkdir work
vlib work

vlog ../src/ppg.sv
vlog ../src/be.sv
vlog ../src/beu.sv
vlog ../src/bs.sv
vlog ../src/bsu.sv
vlog ../src/r8mbe_top.sv


vlog ../tb/r8mbe_tb.sv

# run the simulation script
#vsim work.r8mbe_tb -c -voptargs="+acc" -do "source compile.tcl" #NOGUI
vsim work.r8mbe_tb -voptargs="+acc" -do "source compile.tcl"  #GUI
