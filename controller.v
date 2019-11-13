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
SRAM_DQ, SRAM_ADDR,SRAM_CE_N,SRAM_UB_N,SRAM_LB_N, SRAM_WE_N,SRAM_OE_N, SW
);
input CLOCK_50;
input TD_CLK27;
input [3:0]KEY;
output [19:0]SRAM_ADDR;
output [9:0] VGA_R,VGA_G,VGA_B;
output TD_RESET_N;
output VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N,SRAM_CE_N,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_OE_N;
output[17:0]LEDR,SW;
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
wire [9:0] mVGA_R,mVGA_G,mVGA_B;

reg[19:0]addr_reg;
reg[15:0]data_reg;
reg we;
assign SRAM_WE_N=we;

reg [3:0] state;
//reg [7:0] led;
reg [30:0] x_rand;
reg [30:0] y_rand;

wire x_low_bit, y_low_bit;
wire DLY_RST;
wire RST_N = DLY_RST&KEY[0];

reg [8:0] x_walker,y_walker;
reg [3:0] sum;
reg lock;

wire[9:0]Coord_X,Coord_Y;


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
.oVGA_BLANK(VGA_BLANK_N),
//.oVGA_CLOCK(VGA_CLK)
);
vgadll pll(
	~DLY_RST,
	TD_CLK27,
	VGA_CTL_CLK,
	VGA_CLK,
	locked);

assign SRAM_ADDR=addr_reg;
assign LEDR=SRAM_DQ;

assign SRAM_DQ=(we)?16'hzzzz:data_reg;
//assign SRAM_WE_N=we;
assign mVGA_R={SRAM_DQ[15:12],6'b0};

assign mVGA_G={SRAM_DQ[11:8],6'b0};
assign mVGA_B={SRAM_DQ[7:4],6'b0};
assign x_low_bit=x_rand[22]^x_rand[30];
assign y_low_bit=y_rand[26]^y_rand[28];

always @(posedge VGA_CTL_CLK) begin
	x_rand <= x_rand << 1 & x_low_bit;
	y_rand <= y_rand << 1 & y_low_bit;
	// Key 0 = VGA reset

	if(~KEY[1])begin
	   addr_reg <= {Coord_X[9:1],Coord_Y[9:1]};
		we=1'b0;
		data_reg<=16'h0;
		x_rand<=31'b1;
		y_rand<=29'b1;
		x_walker<=9'd155;
		y_walker<=9'd120;
		state<=0; //init
	end

	else if(state==0) begin
		addr_reg <= {8'd128,8'd128};
		data_reg<=16'hffff;
		we=1'b0;
		state<=1;
	end
	else if(state==1) begin
		addr_reg <= {Coord_X[9:1],Coord_Y[9:1]};
		we=1'b1;
	end
end

//assign LEDR[1]=led;


endmodule
