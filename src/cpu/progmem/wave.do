onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/resetn
add wave -noupdate -divider DUT
add wave -noupdate -radix hexadecimal /testbench/DUT/addr
add wave -noupdate -radix hexadecimal /testbench/DUT/din
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/DUT/dout[15]} -radix hexadecimal} {{/testbench/DUT/dout[14]} -radix hexadecimal} {{/testbench/DUT/dout[13]} -radix hexadecimal} {{/testbench/DUT/dout[12]} -radix hexadecimal} {{/testbench/DUT/dout[11]} -radix hexadecimal} {{/testbench/DUT/dout[10]} -radix hexadecimal} {{/testbench/DUT/dout[9]} -radix hexadecimal} {{/testbench/DUT/dout[8]} -radix hexadecimal} {{/testbench/DUT/dout[7]} -radix hexadecimal} {{/testbench/DUT/dout[6]} -radix hexadecimal} {{/testbench/DUT/dout[5]} -radix hexadecimal} {{/testbench/DUT/dout[4]} -radix hexadecimal} {{/testbench/DUT/dout[3]} -radix hexadecimal} {{/testbench/DUT/dout[2]} -radix hexadecimal} {{/testbench/DUT/dout[1]} -radix hexadecimal} {{/testbench/DUT/dout[0]} -radix hexadecimal}} -subitemconfig {{/testbench/DUT/dout[15]} {-radix hexadecimal} {/testbench/DUT/dout[14]} {-radix hexadecimal} {/testbench/DUT/dout[13]} {-radix hexadecimal} {/testbench/DUT/dout[12]} {-radix hexadecimal} {/testbench/DUT/dout[11]} {-radix hexadecimal} {/testbench/DUT/dout[10]} {-radix hexadecimal} {/testbench/DUT/dout[9]} {-radix hexadecimal} {/testbench/DUT/dout[8]} {-radix hexadecimal} {/testbench/DUT/dout[7]} {-radix hexadecimal} {/testbench/DUT/dout[6]} {-radix hexadecimal} {/testbench/DUT/dout[5]} {-radix hexadecimal} {/testbench/DUT/dout[4]} {-radix hexadecimal} {/testbench/DUT/dout[3]} {-radix hexadecimal} {/testbench/DUT/dout[2]} {-radix hexadecimal} {/testbench/DUT/dout[1]} {-radix hexadecimal} {/testbench/DUT/dout[0]} {-radix hexadecimal}} /testbench/DUT/dout
add wave -noupdate -radix binary /testbench/DUT/write_en
add wave -noupdate /testbench/DUT/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {304690 ps}
