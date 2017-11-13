module draw_fsm (
	input clock, 
		resetn, 
		draw_go,
	input [5:0] offset,
	input [2:0] line_0,
		line_1,
		line_2,
		line_3,
		line_4,
		line_5,
		line_6,
	output all_draw_done, vga_enable
	output [8:0] x_out,
	output [7:0] y_out,
	output [2:0] colour_out
	);
	
	wire [5:0] draw_done,
		erase_done,
		draw_colour,
		erase_colour,
		draw_enable,
		erase_enable;
	
	wire [8:0] draw_0_x, //max 320 9'b101000000
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
		erase_5_x;
		
	wire [7:0] draw_0_y, //max 240 8'b11110000
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
		erase_5_y;
		
	
		
	
	module draw_control c0(
		.clock(clock),
		.resetn(resetn),
		.draw_go(draw_go),
		.draw_done(draw_done[5:0]),
		.erase_done(erase_done[5:0]),
		.draw_colour(draw_colour[5:0]),
		.erase_colour(erase_colour[5:0]),
		.draw_0_x(draw_0_x[8:0]), //max 320 9'b101000000
		.draw_1_x(draw_1_x[8:0]),
		.draw_2_x(draw_2_x[8:0]),
		.draw_3_x(draw_3_x[8:0]),
		.draw_4_x(draw_4_x[8:0]),
		.draw_5_x(draw_5_x[8:0]),
		.erase_0_x(erase_0_x[8:0]),
		.erase_1_x(erase_1_x[8:0]),
		.erase_2_x(erase_2_x[8:0]),
		.erase_3_x(erase_3_x[8:0]),
		.erase_4_x(erase_4_x[8:0]),
		.erase_5_x(erase_5_x[8:0]),
		.draw_0_y(draw_0_y[7:0]), //max 240 8'b11110000
		.draw_1_y(draw_1_y[7:0]),
		.draw_2_y(draw_2_y[7:0]),
		.draw_3_y(draw_3_y[7:0]),
		.draw_4_y(draw_4_y[7:0]),
		.draw_5_y(draw_5_y[7:0]),
		.erase_0_y(erase_0_y[7:0]),
		.erase_1_y(erase_1_y[7:0]),
		.erase_2_y(erase_2_y[7:0]),
		.erase_3_y(erase_3_y[7:0]),
		.erase_4_y(erase_4_y[7:0]),
		.erase_5_y(erase_5_y[7:0]),	
		
		.all_drawing_done(all_draw_done),
		.vga_enable(vga_enable),
		.draw_enable(draw_enable[5:0]), //one for each draw/erase machine
		.erase_enable(erase_enable[5:0]),
		.x_out(x_out[8:0]),
		.y_out(y_out[7:0]),
		.colour_out(colour_out[2:0])
	);
	
	draw draw0 (
		.clock(clock),
		.draw_enable(draw_enable[0]),
		.line_id(4'b0000),
		.line_above(line_0[2:0]),
		.offset(offset[5:0]),

		.x(draw_0_x[8:0]),
		.y(draw_0_y[7:0]),
		.colour(draw_colour[0]),
		.draw_done(draw_done[0])
	);
	
	draw draw1 (
		.clock(clock),
		.draw_enable(draw_enable[1]),
		.line_id(4'b0001),
		.line_above(line_1[2:0]),
		.offset(offset[5:0]),

		.x(draw_1_x[8:0]),
		.y(draw_1_y[7:0]),
		.colour(draw_colour[1]),
		.draw_done(draw_done[1])
	);
	
	draw draw2 (
		.clock(clock),
		.draw_enable(draw_enable[2]),
		.line_id(4'b0010),
		.line_above(line_2[2:0]),
		.offset(offset[5:0]),

		.x(draw_2_x[8:0]),
		.y(draw_2_y[7:0]),
		.colour(draw_colour[2]),
		.draw_done(draw_done[2])
	);
	
	draw draw3 (
		.clock(clock),
		.draw_enable(draw_enable[3]),
		.line_id(4'b0011),
		.line_above(line_3[2:0]),
		.offset(offset[5:0]),

		.x(draw_3_x[8:0]),
		.y(draw_3_y[7:0]),
		.colour(draw_colour[3]),
		.draw_done(draw_done[3])
	);
	
	draw draw4 (
		.clock(clock),
		.draw_enable(draw_enable[4]),
		.line_id(4'b0100),
		.line_above(line_4[2:0]),
		.offset(offset[5:0]),

		.x(draw_4_x[8:0]),
		.y(draw_4_y[7:0]),
		.colour(draw_colour[4]),
		.draw_done(draw_done[4])
	);
	
	draw draw5 (
		.clock(clock),
		.draw_enable(draw_enable[5]),
		.line_id(4'b0101),
		.line_above(line_5[2:0]),
		.offset(offset[5:0]),

		.x(draw_5_x[8:0]),
		.y(draw_5_y[7:0]),
		.colour(draw_colour[5]),
		.draw_done(draw_done[5])
	);
	
	erase erase0 (
		.clock(clock),
		.erase_enable(erase_enable[0]),
		.line_id(4'b0000),
		.line_below(line1[2:0]),
		.offset(offset[5:0]),

		.x(erase_0_x[8:0]),
		.y(erase_0_y[7:0]),
		.colour(erase_colour[0]),
		.erase_done(erase_done[0])
	);
	
	erase erase1 (
		.clock(clock),
		.erase_enable(erase_enable[1]),
		.line_id(4'b0001),
		.line_below(line2[2:0]),
		.offset(offset[5:0]),

		.x(erase_1_x[8:0]),
		.y(erase_1_y[7:0]),
		.colour(erase_colour[1]),
		.erase_done(erase_done[1])
	);
	erase erase2 (
		.clock(clock),
		.erase_enable(erase_enable[2]),
		.line_id(4'b0010),
		.line_below(line3[2:0]),
		.offset(offset[5:0]),

		.x(erase_2_x[8:0]),
		.y(erase_2_y[7:0]),
		.colour(erase_colour[2]),
		.erase_done(erase_done[2])
	);
	erase erase3 (
		.clock(clock),
		.erase_enable(erase_enable[3]),
		.line_id(4'b0011),
		.line_below(line4[2:0]),
		.offset(offset[5:0]),

		.x(erase_3_x[8:0]),
		.y(erase_3_y[7:0]),
		.colour(erase_colour[3]),
		.erase_done(erase_done[3])
	);
	erase erase4 (
		.clock(clock),
		.erase_enable(erase_enable[4]),
		.line_id(4'b0100),
		.line_below(line5[2:0]),
		.offset(offset[5:0]),

		.x(erase_4_x[8:0]),
		.y(erase_4_y[7:0]),
		.colour(erase_colour[4]),
		.erase_done(erase_done[4])
	);
	erase erase5 (
		.clock(clock),
		.erase_enable(erase_enable[5]),
		.line_id(4'b0101),
		.line_below(line6[2:0]),
		.offset(offset[5:0]),

		.x(erase_5_x[8:0]),
		.y(erase_5_y[7:0]),
		.colour(erase_colour[5]),
		.erase_done(erase_done[5])
	);
	
	always @(*) begin
		if (draw_enable[0])
			colour_out = {draw_colour[0], draw_colour[0], draw_colour[0]};
		else if (draw_enable[1])
			colour_out = {draw_colour[1], draw_colour[1], draw_colour[1]};
		else if (draw_enable[2])
			colour_out = {draw_colour[2], draw_colour[2], draw_colour[2]};
		else if (draw_enable[3])
			colour_out = {draw_colour[3], draw_colour[3], draw_colour[3]};
		else if (draw_enable[4])
			colour_out = {draw_colour[4], draw_colour[4], draw_colour[4]};
		else if (draw_enable[5])
			colour_out = {draw_colour[5], draw_colour[5], draw_colour[5]};
		else if (erase_enable[0])
			colour_out = {erase_colour[0], erase_colour[0], erase_colour[0]};
		else if (erase_enable[1])
			colour_out = {erase_colour[1], erase_colour[1], erase_colour[1]};
		else if (erase_enable[2])
			colour_out = {erase_colour[2], erase_colour[2], erase_colour[2]};
		else if (erase_enable[3])
			colour_out = {erase_colour[3], erase_colour[3], erase_colour[3]};
		else if (erase_enable[4])
			colour_out = {erase_colour[4], erase_colour[4], erase_colour[4]};
		else if (erase_enable[5])
			colour_out = {erase_colour[5], erase_colour[5], erase_colour[5]};
		else 
			colour_out = 3'b111;
	end
	
	
endmodule
