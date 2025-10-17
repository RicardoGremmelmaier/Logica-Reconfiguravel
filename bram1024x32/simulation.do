if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/bram1024x32/bram1024x32.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/bram1024x32/bram1024x32_tb.vhd
vsim rtl_work.bram1024x32_tb
add wave -position insertpoint  \
sim:/bram1024x32_tb/CLK \
sim:/bram1024x32_tb/wren_s \
-radix unsigned sim:/bram1024x32_tb/data_s \
-radix unsigned sim:/bram1024x32_tb/address_s \
-radix unsigned sim:/bram1024x32_tb/q_s 
config wave -signalnamewidth 1
run 80 us
WaveRestoreZoom {0 fs} {80 us}