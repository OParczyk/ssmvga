
cp -f /home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.hex ./

ncvlog -sv "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.sv" -work external_memory_bfm_0 -cdslib <<external_memory_bfm_0>>
ncvlog     "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/testram.v"                                                                                             
