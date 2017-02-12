vlog -reportprogress 300 -work quad_nibble {alu_constants.sv}
vlog -reportprogress 300 -work quad_nibble {alu.sv}
vlog -reportprogress 300 -work quad_nibble {testbench.sv}
vsim quad_nibble.testbench
view *
do wave.do
run 400 ns
