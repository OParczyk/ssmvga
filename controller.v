module    Reset_Delay(iCLK,oRESET);
input        iCLK;
output reg    oRESET;
reg    [19:0]    Cont;

always@(posedge iCLK)
begin
    if(Cont!=20'hFFFFF)
    begin
        Cont    <=    Cont+1'b1;
        oRESET    <=    1'b0;
    end
    else
    oRESET    <=    1'b1;
end

endmodule

module controller(LEDR,TD_CLK27,CLOCK_50, VGA_R, VGA_G, VGA_B,VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_VS, VGA_SYNC_N, TD_RESET_N, KEY,
 SW, LEDG, HEX0, HEX1, HEX2, HEX3, HEX4
);
input CLOCK_50;
input TD_CLK27;
input [3:0]KEY;
input [17:0]SW;

output [9:0] VGA_R,VGA_G,VGA_B;
output VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N;
output TD_RESET_N;
output[17:0]LEDR;
output[8:0]LEDG;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;

wire locked;
wire [9:0] mVGA_R,mVGA_G,mVGA_B;
wire x_low_bit, y_low_bit;
wire DLY_RST;
wire RST_N = DLY_RST&KEY[0];
wire[9:0]Coord_X,Coord_Y;
wire [6:0] HO0,HO1,HO2,HO3,HO4;

reg[17:0] LEDR_buf;
reg[8:0] LEDG_buf;
reg[19:0]addr_reg;
reg[15:0]data_reg;
reg write_enable;
reg  [30:0] x_rand;
reg  [30:0] y_rand;
reg [3:0] state;
reg sum;
reg [9:0] x_walker;
reg [9:0] y_walker;
reg [12:0] walkercount;

assign TD_RESET_N =1'b1;

wire display_walker;
assign display_walker = (addr_reg == {fix_10_bit_length(x_walker[9:0]),y_walker[9:0]} && (VGA_HS || VGA_VS));
assign x_low_bit=x_rand[22]^x_rand[30];
assign y_low_bit=y_rand[26]^y_rand[28];
assign LEDR={x_walker,y_walker[9:2]};
assign LEDG[7:6]=y_walker[1:0];
assign LEDG[3:0]=state;
assign HO0=addr_reg[3:0];
assign HO1=addr_reg[7:4];
assign HO2=addr_reg[11:8];
assign HO3=addr_reg[15:12];
assign HO4=addr_reg[19:16];

//assign LEDR=LEDR_buf;
//assign LEDG=LEDR_buf;


initial begin
	x_rand  <= 31'b1;
	y_rand <= 31'b1;
	state <= 4'b0;
	write_enable <= 0;
end

Reset_Delay rd(.iCLK(CLOCK_50),.oRESET(DLY_RST));
VGA_Controller vga(
.iCLK(VGA_CTL_CLK),
.iRST_N(RST_N),
.iCursor_RGB_EN(4'b0111),
.oCoord_X(Coord_X),
.oCoord_Y(Coord_Y),
.iRed(mVGA_R),
.iGreen(mVGA_G),
.iBlue(mVGA_B),
.oVGA_R(VGA_R),
.oVGA_G(VGA_G),
.oVGA_B(VGA_B),
.oVGA_H_SYNC(VGA_HS),
.oVGA_V_SYNC(VGA_VS),
.oVGA_SYNC(VGA_SYNC_N),
.oVGA_BLANK(VGA_BLANK_N)
);

vgadll pll(
	~DLY_RST,
	TD_CLK27,
	VGA_CTL_CLK,
	VGA_CLK,
	locked);
to_seven_digit h0(HO0, HEX0);
to_seven_digit h1(HO1, HEX1);
to_seven_digit h2(HO2, HEX2);
to_seven_digit h3(HO3, HEX3);
to_seven_digit h4(HO4, HEX4);

function [9:0] fix_10_bit_length(input [9:0] val);
  fix_10_bit_length = val[9:0];
endfunction


  
generate
  genvar i;
  
  for (i=0; i<480; i=i+1) begin : rndr
		integer in = $realtobits(-2 + i * 0.008333333333333333);
		renderer i_renderer(
			.clock(CLOCK_50), 
			.start_re(32'hC0000000), 
			.start_im(in), 
			.step(0), 
			.vga_clock(0), 
			.vga_in_column(0), 
			//.vga_out(0)
      );
  end
endgenerate

always @(posedge VGA_CTL_CLK) begin

	
end


endmodule
