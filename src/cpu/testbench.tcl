vlog -reportprogress 300 -work quad_nibble {alu/alu_constants.sv}
vlog -reportprogress 300 -work quad_nibble {alu/alu.sv}
vlog -reportprogress 300 -work quad_nibble {alu/testbench.sv}
vlog -reportprogress 300 -work quad_nibble {progmem/progmem.sv}
vlog -reportprogress 300 -work quad_nibble {progmem/testbench.sv}
vlog -reportprogress 300 -work quad_nibble {cpu.sv}
vlog -reportprogress 300 -work quad_nibble {testbench.sv}
vsim quad_nibble.testbench
view *
do wave.do
run 1000 ns
