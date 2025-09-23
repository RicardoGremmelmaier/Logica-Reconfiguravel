vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/TotalizadorA/TotalizadorA.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/TotalizadorA/TotalizadorA_tb.vhd
vsim rtl_work.TotalizadorA_tb
add wave -position end  sim:/TotalizadorA_tb/CLK
add wave -position end  sim:/TotalizadorA_tb/DataIn_s
add wave -position insertpoint  \
-radix unsigned sim:/TotalizadorA_tb/UUT/DataOut \
sim:/totalizadora_tb/UUT/counter \
sim:/totalizadora_tb/UUT/iterator
config wave -signalnamewidth 1
run 500 ns
WaveRestoreZoom {0 fs} {500 ns}