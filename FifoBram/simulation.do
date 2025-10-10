if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/Fifo1024/fifo1024.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/bram2048/bram2048.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/FifoBram/fifobram.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/FifoBram/fifobram_tb.vhd
vsim rtl_work.fifobram_tb
add wave -position insertpoint  \
sim:/fifobram_tb/UUT/CLK \
-radix hexadecimal sim:/fifobram_tb/UUT/DATA_OUT \
sim:/fifobram_tb/UUT/current_state \
sim:/fifobram_tb/UUT/next_state \
-radix unsigned sim:/fifobram_tb/UUT/counter_s \
sim:/fifobram_tb/UUT/fifo_empty_s \
sim:/fifobram_tb/UUT/fifo_almost_empty_s \
sim:/fifobram_tb/UUT/fifo_almost_full_s \
sim:/fifobram_tb/UUT/rdreq_s \
sim:/fifobram_tb/UUT/wrreq_s \
sim:/fifobram_tb/UUT/fifo_usedw_s \
-radix hexadecimal sim:/fifobram_tb/UUT/bram_1_address_s \
-radix hexadecimal sim:/fifobram_tb/UUT/bram_1_data_s \
-radix hexadecimal sim:/fifobram_tb/UUT/bram_1_out_s \
-radix hexadecimal sim:/fifobram_tb/UUT/bram_2_address_s \
-radix hexadecimal sim:/fifobram_tb/UUT/bram_2_data_s \
-radix hexadecimal sim:/fifobram_tb/UUT/bram_2_out_s 
config wave -signalnamewidth 1
run 350 us
WaveRestoreZoom {0 fs} {350 us}