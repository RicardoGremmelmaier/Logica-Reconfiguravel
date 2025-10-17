vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/reg32_sc/reg32_sc.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/reg32_sc/reg32_sc_tb.vhd
vsim +altera -do cont4_run_msim_rtl_vhdl.do -l msim_transcript -gui rtl_work.reg32_sc_tb
add wave  \
sim:/reg32_sc_tb/CLK_s \
sim:/reg32_sc_tb/RST_n_s \
sim:/reg32_sc_tb/WR_EN_s \
sim:/reg32_sc_tb/SC_s \
-radix hex sim:/reg32_sc_tb/DataIn_s \
-radix hex sim:/reg32_sc_tb/DataOut_s
config wave -signalnamewidth 1
run 400 ns
WaveRestoreZoom {0 fs} {400 ns}