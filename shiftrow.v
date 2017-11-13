
`timescale 1ns / 1ns

module shiftrow(
	input shift, 
	input clk, 
	input resetn, 
	
	output reg	[1:0] line_0,	
	output reg  [1:0] line_1,
	output reg  [1:0] line_2,
	output reg  [1:0] line_3,
	output reg  [1:0] line_4,
	output reg  [1:0] line_5,
	output reg	[1:0] line_6
)
localparam 

always@(posedge clk)
begin	
	if(!resetn)
	//do nothing
	else
	if(shift)
	begin
		line_0<=random;     	
		line_1<=line0;
		line_2<=line1;
		line_3<=line2;
		line_4<=line3;
		line_5<=line4;
		line_6<=line5;
	end

end
