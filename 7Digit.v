module to_seven_digit (input [6:0]number, output reg [6:0]HEX_OUT);
//Used to represent the input register number on the given output
//Currently only correctly represents numbers up to base 16
always @(number)
begin
   case (number)
      7'd0: HEX_OUT= 7'b1000000;
      7'd1: HEX_OUT= 7'b1111001;
      7'd2: HEX_OUT= 7'b0100100;
      7'd3: HEX_OUT= 7'b0110000;
      7'd4: HEX_OUT= 7'b0011001;
      7'd5: HEX_OUT= 7'b0010010;
      7'd6: HEX_OUT= 7'b0000010;
      7'd7: HEX_OUT= 7'b1111000;
      7'd8: HEX_OUT= 7'b0000000;
      7'd9: HEX_OUT= 7'b0010000;
      7'd10:HEX_OUT= 7'b0001000;
      7'd11:HEX_OUT= 7'b0000011;
      7'd12:HEX_OUT= 7'b1000110;
      7'd13:HEX_OUT= 7'b0100001;
      7'd14:HEX_OUT= 7'b0000110;
      7'd15:HEX_OUT= 7'b0001110;
      default: HEX_OUT= 7'b0110110;
   endcase
	
end

endmodule
