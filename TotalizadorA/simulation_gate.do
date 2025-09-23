if {[file exists gate_work]} {
vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work
vcom -93 -work work {TotalizadorA.vho}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/TotalizadorA/TotalizadorA_tb.vhd
vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /UUT=TotalizadorA_vhd.sdo -L altera -L cycloneive -L gate_work -L work -voptargs="+acc"  TotalizadorA_tb
add wave  \
 sim:/TotalizadorA_tb/CLK \
 sim:/TotalizadorA_tb/DataIn_s \
 -radix unsigned sim:/TotalizadorA_tb/UUT/DataOut \
 sim:/totalizadora_tb/UUT/counter \
 sim:/totalizadora_tb/UUT/iterator
config wave -signalnamewidth 1
run 500 ns
WaveRestoreZoom {0 fs} {500 ns}