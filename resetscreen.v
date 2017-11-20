
`timescale 1ns / 1ns

module resetscreen (
	input clock, 
	input reset_screen_go, 
	
	output reg [8:0] x, 
	output reg [7:0] y, 
	output reg [2:0] colour, 
	output reg vga_enable,
		resetdone
);

    localparam MAX_X = 9'd199; 
    localparam MAX_Y = 8'd239;
	localparam initial_x = 9'd120;
	localparam initial_y = 8'd0;
	localparam initial_c = 3'b111;//set initial colour to white 
	reg counterenable;
	
	always @(posedge clock) begin
	if (!reset_screen_go) begin
		x = initial_x - 1'b1; 
		y = initial_y;
		colour = initial_c;
		resetdone = 1'b0;
		vga_enable = 1'b0;
		end
	else begin
		vga_enable = 1'b1;
		if (x == MAX_X) begin 
			if(y == MAX_Y)
				resetdone = 1'b1;					
			else
				x = initial_x;
				y = y + 1'b1;
			end
		else
			x = x + 1'b1;	
		end
	end
endmodule
