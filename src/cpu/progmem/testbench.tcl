vlog -reportprogress 300 -work quad_nibble {progmem.sv}
vlog -reportprogress 300 -work quad_nibble {testbench.sv}
vsim quad_nibble.testbench
view *
do wave.do
run 1000 ns
