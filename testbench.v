`timescale 1 ps / 1 ps
module testbench(output __dummy__);
	reg clk50mhz;
	reg clk27mhz;
	reg [0:15]addr;
	reg [0:15]data;
	reg we, oe;
	reg [0:4]state;
	reg initialized = 0;
	
	initial begin
		#10000;
		clk50mhz = 0;
		clk27mhz = 0;
		data = 0;
		addr = 0;
		state = 0;
		#10000;
		we <= 0;
		oe <= 1;
		#10000;
		we <= 1;
		#10000;
		initialized <= 1;
		
	end
	
	always begin 
		#10000; clk50mhz= ~clk50mhz;
	end
	always begin 
		#37037; clk27mhz= ~clk27mhz;
	end

	wire [15:0] tr_data; 
	
	assign tr_data = (!we && oe)?data:16'hZZZZ;
	
	tram ram(
		.WE(we),
		.OE(oe),
		.ADDR(addr),
		.DATA(tr_data)
	);
	
	always @(posedge clk50mhz && initialized) begin
		
		case(state)
			0: begin
				we <= 0;
				oe <= 1;
				state <= state + 1;
			end
			1: begin
				data <= tr_data;
				state <= state + 1;
			end
			2: begin
				data <= data + 1;
				state <= state + 1;
			end
			3: begin
				we <= 0;
				oe <= 1;
				state = 0;
			end
		endcase
	end
	
	/*
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
	*/
endmodule
