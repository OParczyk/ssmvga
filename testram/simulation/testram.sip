set_global_assignment -entity "testram" -library "lib_testram" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "testram" -library "lib_testram" -name IP_TOOL_VERSION "19.1"
set_global_assignment -entity "testram" -library "lib_testram" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_testram" -name SPD_FILE [file join $::quartus(sip_path) "../testram.spd"]
set_global_assignment -library "lib_testram" -name MISC_FILE [file join $::quartus(sip_path) "../../testram.qsys"]

set_global_assignment -library "lib_testram" -name MISC_FILE [file join $::quartus(sip_path) "testram.v"]
set_global_assignment -library "lib_testram" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_external_memory_bfm.sv"]
set_global_assignment -library "lib_testram" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_external_memory_bfm.hex"]
