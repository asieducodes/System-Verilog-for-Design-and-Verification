# scripts/sim.do
# Usage (from sim/): vsim -do ../scripts/sim.do

set DIR "../02_design/combinational"
set TOP "tb_mux4x1"

.main clear
catch {quit -sim}

if {[file exists work]} { vdel -lib work -all }
vlib work

# Fix: Wrapped the variables in ${} to ensure accurate string concatenation
vlog -sv ${DIR}/mux4x1.sv ${DIR}/tb_mux4x1.sv

# Fix: Wrapped TOP in ${} so the simulator accurately points to work.tb_mux4x1
vsim -voptargs=+acc work.${TOP}
log -r /*
add wave -position insertpoint sim:/${TOP}/*
run -all
wave zoom full
