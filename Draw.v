module draw_control (
	input clock,
		resetn,
		draw_go,
//I regret everything.
	input [5:0] draw_done, //one for each draw/erase machine
		erase_done,
		draw_colour,
		erase_colour,
	input [8:0] draw_0_x, //max 320 9'b101000000
		draw_1_x,
		draw_2_x,
		draw_3_x,
		draw_4_x,
		draw_5_x,
		erase_0_x,
		erase_1_x,
		erase_2_x,
		erase_3_x,
		erase_4_x,
		erase_5_x,
	input [7:0] draw_0_y, //max 240 8'b11110000
		draw_1_y,
		draw_2_y,
		draw_3_y,
		draw_4_y,
		draw_5_y,
		erase_0_y,
		erase_1_y,
		erase_2_y,
		erase_3_y,
		erase_4_y,
		erase_5_y,	
		
	output reg all_drawing_done,
		vga_enable,
	output reg [5:0] draw_enable, //one for each draw/erase machine
		erase_enable,
	output reg [8:0] x_out,
	output reg [7:0] y_out,
	output reg [2:0] colour_out,
	output reg [4:0] current_state
	);
	
	reg [4:0] next_state;
	
	localparam	WAIT		= 4'd0,
					ERASE_0	= 4'd2,
					DRAW_0	= 4'd3,
					ERASE_1	= 4'd4,
					DRAW_1	= 4'd5,
					ERASE_2	= 4'd6,
					DRAW_2	= 4'd7,
					ERASE_3	= 4'd8,
					DRAW_3	= 4'd9,
					ERASE_4	= 4'd10,
					DRAW_4	= 4'd11,
					ERASE_5	= 4'd12,
					DRAW_5	= 4'd13,
					DONE		= 4'd14;
	
	initial current_state = WAIT;
	
	always@(*)
	begin: state_table
			case (current_state)
				WAIT		: next_state = draw_go ? ERASE_0 : WAIT;
				ERASE_0	: next_state = erase_done[0] ? DRAW_0 : ERASE_0;
				DRAW_0	: next_state = draw_done[0] ? ERASE_1 : DRAW_0;
				ERASE_1	: next_state = erase_done[1] ? DRAW_1 : ERASE_1;
				DRAW_1	: next_state = draw_done[1] ? ERASE_2 : DRAW_1;
				ERASE_2	: next_state = erase_done[2] ? DRAW_2 : ERASE_2;
				DRAW_2	: next_state = draw_done[2] ? ERASE_3 : DRAW_2;
				ERASE_3	: next_state = erase_done[3] ? DRAW_3 : ERASE_3;
				DRAW_3	: next_state = draw_done[3] ? ERASE_4 : DRAW_3;
				ERASE_4	: next_state = erase_done[4] ? DRAW_4 : ERASE_4;
				DRAW_4	: next_state = draw_done[4] ? ERASE_5 : DRAW_4;
				ERASE_5	: next_state = erase_done[5] ? DRAW_5 : ERASE_5;
				DRAW_5	: next_state = draw_done[5] ? DONE : DRAW_5;
				DONE		: next_state = draw_go ? DONE : WAIT;
				default: next_state = WAIT;
			endcase
	end //state_table

	always @(*)
	begin: enable_signals
		all_drawing_done = 1'b0;
		vga_enable = 1'b0;
		draw_enable = 6'b000000;
		erase_enable = 6'b000000;
		
		case (current_state)
			//WAIT		: 
			ERASE_0	: begin
				erase_enable[0] = 1'b1;
				x_out = erase_0_x;
				y_out = erase_0_y;
				colour_out = {erase_colour[0], erase_colour[0], erase_colour[0]};
				vga_enable = 1'b1;
				end
			DRAW_0	: begin
				draw_enable[0] = 1'b1;
				x_out = draw_0_x;
				y_out = draw_0_y;
				colour_out = {draw_colour[0], draw_colour[0], draw_colour[0]};
				vga_enable = 1'b1;
				end
			ERASE_1	: begin
				erase_enable[1] = 1'b1;
				x_out = erase_1_x;
				y_out = erase_1_y;
				colour_out = {erase_colour[1], erase_colour[1], erase_colour[1]};
				vga_enable = 1'b1;
				end
			DRAW_1	: begin
				draw_enable[1] = 1'b1;
				x_out = draw_1_x;
				y_out = draw_1_y;
				colour_out = {draw_colour[1], draw_colour[1], draw_colour[1]};
				vga_enable = 1'b1;
				end
			ERASE_2	: begin
				erase_enable[2] = 1'b1;
				x_out = erase_2_x;
				y_out = erase_2_y;
				colour_out = {erase_colour[2], erase_colour[2], erase_colour[2]};
				vga_enable = 1'b1;
				end
			DRAW_2	: begin
				draw_enable[2] = 1'b1;
				x_out = draw_2_x;
				y_out = draw_2_y;
				colour_out = {draw_colour[2], draw_colour[2], draw_colour[2]};
				vga_enable = 1'b1;
				end
			ERASE_3	: begin
				erase_enable[3] = 1'b1;
				x_out = erase_3_x;
				y_out = erase_3_y;
				colour_out = {erase_colour[3], erase_colour[3], erase_colour[3]};
				vga_enable = 1'b1;
				end
			DRAW_3	: begin
				draw_enable[3] = 1'b1;
				x_out = draw_3_x;
				y_out = draw_3_y;
				colour_out = {draw_colour[3], draw_colour[3], draw_colour[3]};
				vga_enable = 1'b1;
				end
			ERASE_4	: begin
				erase_enable[4] = 1'b1;
				x_out = erase_4_x;
				y_out = erase_4_y;
				colour_out = {erase_colour[4], erase_colour[4], erase_colour[4]};
				vga_enable = 1'b1;
				end
			DRAW_4	: begin
				draw_enable[4] = 1'b1;
				x_out = draw_4_x;
				y_out = draw_4_y;
				colour_out = {draw_colour[4], draw_colour[4], draw_colour[4]};
				vga_enable = 1'b1;
				end
			ERASE_5	: begin
				erase_enable[5] = 1'b1;
				x_out = erase_5_x;
				y_out = erase_5_y;
				colour_out = {erase_colour[5], erase_colour[5], erase_colour[5]};
				vga_enable = 1'b1;
				end
			DRAW_5	: begin
				draw_enable[5] = 1'b1;
				x_out = draw_5_x;
				y_out = draw_5_y;
				colour_out = {draw_colour[5], draw_colour[5], draw_colour[5]};
				vga_enable = 1'b1;
				end
			DONE		: begin
				all_drawing_done = 1'b1;
				x_out = 9'b0;
				y_out = 8'b0;
				colour_out = 3'b111;
				end
			default: begin
				x_out = 9'b0;
				y_out = 8'b0;
				colour_out = 3'b111;
				end
		endcase
	end //enable_signals
	
	always @(posedge clock)
	begin: state_FFs
		if (!resetn)
			current_state <= WAIT;
		else
			current_state <= next_state;
	end //state_FFs
endmodule

module draw (
	input clock,
		draw_enable,
	input [3:0] line_id,
	input [2:0] line_above,
	input [5:0] offset,

	output reg [8:0] x,
	output reg [7:0] y,
	output reg colour,
		draw_done
	);
	
	reg [7:0] line_id_offset;
	
	localparam 	black = 1'b0,
					white = 1'b1;
	
	always @(*)
		line_id_offset = line_id * 40;
		
	always @(*)
		y = line_id_offset + offset;
		
	always@(posedge clock)
	begin
		if (!draw_enable)
			//set up in preparation for signal
			case (line_above)
				3'b000: begin
					x <= 140; 
					draw_done <= 1'b0;
					colour <= white;
				end
				3'b001: begin
					x <= 120;
					draw_done <= 1'b0;
					colour <= black;
				end
				3'b010: begin
					x <= 140;
					draw_done <= 1'b0;
					colour <= black;
				end
				3'b011: begin
					x <= 160;
					draw_done <= 1'b0;
					colour <= black;
				end
				3'b100: begin
					x <= 180;
					draw_done <= 1'b0;
					colour <= black;
				end
				default: begin
					x <= 140;
					draw_done <= 1'b0;
					colour <= white;
				end
			endcase
		else 
			//start incrementing
			case (line_above)
				3'b000: //do nothing
					draw_done <= 1'b1;
				3'b001: begin
					if (x == 139)
						draw_done <= 1'b1;
					else
						x = x + 1;
				end
				3'b010: begin
					if (x == 159)
						draw_done <= 1'b1;
					else
						x = x + 1;
				end
				3'b011: begin
					if (x == 179)
						draw_done <= 1'b1;
					else
						x = x + 1;
				end
				3'b100: begin
					if (x == 199)
						draw_done <= 1'b1;
					else
						x = x + 1;
				end
				default:
					draw_done <= 1'b1;
			endcase
	end //always block
	
endmodule

module erase (
	input clock,
		erase_enable,
	input [3:0] line_id,
	input [2:0] line_below,
	input [5:0] offset,

	output reg [8:0] x,
	output reg [7:0] y,
	output colour,
	output reg erase_done
	);
	
	reg [7:0] line_id_offset;
	
	assign colour = 1'b1; //always draw white
	
	always @(*)
		line_id_offset = line_id * 40;
		
	always @(*)
		y = line_id_offset + offset;
		
	always@(posedge clock)
	begin
		if (!erase_enable)
			//set up in preparation for signal
			case (line_below)
				3'b000: begin
					x <= 140; 
					erase_done <= 1'b0;
				end
				3'b001: begin
					x <= 120;
					erase_done <= 1'b0;
				end
				3'b010: begin
					x <= 140;
					erase_done <= 1'b0;
				end
				3'b011: begin
					x <= 160;
					erase_done <= 1'b0;
				end
				3'b100: begin
					x <= 180;
					erase_done <= 1'b0;
				end
				default: begin
					x <= 140;
					erase_done <= 1'b0;
				end
			endcase
		else 
			//start incrementing
			case (line_below)
				3'b000: //do nothing
					erase_done <= 1'b1;
				3'b001: begin
					if (x == 139)
						erase_done <= 1'b1;
					else
						x = x + 1;
				end
				3'b010: begin
					if (x == 159)
						erase_done <= 1'b1;
					else
						x = x + 1;
				end
				3'b011: begin
					if (x == 179)
						erase_done <= 1'b1;
					else
						x = x + 1;
				end
				3'b100: begin
					if (x == 199)
						erase_done <= 1'b1;
					else
						x = x + 1;
				end
				default:
					erase_done <= 1'b1;
			endcase
	end //always block
	
endmodule
		
		