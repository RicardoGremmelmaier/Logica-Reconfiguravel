if {[file exists rtl_work]} {
vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work
vcom -93 -work work {C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/StateMachine/StateMachine.vhd}
vcom -reportprogress 300 -work work C:/Faculdade/OitavoPeriodo/Logica-Reconfiguravel/StateMachine/StateMachine_tb.vhd
vsim rtl_work.StateMachine_tb
add wave  \
 sim:/StateMachine_tb/RST \
 sim:/StateMachine_tb/State_s \
 sim:/StateMachine_tb/Clr_btn_s \
 sim:/StateMachine_tb/Pause_btn_s 
config wave -signalnamewidth 1
run 5000 ns
WaveRestoreZoom {0 fs} {5000 ns}