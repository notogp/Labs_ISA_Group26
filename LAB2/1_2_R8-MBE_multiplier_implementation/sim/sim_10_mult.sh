source /eda/scripts/init_questa_core_prime
mkdir work
vlib work

vlog ../src/cf_math_pkg.sv
vlog ../src/lzc.sv
vlog ../src/rr_arb_tree.sv
vlog ../src/fpnew_pkg.sv
vlog ../src/fpnew_classifier.sv
vlog ../src/fpnew_rounding.sv
vlog ../src/fpnew_fma.sv
vlog ../src/fpnew_opgroup_fmt_slice.sv
vlog ../src/fpnew_opgroup_block.sv
vlog ../src/fpnew_top.sv

vcom ../tb/clk_gen.vhd
vcom ../tb/data_gen.vhd
vlog ../tb/tb_fpnew_top_rtl.sv

# run the simulation script
vsim work.tb_fpnew_top -voptargs="+acc" -do "source compile.tcl"
