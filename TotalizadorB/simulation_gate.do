if {[file exists gate_work]} {
vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work
vcom -93 -work work {TotalizadorB.vho}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/TotalizadorB/TotalizadorB_tb.vhd
vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /UUT=TotalizadorB_vhd.sdo -L altera -L cycloneive -L gate_work -L work -voptargs="+acc"  TotalizadorB_tb
add wave -position insertpoint  \
sim:/totalizadorb_tb/CLK \
sim:/totalizadorb_tb/DataIn_s \
-radix unsigned sim:/totalizadorb_tb/DataOutB1_s \
-radix unsigned sim:/totalizadorb_tb/DataOutB2_s \
-radix unsigned sim:/totalizadorb_tb/DataOutB3_s \
-radix unsigned sim:/totalizadorb_tb/DataOutB4_s \
-radix unsigned sim:/totalizadorb_tb/DataOutB5_s
config wave -signalnamewidth 1
run 500 ns
WaveRestoreZoom {0 fs} {500 ns}