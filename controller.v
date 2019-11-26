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
SRAM_DQ, SRAM_ADDR,SRAM_CE_N,SRAM_UB_N,SRAM_LB_N, SRAM_WE_N,SRAM_OE_N, SW, GPIO, LEDG, HEX0, HEX1, HEX2, HEX3, HEX4
);
input CLOCK_50;
input TD_CLK27;
input [3:0]KEY;
input [17:0]SW;

output [39:0]GPIO;
output [19:0]SRAM_ADDR;
output SRAM_CE_N,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_OE_N;
output [9:0] VGA_R,VGA_G,VGA_B;
output VGA_HS,VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N;
output TD_RESET_N;
output[17:0]LEDR;
output[8:0]LEDG;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;

inout [15:0]SRAM_DQ;

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
reg [8:0] walkercount;

assign TD_RESET_N =1'b1;
assign SRAM_CE_N=1'b0;
assign SRAM_UB_N=1'b0;
assign SRAM_LB_N=1'b0;
assign SRAM_OE_N=write_enable;
assign SRAM_WE_N=~write_enable;
assign SRAM_DQ=(write_enable)?data_reg:16'hzzzz;
assign SRAM_ADDR=addr_reg;
assign mVGA_R={SRAM_DQ[15:12],6'b0};
assign mVGA_G={SRAM_DQ[11:8],6'b0};
assign mVGA_B={SRAM_DQ[7:4],6'b0};
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

always @(posedge VGA_CTL_CLK) begin
	x_rand <= {x_rand[29:0], x_low_bit};
	y_rand <= {y_rand[29:0], y_low_bit};
	
	data_reg<=(write_enable)?data_reg:SRAM_DQ;
	// Key 0 = VGA reset
	
	
	
	if(~KEY[1])begin
	   addr_reg <= {Coord_X[9:0],Coord_Y[9:0]};
		write_enable<=1'b1;
		data_reg<={16'b0};		
		state<=4'd0; //init
	end
	else if(~KEY[2]) begin
		//pause
	end
	else if(~KEY[3]) begin
		write_enable<=1'b0;
		addr_reg <= {Coord_X[9:0],Coord_Y[9:0]};
	end
	else if(state==0) begin
		write_enable<=1'b1;
		addr_reg <= {10'd80,10'd200};
		data_reg<=16'hffff;
		
		
		x_walker<=(x_low_bit)?10'd200:10'd100;//9;
		y_walker<=(y_low_bit)?10'd200:10'd100;//9;
		walkercount<=1;
		
		state<=4'd12;
	end
	else if(state==12)begin
		write_enable<=1'b0;
		if(y_walker>0) addr_reg <= {fix_10_bit_length(x_walker[9:0]-1),y_walker[9:0]};
		else addr_reg <= {fix_10_bit_length(x_walker[9:0]+1),y_walker[9:0]};
	state<=4'd13;
	end
	else if(state==13)begin
	state<=4'd1;
	end
	else if(state==1)begin
		write_enable<=1'b0;
		
		sum <= 0;
		state<=4'd2;
	end
	else if(state==2)begin
		write_enable<=1'b0;
		if(y_walker<639) addr_reg <= {fix_10_bit_length(x_walker[9:0]+1),y_walker[9:0]};
		else addr_reg <= {fix_10_bit_length(x_walker[9:0]-1),y_walker[9:0]};
		sum<=(data_reg==16'hffff);
		
		state<=4'd3;
	end
	else if(state==3)begin
		write_enable<=1'b0;
		if(y_walker>0) addr_reg <= {x_walker[9:0],fix_10_bit_length(y_walker-1)};
		else addr_reg <= {x_walker[9:0],fix_10_bit_length(y_walker+1)};
		sum<=((data_reg==16'hffff)|sum);
		
		state<=4'd4;
	end
	else if(state==4)begin
		write_enable<=1'b0;
		if(y_walker<639) addr_reg <= {x_walker[9:0],fix_10_bit_length(y_walker+1)};
		else addr_reg <= {x_walker[9:0],fix_10_bit_length(y_walker-1)};
		sum<=((data_reg==16'hffff)|sum);
		
		state<=4'd5;
	end
	else if(state==5)begin
		//LEDG_buf[4]<=data_reg==16'hffff;
		if(sum | (data_reg==16'hffff)) begin//draw-state
			write_enable<=1'b1;
			addr_reg<={x_walker[9:0],y_walker[9:0]};
			data_reg<=16'hffff;
			
			state<=4'd10;
		end
		else begin
			write_enable<=1'b0;
			x_walker <= x_walker[9:0] + ((x_low_bit)?1:-1);
			y_walker <= y_walker[9:0] + ((y_low_bit)?1:-1);
			
			state<=4'd6;
		end
	end
	else if(state==6)begin
		write_enable<=1'b0;
		if((x_walker >=640) | (y_walker>=480)) begin
			state<=4'd7;
		end
		else state <=4'd12;
	end
	else if(state==7)begin
		write_enable<=1'b0;
		if (walkercount ==0) begin
			state<=4'd15;
		end
		else begin
			x_walker<=(x_low_bit)?10'd0:10'd639;
			y_walker<=(y_low_bit)?10'd0:10'd479;
			//x_walker <= x_rand;
			//y_walker <= y_rand;
			
			state <=4'd12;
		end
	end
	else if(state==10) begin
		write_enable<=1'b0;
		walkercount<=walkercount+1;
		
		state<=4'd7;
	end
	
	else if(state==15) begin
		addr_reg <= {Coord_X[9:0],Coord_Y[9:0]};
		write_enable<=1'b0;
	end
	
end

endmodule
