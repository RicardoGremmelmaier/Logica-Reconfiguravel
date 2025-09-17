if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/StateMachine/StateMachine.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/CronometroDigital/cronometro.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_BCD/cont4_BCD.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont59/cont59.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont99/cont99.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/Divisor/Divisor.vhd}
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/hexTo7Seg/hexTo7Seg.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/CronometroDigital/cronometro_tb.vhd
vsim rtl_work.cronometro_tb
add wave  \
sim:/cronometro_tb/CLK \
sim:/cronometro_tb/RST \
sim:/cronometro_tb/hex0_s \
sim:/cronometro_tb/hex1_s \
sim:/cronometro_tb/hex2_s \
sim:/cronometro_tb/hex3_s \
sim:/cronometro_tb/StartStop_btn_s \
sim:/cronometro_tb/Clr_btn_s
config wave -signalnamewidth 1
run 2000 ms
WaveRestoreZoom {0 fs} {1000 ms}