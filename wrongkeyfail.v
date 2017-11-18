module wrongKeyFail( //this is actually a really pointless module but I'm too lazy to rewrite colourblock
	input clock,
		incorrect_input_go,
		key3, key2, key1, key0,
	input [5:0] offset,
	output incorrect_input_done,
	output [8:0] x,
	output [7:0] y
	);
	
	reg [2:0] input_line_id;
	
	always @(*) 
	begin
		if (key3 == 1'b0)
			input_line_id = 3'b001;
		else if (key2 == 1'b0)
			input_line_id = 3'b010;
		else if (key1 == 1'b0)
			input_line_id = 3'b011;
		else if (key0 == 1'b0)
			input_line_id = 3'b100;
		else 
			input_line_id = 3'b000;
	end
	
	colourBlock drawmeaprettysquare (
		.clock(clock),
		.colour_block_go(incorrect_input_go),
		.line_id(input_line_id[2:0]),
		.offset(offset[5:0]),
		.colour_block_done(incorrect_input_done),
		.x(x[8:0]),
		.y(y[7:0])
		);
	
endmodule
