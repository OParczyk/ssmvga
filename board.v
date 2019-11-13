module board(
	//LEDR,TD_CLK27,CLOCK_50, VGA_R, VGA_G, VGA_B,VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_VS, VGA_SYNC_N, TD_RESET_N, KEY
);
/*input CLOCK_50;
input TD_CLK27;
input [3:0]KEY;
output [9:0] VGA_R,VGA_G,VGA_B;
output TD_RESET_N;
output VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_VS, VGA_SYNC_N;
output[17:0]LEDR;

reg led;
wire c1,c0;
wire locked;
assign TD_RESET_N=1'b1;
//Reset_Delay rd(.iclk(CLOCK_50),.oReset(DLY_RST));
//VGA_Controller();
vgadll pll(
	~KEY[3],
	TD_CLK27,
	c0,
	c1,
	locked);
reg[25:0] count;

/*always @(posedge c1) begin

count = count+1;
if(count==26'd25175000) begin
led=~led;
count=0;
end
end
assign LEDR[1]=~KEY[2];
assign LEDR[0]=led;


always @(posedge VGA_CTL_CLK) begin
if(reset) begin
addr_reg <= {Coord_X[9:1],Coord_Y[9:1]};
we=1'b0;
data_reg<=16'b0;
x_rand<=31'b1;
y_rand<=29'b1;
x_walker<=9'd155;
y_walker<=9'd120;
//state<=init;

reg [25:0]count;
always @(posedge VGA_CLK) begin

count = count+1;
if(count==26'd25175000) begin
led=~led;
count=0;
end
end
*/


endmodule
