module colourBlock(
	input clock,
		colour_block_go,
	input [2:0] line_id,
	input [5:0] offset,
	output colour_block_done,
	output [8:0] x,
	output [7:0] y
	);
	
	reg [8:0] start_x, end_x;
	reg [7:0] start_y;
	
	always @(*) 
	begin
		start_y = 200 + offset;
		case (line_id)
			3'b001: begin
				start_x = 120;
				end_x = 139;
			end
			3'b010: begin
				start_x = 140;
				end_x = 159;
			end
			3'b011: begin
				start_x = 160;
				end_x = 179;
			end
			3'b100: begin
				start_x = 180;
				end_x = 199;
			end
			default: begin
				start_x = 140;
				end_x = 159;
			end
		endcase
	end
					
	always @(posedge clock)
	begin
		if (!colour_block_go) begin
			colour_block_done <= 1'b0;
			y <= start_y;
			x <= start_x;
		end
		else begin
			if (x == end_x) begin
				if (y == 239)
					colour_block_done <= 1'b1;
				else begin
					x <= start_x;
					y <= y + 1'b1;	
				end
			end
			else begin
				x <= x + 1'b1;
			end
		end
	end
	
endmodule

module colourLine(
	input clock,
		colour_line_go,
	input [2:0] line_6,
	output colour_line_done,
	output [8:0] x,
	output [7:0] y
	);
	
	reg [5:0] line_done;
	reg [8:0] start_x, end_x;
	
	always @(*) 
	begin
		case (line_6)
			3'b001: begin
				start_x = 120;
				end_x = 139;
			end
			3'b010: begin
				start_x = 140;
				end_x = 159;
			end
			3'b011: begin
				start_x = 160;
				end_x = 179;
			end
			3'b100: begin
				start_x = 180;
				end_x = 199;
			end
			default: begin
				start_x = 140;
				end_x = 159;
			end
		endcase
	end
		
	always @(posedge clock)
	begin
		if (!colour_line_go) begin
			colour_line_done <= 1'b0;
			x <= start_x;
			y <= 0;
		end
		else begin
			if (x == end_x) begin
				if (y == 239)
					colour_line_done <= 1'b1;
				else begin
					x <= start_x;
					y <= y + 1'b1;	
				end
			end
			else begin
				x <= x + 1'b1;
			end
		end		
	end
	
endmodule
	