
module testram (
	clk,
	cdt_write,
	cdt_read,
	cdt_chipselect,
	cdt_outputenable,
	cdt_address,
	cdt_data_io,
	cdt_byteenable);	

	input		clk;
	input		cdt_write;
	input		cdt_read;
	input		cdt_chipselect;
	input		cdt_outputenable;
	input	[19:0]	cdt_address;
	inout	[15:0]	cdt_data_io;
	input	[0:0]	cdt_byteenable;
endmodule
