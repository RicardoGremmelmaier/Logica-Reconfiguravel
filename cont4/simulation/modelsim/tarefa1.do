vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4/cont4.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4/cont4_tb.vhd
vsim +altera -do cont4_run_msim_rtl_vhdl.do -l msim_transcript -gui rtl_work.cont4_tb
add wave  \
sim:/cont4_tb/RST_s \
sim:/cont4_tb/CLK_s \
sim:/cont4_tb/EN_s \
sim:/cont4_tb/CLR_s \
-radix hex sim:/cont4_tb/Q_s
config wave -signalnamewidth 1
run 400 ns
WaveRestoreZoom {0 fs} {400 ns}