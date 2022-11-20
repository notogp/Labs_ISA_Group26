vsim -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_filter
vsim -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_filter/UUT=../netlist/myfir_unfolded_pipelined.sdf work.tb_filter
vcd file ../vcd/myfir_syn_unfolded_pipelined.vcd
vcd add /tb_filter/UUT/*
run 25 us
quit