onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/resetn
add wave -noupdate /testbench/clk
add wave -noupdate -divider DUT
add wave -noupdate -radix hexadecimal /testbench/DUT/ctrl
add wave -noupdate -radix hexadecimal /testbench/DUT/a
add wave -noupdate -radix hexadecimal /testbench/DUT/b
add wave -noupdate -radix hexadecimal /testbench/DUT/y
add wave -noupdate -divider Verification
add wave -noupdate -radix decimal /testbench/op_a
add wave -noupdate -radix decimal /testbench/op_b
add wave -noupdate -radix decimal -childformat {{{/testbench/result[15]} -radix hexadecimal} {{/testbench/result[14]} -radix hexadecimal} {{/testbench/result[13]} -radix hexadecimal} {{/testbench/result[12]} -radix hexadecimal} {{/testbench/result[11]} -radix hexadecimal} {{/testbench/result[10]} -radix hexadecimal} {{/testbench/result[9]} -radix hexadecimal} {{/testbench/result[8]} -radix hexadecimal} {{/testbench/result[7]} -radix hexadecimal} {{/testbench/result[6]} -radix hexadecimal} {{/testbench/result[5]} -radix hexadecimal} {{/testbench/result[4]} -radix hexadecimal} {{/testbench/result[3]} -radix hexadecimal} {{/testbench/result[2]} -radix hexadecimal} {{/testbench/result[1]} -radix hexadecimal} {{/testbench/result[0]} -radix hexadecimal}} -radixshowbase 0 -subitemconfig {{/testbench/result[15]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[14]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[13]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[12]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[11]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[10]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[9]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[8]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[7]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[6]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[5]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[4]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[3]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[2]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[1]} {-height 15 -radix hexadecimal -radixshowbase 0} {/testbench/result[0]} {-height 15 -radix hexadecimal -radixshowbase 0}} /testbench/result
add wave -noupdate -radix decimal /testbench/expected
add wave -noupdate -radix decimal /testbench/CHECKER/errors
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {64 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 183
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
WaveRestoreZoom {0 ns} {115 ns}
