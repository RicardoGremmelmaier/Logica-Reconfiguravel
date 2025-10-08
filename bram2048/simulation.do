if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/bram2048/bram2048.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/bram2048/bram2048_tb.vhd
vsim rtl_work.bram2048_tb
add wave -position insertpoint  \
sim:/bram2048_tb/CLK \
sim:/bram2048_tb/wren_s \
-radix hexadecimal sim:/bram2048_tb/data_s \
-radix unsigned sim:/bram2048_tb/address_s \
-radix hexadecimal sim:/bram2048_tb/q_s 
config wave -signalnamewidth 1
run 80 us
WaveRestoreZoom {0 fs} {80 us}