if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/bram1024x32/bram1024x32.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/reg32_sc/reg32_sc.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/UserHW/UserHW.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/UserHW/UserHW_tb.vhd
vsim rtl_work.userhw_tb
add wave -position insertpoint  \
sim:/userhw_tb/state \
sim:/userhw_tb/CLK \
sim:/userhw_tb/rst \
sim:/userhw_tb/rst_n \
sim:/userhw_tb/WR_EN_s \
sim:/userhw_tb/RD_EN_s \
sim:/userhw_tb/ChipSelector_s \
-radix hexadecimal sim:/userhw_tb/WriteData_s \
-radix hexadecimal sim:/userhw_tb/ReadData_s \
sim:/userhw_tb/ADD_s \
-radix hexadecimal sim:/userhw_tb/address 
add wave -position insertpoint  \
sim:/userhw_tb/UUT/wr_en0_s \
sim:/userhw_tb/UUT/wr_en1_s \
sim:/userhw_tb/UUT/wr_en2_s \
sim:/userhw_tb/UUT/rd_en_reg0_s \
sim:/userhw_tb/UUT/rd_en_reg1_s \
sim:/userhw_tb/UUT/rd_en_reg2_s \
sim:/userhw_tb/UUT/rd_en_bram_s 
add wave -position insertpoint  \
-radix hexadecimal sim:/userhw_tb/UUT/reg0_out_s \
-radix hexadecimal sim:/userhw_tb/UUT/reg1_out_s \
-radix hexadecimal sim:/userhw_tb/UUT/reg2_out_s \
-radix hexadecimal sim:/userhw_tb/UUT/bram_out_s
config wave -signalnamewidth 1
run 3000 ns
WaveRestoreZoom {0 fs} {3000 ns}