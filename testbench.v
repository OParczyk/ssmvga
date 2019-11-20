`timescale 1 ps / 1 ps
module tram(input wire clk, input wire we, input wire [19:0]addr, inout [15:0]data, input wire OE);
	reg [15:0]mem[524288];
	reg [15:0]datareg;

	assign data=(we & ~OE)?mem[addr]:16'hzzzz;
	always @(posedge clk) begin
		if(~we) mem[addr]<=data;
		else if(~OE) datareg<=mem[addr];
	end
endmodule

module single_port_ram
//RAM module as copied from the Intel homepage.
(
   input [15:0] data,
   input [15:0] addr,
   input we, clk,
   output [15:0] q
);

   // Declare the RAM variable
   reg [15:0] ram[65535:0]; // 2 byte per cell, 65535 cells
   // Variable to hold the registered read address
   reg [15:0] addr_reg; //16 bit address bus
   
   always @ (posedge clk)
   begin
   // Write
      if (we)
         ram[addr] <= data;

      addr_reg <= addr;
   end
      
   // Continuous assignment implies read returns NEW data.
   // This is the natural behavior of the TriMatrix memory
   // blocks in Single Port mode.  
   assign q = ram[addr_reg];
   
endmodule

module testbench(output FOO);
	reg clk50mhz;
	reg clk27mhz;
	
	initial begin
		#1;
		clk50mhz = 0;
		#1;
		clk27mhz = 0;
	end
	
	always begin 
		#10000; clk50mhz= ~clk50mhz;
	end
	always begin 
		#37037; clk27mhz= ~clk27mhz;
	end
	
	wire        clk;//     clk.clk
	wire        cdt_write;// conduit.cdt_write
	wire        cdt_outputenable;//        .cdt_outputenable
	wire [19:0] cdt_address;      //        .cdt_address
	wire [15:0] cdt_data_io;      //        .cdt_data_io

	/*testram ram(
		.clk(clk50mhz), 
		.cdt_write(cdt_write), 
		.cdt_read(~cdt_write),
		.cdt_chipselect(cdt_chipselect),
	   .cdt_outputenable(cdt_outputenable),
	   .cdt_address(cdt_address),
	   .cdt_data_io(cdt_data_io),
	   .cdt_byteenable(cdt_byteenable)
	);*/
	tram ram(
		.clk(clk50mhz),
		.we(cdt_write),
		.addr(cdt_address),
		.data(cdt_data_io),
		.OE(cdt_outputenable)
	);
	
	controller ctrl(
		//LEDR,6
		.TD_CLK27(clk27mhz),
		.CLOCK_50(clk50mhz),
		.VGA_R(FOO),
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
		.SRAM_DQ(cdt_data_io),
		.SRAM_ADDR(cdt_address),
		.SRAM_CE_N(cdt_chipselect),
		.SRAM_UB_N(cdt_byteenable),
		//.SRAM_LB_N(0),
		.SRAM_WE_N(cdt_write),
		.SRAM_OE_N(cdt_outputenable)
		//SW
	);
endmodule
