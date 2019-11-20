transcript on
if ![file isdirectory board_iputf_libs] {
	file mkdir board_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
vlib board_iputf_libs/external_memory_bfm_0
vmap external_memory_bfm_0 ./board_iputf_libs/external_memory_bfm_0
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 

file copy -force /home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.hex ./

vlog -sv "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.sv" -work external_memory_bfm_0
vlog     "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/testram.v"                                                           

vlog -vlog01compat -work work +incdir+/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d {/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/VGA_Controller.v}
vlog -vlog01compat -work work +incdir+/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d {/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/vgadll.v}
vlog -vlog01compat -work work +incdir+/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d {/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/controller.v}
vlog -vlog01compat -work work +incdir+/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/db {/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/db/vgadll_altpll.v}

vlog -vlog01compat -work work +incdir+/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d {/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L external_memory_bfm_0 -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
