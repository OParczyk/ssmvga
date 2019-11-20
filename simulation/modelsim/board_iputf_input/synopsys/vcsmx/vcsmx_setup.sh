
cp -f /home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.hex ./

vlogan +v2k -sverilog "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/submodules/altera_external_memory_bfm.sv" -work external_memory_bfm_0
vlogan +v2k           "/home/oliver/MEGA/MEGAsync/workspace/FPGA-Projekte/diff2d/testram/simulation/testram.v"                                                           
