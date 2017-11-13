
`timescale 1ns / 1ns

module resetscreen (
	input clock, 
	input resetn, 
	
	output reg x, y, colour, 
	output reg resetdone
)

	

    localparam MAX_X = 9'd199; 
    localparam MAX_Y = 7'd239;
	 localparam initial_x= 9'd120;
	 localparam initial_y = 7'd0;
	 localparam initial_c = 3'b111;//set initial colour to white 
	 
	 always@(posedge clk) begin 
		if(!resetn) begin 
			x <= initial_x; 
			y <= initial_y;
			colour <= initial_c;
			resetdone = 1'b0;	
			
			if (x==MAX_X) 
				begin 
					x <=initial_x;
					resetdone=1'b1;
					
				if(y==MAX_y)
					y <= initial_y;
				else
					y <= y + 1'b1;
				end
			else
				x <= x + 1'b1;	
			end
		end
endmodule
