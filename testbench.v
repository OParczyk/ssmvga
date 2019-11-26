`timescale 1 ps / 1 ps
module testbench(output __dummy__);
	reg clk50mhz;
	reg clk27mhz;
	wire tram_we, tram_oe;
	wire [0:19] tram_addr;
	wire [0:15] tram_data;
	reg initialized;
	
	initial begin
		initialized = 0;
		clk50mhz = 0;
		clk27mhz = 0;
		#1;
		initialized <= 1;
	end
	
	always begin 
		#10000; 
		if(initialized) clk50mhz= ~clk50mhz;
	end
	always begin 
		#37037; 
		if(initialized) clk27mhz= ~clk27mhz;
	end
	
	testram ram(
		.WE(tram_we),
		.OE(tram_oe),
		.ADDR(tram_addr),
		.DATA(tram_data)
	);
	
	controller ctrl(
		//LEDR,6
		.TD_CLK27(clk27mhz),
		.CLOCK_50(clk50mhz),
		//.VGA_R,
		//VGA_G,
		//VGA_B,
		//VGA_HS,
		//VGA_VS,
		//VGA_BLANK_N,
		//VGA_CLK,
		//VGA_VS,
		//VGA_SYNC_N,
		//TD_RESET_N,
		//.KEY(key),
		.SRAM_DQ(tram_data),
		.SRAM_ADDR(tram_addr),
		//.SRAM_CE_N(),
		//.SRAM_UB_N(),
		//.SRAM_LB_N(0),
		.SRAM_WE_N(tram_we),
		.SRAM_OE_N(tram_oe)
		//SW
	);
endmodule
