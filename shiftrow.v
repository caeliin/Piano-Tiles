
`timescale 1ns / 1ns

module shiftrow(
	input shift, 
	input clk, 
	input resetn,
	input correct_input,
	
	output reg	[2:0] line_0,	
	output reg  [2:0] line_1,
	output reg  [2:0] line_2,
	output reg  [2:0] line_3,
	output reg  [2:0] line_4,
	output reg  [2:0] line_5,
	output reg	[2:0] line_6
);

	reg [4:0] d;
	
	always @(posedge clk) begin
		 if (d == 5'b00000)
			d <= 5'b000001;
		 else 
			d <= { d[3:0], d[4] ^ d[3] };
	end

	always @ (posedge clk)
	begin	
		if(!resetn) begin
			line_0<=3'b000;    	
			line_1<=3'b000;
			line_2<=3'b000;
			line_3<=3'b000;
			line_4<=3'b000;
			line_5<=3'b000;
			line_6<=3'b000;
			end
		else if (correct_input)
			line_6<=3'b000;
		else if(shift) begin
			line_0<= d[1:0] + 1'b1;    	
			line_1<=line_0;
			line_2<=line_1;
			line_3<=line_2;
			line_4<=line_3;
			line_5<=line_4;
			line_6<=line_5;
		end
	end

endmodule
