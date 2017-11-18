module correctInput(
	input clock,
		correct_go,
	input [2:0] line_6,
	input [5:0] offset,
	output correct_done, //use this as the signal to clear line 6 of the register
	output [8:0] x,
	output [7:0] y
	);
	
	colourBlock drawmeawhitesquare (
		.clock(clock),
		.colour_block_go(correct_input_go),
		.line_id(line_6[2:0]),
		.offset(offset[5:0]),
		.colour_block_done(correct_input_done),
		.x(x[8:0]),
		.y(y[7:0])
		);
	
endmodule
