if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/Fifo1024/fifo1024.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/Fifo1024/fifo1024_tb.vhd
vsim rtl_work.fifo1024_tb
add wave -position insertpoint  \
sim:/fifo1024_tb/CLK \
sim:/fifo1024_tb/RST \
-radix hexadecimal sim:/fifo1024_tb/data_s \
-radix hexadecimal sim:/fifo1024_tb/q_s \
sim:/fifo1024_tb/rdreq_s \
sim:/fifo1024_tb/wrreq_s \
-radix unsigned sim:/fifo1024_tb/usedw_s \
sim:/fifo1024_tb/almost_empty_s \
sim:/fifo1024_tb/almost_full_s \
sim:/fifo1024_tb/empty_s \
sim:/fifo1024_tb/full_s
config wave -signalnamewidth 1
run 50 us
WaveRestoreZoom {0 fs} {50 us}