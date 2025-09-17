vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_BCD/cont4_BCD.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_BCD/cont4_BCD_tb.vhd
vsim rtl_work.cont4_BCD_tb
add wave -position end  sim:/cont4_BCD_tb/CLK
add wave -position end  sim:/cont4_BCD_tb/RST
add wave -position end  sim:/cont4_BCD_tb/Q
add wave -position end  sim:/cont4_BCD_tb/EN
add wave -position end  sim:/cont4_BCD_tb/CLR
add wave -position end  sim:/cont4_BCD_tb/LD
add wave -position end  sim:/cont4_BCD_tb/LOAD
config wave -signalnamewidth 1
run 1000 ns
WaveRestoreZoom {0 fs} {1000 ns}