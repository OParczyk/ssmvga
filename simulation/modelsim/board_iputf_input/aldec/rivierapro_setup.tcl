
file copy -force /home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.hex ./

vlog       "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.sv" -work external_memory_bfm_0
vlog -v2k5 "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/testram.v"                                                           
