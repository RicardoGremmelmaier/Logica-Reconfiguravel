if {[file exists rtl_work]} {
vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_BCD/cont4_BCD.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont99/cont99.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont99/cont99_tb.vhd
vsim rtl_work.cont99_tb
add wave  \
 sim:/cont99_tb/CLK \
 sim:/cont99_tb/RST \
 sim:/cont99_tb/Q \
 -radix unsigned -position end sim:/cont99_tb/Q \
 sim:/cont99_tb/EN \
 sim:/cont99_tb/CLR \
 sim:/cont99_tb/LD \
 sim:/cont99_tb/LOAD 
config wave -signalnamewidth 1
run 5000 ns
WaveRestoreZoom {0 fs} {5000 ns}