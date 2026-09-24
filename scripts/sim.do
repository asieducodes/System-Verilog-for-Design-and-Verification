# scripts/sim.do
# Usage (from sim/): vsim -do ../scripts/sim.do

set DIR ../02_design/combinational
set TOP tb_mux

.main clear
catch {quit -sim}

if {[file exists work]} { vdel -lib work -all }
vlib work

vlog -sv $DIR/design.sv $DIR/tb.sv

vsim -voptargs=+acc work.$TOP
log -r /*
add wave -position insertpoint sim:/$TOP/*
run -all
wave zoom full