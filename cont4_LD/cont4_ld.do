vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_LD/cont4_LD.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_LD/cont4_LD_tb.vhd
vsim rtl_work.cont4_ld_tb
add wave -position end  sim:/cont4_ld_tb/CLK
add wave -position end  sim:/cont4_ld_tb/RST
add wave -position end  sim:/cont4_ld_tb/Q
add wave -position end  sim:/cont4_ld_tb/EN
add wave -position end  sim:/cont4_ld_tb/CLR
add wave -position end  sim:/cont4_ld_tb/LD
add wave -position end  sim:/cont4_ld_tb/LOAD
config wave -signalnamewidth 1
run 1000 ns
WaveRestoreZoom {0 fs} {1000 ns}