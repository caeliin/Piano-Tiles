module PianoTiles(
		CLOCK_50, 
		KEY,
		SW,
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		HEX5
		,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B 
		
		);
	
	input CLOCK_50;
	input [8:0] KEY;
	input [9:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;

	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]

	wire resetn;	
	wire startn;
	
	assign resetn = SW[0];
	assign startn = KEY[0] | KEY[1] | KEY[2] | KEY[3];
	
	wire reset_screen_done, draw_done, wait_done, 
		reset_screen_go, draw_go, wait_go, edge_go, offset_increase,
		check_input_done,
		correct,
		incorrect,
		correct_done, //use this as the signal to increment things once for correct input
		incorrect_input_done,
		colour_line_done, check_input_go,
		correct_go,
		incorrect_input_go,
		colour_line_go;
	
	wire [5:0] offset;
	
	wire [2:0] line_0, line_1, line_2, line_3, line_4, line_5, line_6;

	//vga adapter inputs
	wire vga_enable;
	wire draw_vga_enable, reset_vga_enable;
	assign vga_enable = draw_vga_enable | reset_vga_enable | colour_line_go | correct_go | incorrect_input_go;
	
	reg [8:0] x;
	wire [8:0] x_draw, x_reset, x_line, x_correct, x_incorrect;
	reg [7:0] y; 
	wire [7:0] y_draw, y_reset, y_line, y_correct, y_incorrect;
	
	reg [2:0] colour;
	wire [2:0] colour_draw, colour_reset;
	
	always @(*) begin
		if (reset_screen_go) begin
			x = x_reset;
			y = y_reset;
			colour = colour_reset;
			end
		else if (draw_go) begin
			x = x_draw;
			y = y_draw;
			colour = colour_draw;
		end
		else if (colour_line_go) begin
			x = x_line;
			y = y_line;
			colour = 3'b100;
		end
		else if (correct_go) begin
			x = x_correct;
			y = y_correct;
			colour = 3'b111;
		end
		else if (incorrect_input_go) begin
			x = x_incorrect;
			y = y_incorrect;
			colour = 3'b100;
		end
		else begin
			x = 1;
			y = 0;
			colour = 3'b111;
		end
	end

	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(vga_enable),
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "background.mif";

wire [5:0] current_state;
wire [23:0] Q;
	
	master_control m0 (
		.clock(CLOCK_50),
		.resetn(resetn),
		.startn(startn),
		.reset_screen_done(reset_screen_done),
		.draw_done(draw_done),
		.wait_done(wait_done),
		.check_input_done(check_input_done),
		.correct(correct),
		.incorrect(incorrect),
		.correct_done(correct_done),
		.incorrect_input_done(incorrect_input_done),
		.colour_line_done(colour_line_done),
		.offset(offset[5:0]), 
		.line_6(line_6[2:0]),
		
		.reset_screen_go(reset_screen_go),
		.draw_go(draw_go),
		.wait_go(wait_go),
		.edge_go(edge_go),
		.offset_increase(offset_increase),
		.check_input_go(check_input_go),
		.correct_go(correct_go),
		.incorrect_input_go(incorrect_input_go),
		.colour_line_go(colour_line_go),
		.current_state(current_state[5:0])
		);
		
	draw_master d0 (
		.clock(CLOCK_50), 
		.resetn(resetn), 
		.startn(startn),
		.draw_go(draw_go),
		.offset(offset[5:0]),
		.line_0(line_0[2:0]),
		.line_1(line_1[2:0]),
		.line_2(line_2[2:0]),
		.line_3(line_3[2:0]),
		.line_4(line_4[2:0]),
		.line_5(line_5[2:0]),
		.line_6(line_6[2:0]),
		.main_state(current_state[5:0]),
		.all_draw_done(draw_done), 
		.vga_enable(draw_vga_enable),
		.x_out(x_draw[8:0]),
		.y_out(y_draw[7:0]),
		.colour_out(colour_draw[2:0])
		);
		
	resetscreen resetface(
		.clock(CLOCK_50), 
		.reset_screen_go(reset_screen_go), 
		.x(x_reset[8:0]), 
		.y(y_reset[7:0]), 
		.colour(colour_reset[2:0]), 
		.vga_enable(reset_vga_enable),
		.resetdone(reset_screen_done)
		);
	
	shiftrow shiftymcshiftface (
		.shift(edge_go), 
		.clk(CLOCK_50), 
		.resetn(resetn),
		.startn(startn),
		.correct_input(correct_done),
		.current_state(current_state[5:0]),
		.line_0(line_0[2:0]),
		.line_1(line_1[2:0]),
		.line_2(line_2[2:0]),
		.line_3(line_3[2:0]),
		.line_4(line_4[2:0]),
		.line_5(line_5[2:0]),
		.line_6(line_6[2:0])
		);
		
	waitcounter waitface(
		.clk(CLOCK_50), 
		.wait_done(wait_done), 
		.wait_go(wait_go)
		);
		
	counteroffset lineface(
		.clk(CLOCK_50),
		.resetn(resetn),
		.startn(startn),
		.current_state(current_state[5:0]),
		.edge_go(edge_go),
		.offset_increase(offset_increase),
		.offset(offset[5:0])
		);
		
	checkInput pressbuttonsright (
		.check_input_go(check_input_go),
		.clock(CLOCK_50),
		.key3(KEY[3]),
		.key2(KEY[2]),
		.key1(KEY[1]), 
		.key0(KEY[0]),
		.line_6(line_6[2:0]),
		.check_input_done(check_input_done),
		.correct(correct),
		.incorrect(incorrect)
	);
	
	wrongKeyFail umadbro(
		.clock(CLOCK_50),
		.resetn(resetn),
		.startn(startn),
		.incorrect_input_go(incorrect_input_go),
		.key3(KEY[3]),
		.key2(KEY[2]),
		.key1(KEY[1]), 
		.key0(KEY[0]),
		.offset(offset[5:0]),
		.incorrect_input_done(incorrect_input_done),
		.x(x_incorrect[8:0]),
		.y(y_incorrect[7:0])
	);
	
	correctInput nicelydone(
		.clock(CLOCK_50),
		.correct_go(correct_go),
		.resetn(resetn),
		.startn(startn),
		.current_state(current_state[5:0]),
		.line_6(line_6[2:0]),
		.offset(offset[5:0]),
		.correct_done(correct_done),
		.x(x_correct[8:0]),
		.y(y_correct[7:0])
	);
	
	colourLine misslikeaduck(
		.clock(CLOCK_50),
		.colour_line_go(colour_line_go),
		.line_6(line_6[2:0]),
		.colour_line_done(colour_line_done),
		.x(x_line[8:0]),
		.y(y_line[7:0])
	);
	
	scoreregister score(
		.clock(CLOCK_50), 
		.resetn(resetn), 
		.startn(startn),
		.current_state(current_state),
		.increment(correct_done),
		.HEX0(HEX0[6:0]),
		.HEX1(HEX1[6:0]),
		.HEX2(HEX2[6:0]),
		.HEX3(HEX3[6:0]),
		.HEX4(HEX4[6:0]), 
		.HEX5(HEX5[6:0]),
		.Q(Q[23:0])
	);
	
endmodule
