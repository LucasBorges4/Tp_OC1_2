transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/tarik/OneDrive/햞ea\ de\ Trabalho/TP_ISL_Parte2/Arquivos_System_Builder_Verilogs {C:/Users/tarik/OneDrive/햞ea de Trabalho/TP_ISL_Parte2/Arquivos_System_Builder_Verilogs/Verilog1.v}
vlog -vlog01compat -work work +incdir+C:/Users/tarik/OneDrive/햞ea\ de\ Trabalho/TP_ISL_Parte2/Arquivos_System_Builder_Verilogs {C:/Users/tarik/OneDrive/햞ea de Trabalho/TP_ISL_Parte2/Arquivos_System_Builder_Verilogs/de2_115.v}

