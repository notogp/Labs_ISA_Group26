#!/bin/sh

vlib work
vcom -work ./work ../src/*.vhd
vcom -work ./work ../tb/*.vhd
vlog -work ./work ../tb/*.v

vsim -c work.$1_tb -voptargs="+acc" -do "source sim.tcl"
