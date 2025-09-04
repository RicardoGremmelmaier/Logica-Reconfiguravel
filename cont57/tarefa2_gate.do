if {[file exists gate_work]} {
vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work
vcom -93 -work work {cont57_6_1200mv_85c_slow.vho}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont4_LD/cont4_LD.vhd
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/cont57/cont57_tb.vhd
vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /UUT=cont57_6_1200mv_85c_vhd_slow.sdo -L altera -L cycloneive -L gate_work -L work -voptargs="+acc"  cont57_tb
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