if {[file exists rtl_work]} {
vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_BCD/cont4_BCD.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont59/cont59.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont59/cont59_tb.vhd
vsim rtl_work.cont59_tb
add wave  \
 sim:/cont59_tb/CLK \
 sim:/cont59_tb/RST \
 sim:/cont59_tb/Q \
 -radix unsigned -position end sim:/cont59_tb/Q \
 sim:/cont59_tb/EN \
 sim:/cont59_tb/CLR \
 sim:/cont59_tb/LD \
 sim:/cont59_tb/LOAD 
config wave -signalnamewidth 1
run 5000 ns
WaveRestoreZoom {0 fs} {5000 ns}