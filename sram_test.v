module sram_test(LEDR,TD_CLK27,CLOCK_50, VGA_R, VGA_G, VGA_B,VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_VS, VGA_SYNC_N, TD_RESET_N, KEY,
SRAM_DQ, SRAM_ADDR,SRAM_CE_N,SRAM_UB_N,SRAM_LB_N, SRAM_WE_N,SRAM_OE_N, SW
);
input CLOCK_50;
input TD_CLK27;
input [3:0]KEY;
input [17:0] SW;
output [19:0]SRAM_ADDR;
output [9:0] VGA_R,VGA_G,VGA_B;
output TD_RESET_N;
output VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N,SRAM_CE_N,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_OE_N;
output[17:0]LEDR;
inout [15:0]SRAM_DQ;

reg led;
wire c1,c0;
wire locked;
assign TD_RESET_N=1'b1;
assign SRAM_CE_N=1'b0;
assign SRAM_UB_N=1'b0;
assign SRAM_LB_N=1'b0;
assign SRAM_OE_N=~we;

wire reset;

reg[19:0]addr_reg;
reg[15:0]data_reg;
reg we;
assign SRAM_WE_N=we;

assign SRAM_DQ=(we)?16'hzzzz:data_reg;
assign LEDR=SRAM_DQ;
assign SRAM_ADDR=addr_reg;

always @(posedge CLOCK_50) begin
addr_reg<=SW;
if(KEY[0]) begin
we=1'b1;
end
else begin
we=1'b0;
data_reg<=16'b1010101010111;
end
end

endmodule
