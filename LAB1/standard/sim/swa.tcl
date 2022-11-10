vsim -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir
vsim -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fir/UUT=../netlist/myfir.sdf work.tb_fir
vcd file ../vcd/myfir_syn.vcd
vcd add /tb_fir/UUT/*
run 25 us
quit