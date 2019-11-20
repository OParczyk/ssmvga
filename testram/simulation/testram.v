// testram.v

// Generated using ACDS version 19.1 670

`timescale 1 ps / 1 ps
module testram (
		input  wire        clk,              //     clk.clk
		input  wire        cdt_write,        // conduit.cdt_write
		input  wire        cdt_read,         //        .cdt_read
		input  wire        cdt_chipselect,   //        .cdt_chipselect
		input  wire        cdt_outputenable, //        .cdt_outputenable
		input  wire [19:0] cdt_address,      //        .cdt_address
		inout  wire [15:0] cdt_data_io,      //        .cdt_data_io
		input  wire [0:0]  cdt_byteenable    //        .cdt_byteenable
	);

	altera_external_memory_bfm #(
		.USE_CHIPSELECT           (1),
		.USE_WRITE                (1),
		.USE_READ                 (1),
		.USE_OUTPUTENABLE         (1),
		.USE_BEGINTRANSFER        (0),
		.ACTIVE_LOW_BYTEENABLE    (1),
		.ACTIVE_LOW_CHIPSELECT    (1),
		.ACTIVE_LOW_WRITE         (1),
		.ACTIVE_LOW_READ          (1),
		.ACTIVE_LOW_OUTPUTENABLE  (1),
		.ACTIVE_LOW_BEGINTRANSFER (0),
		.ACTIVE_LOW_RESET         (0),
		.CDT_ADDRESS_W            (20),
		.CDT_SYMBOL_W             (16),
		.CDT_NUMSYMBOLS           (1),
		.INIT_FILE                ("altera_external_memory_bfm.hex"),
		.CDT_READ_LATENCY         (0),
		.VHDL_ID                  (0)
	) external_memory_bfm_0 (
		.clk               (clk),              //     clk.clk
		.cdt_write         (cdt_write),        // conduit.cdt_write
		.cdt_read          (cdt_read),         //        .cdt_read
		.cdt_chipselect    (cdt_chipselect),   //        .cdt_chipselect
		.cdt_outputenable  (cdt_outputenable), //        .cdt_outputenable
		.cdt_address       (cdt_address),      //        .cdt_address
		.cdt_data_io       (cdt_data_io),      //        .cdt_data_io
		.cdt_byteenable    (cdt_byteenable),   //        .cdt_byteenable
		.cdt_begintransfer (1'b0),             // (terminated)
		.cdt_reset         (1'b0)              // (terminated)
	);

endmodule