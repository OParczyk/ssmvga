module renderer(clock, start_re, start_im, step, vga_clock, vga_in_column, vga_out);
	input clock;
	input [31:0] start_re, start_im, step;
	input [7:0] vga_in_column;
	input vga_clock;
	output [7:0] vga_out;
	
	reg [31:0]curr_im;
	reg [31:0]curr_re;
	reg [7:0] curr_x;	
	reg write_mem = 0;
	reg mem_val = 0;	
	
	reg [7:0] iteration_count;
	reg[20:0] state;
	reg[20:0] substate;
	
	ram mem(
		address_a(curr_x),
		address_b(vga_in_column),
		clock_a(clock),
		clock_b(vga_clock),
		data_a(mem_val),
		data_b(0),
		wren_a(write_mem),
		wren_b(0),
		q_a(mem_val),
		q_b(rendered_value)
	);
		
	parameter 
		init=4'd0,
		mult=4'd1,
		add=4'd2,
		bounds_check=4'd3,
		calc_new_pos=4'd4
	;	
	
	always @(posedge clock) begin
		case(state)
			init: begin
				iteration_count <= 0;
				
			end
			mult: begin
			
			end
			add: begin
			
			end
			bounds_check: begin
			
			end
			calc_new_pos: begin
			
			end
		endcase
	end
endmodule
