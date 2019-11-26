`timescale 1 ps / 1 ps

module testram(
	input wire WE,
	input wire OE,
	input wire [0:19]ADDR,
	inout [0:15]DATA
);
	reg [0:15]mem[0:(1<<20)] ;

	assign DATA = (WE && !OE) ? mem[ADDR] : 16'hZZZZ;
	
	initial begin
		 //$readmemh("sram_zeroed.mem", mem);
	end
	
	always @(WE or OE) begin
		if(!WE) begin
			mem[ADDR] <= DATA;
		end
	end
	
	always @(WE or OE) begin
		if (!WE && !OE) begin
			$display("Error: OE and WE are mutually exclusive");
		end
	end
endmodule