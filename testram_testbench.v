`timescale 1 ps / 1 ps
module testram_testbench(output __dummy__);
	reg clk50mhz;
	reg clk27mhz;
	reg [0:15]addr;
	reg [0:15]data;
	reg we, oe;
	reg [0:4]state;
	reg initialized = 0;
	
	wire [15:0] tr_data; 
	
	initial begin
		initialized = 0;
		#1;
		data = 0;
		addr = 0;
		state = 0;
		#1;
		we <= 0;
		oe <= 1;
		#1;
		we <= 1;
		#1;
		clk50mhz = 0;
		clk27mhz = 0;
		initialized <= 1;
	end
	
	always begin
		#10000; 
		 if (initialized) clk50mhz= ~clk50mhz;
	end
	
	always begin 
		#37037; 
		if (initialized) clk27mhz= ~clk27mhz;
	end

	
	
	assign tr_data = (!we && oe)?data:16'hZZZZ;
	
	testram tram(
		.WE(we),
		.OE(oe),
		.ADDR(addr),
		.DATA(tr_data)
	);
	
	always @(posedge clk50mhz) begin
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
endmodule
