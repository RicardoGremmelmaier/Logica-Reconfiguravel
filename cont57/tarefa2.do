vcom -93 -work work {C:/Users/Ricar/Faculdade/OitavoPeriodo/LogicaReconfiguravel/cont4_LD/cont4_LD.vhd}
vcom -93 -work work {C:/Users/Ricar/Faculdade/OitavoPeriodo/LogicaReconfiguravel/cont57/cont57.vhd}
vcom -reportprogress 300 -work work C:/Users/Ricar/Faculdade/OitavoPeriodo/LogicaReconfiguravel/cont57/cont57_tb.vhd
vsim rtl_work.cont57_tb
add wave  \
 sim:/cont57_tb/CLK \
 sim:/cont57_tb/RST \
 sim:/cont57_tb/Q \
 -radix unsigned -position end sim:/cont57_tb/Q \
 sim:/cont57_tb/EN \
 sim:/cont57_tb/CLR \
 sim:/cont57_tb/LD \
 sim:/cont57_tb/LOAD 
config wave -signalnamewidth 1
run 5000 ns
WaveRestoreZoom {0 fs} {5000 ns}