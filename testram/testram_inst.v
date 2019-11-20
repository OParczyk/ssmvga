	testram u0 (
		.clk              (<connected-to-clk>),              //     clk.clk
		.cdt_write        (<connected-to-cdt_write>),        // conduit.cdt_write
		.cdt_read         (<connected-to-cdt_read>),         //        .cdt_read
		.cdt_chipselect   (<connected-to-cdt_chipselect>),   //        .cdt_chipselect
		.cdt_outputenable (<connected-to-cdt_outputenable>), //        .cdt_outputenable
		.cdt_address      (<connected-to-cdt_address>),      //        .cdt_address
		.cdt_data_io      (<connected-to-cdt_data_io>),      //        .cdt_data_io
		.cdt_byteenable   (<connected-to-cdt_byteenable>)    //        .cdt_byteenable
	);

