
`timescale 1ns / 1ns

module counteroffset(
	input resetn, 
	input edge_go,
	input offset_increase,
	input clk,
	
	output reg [5:0] offset);

	always @(posedge clk)
		begin	
			if(!resetn) 
				offset <= 5'd0; 
			else if(edge_go)
				offset <= 5'd0;
			else if(offset_increase)
				offset <= offset + 1'b1;
		end

	 endmodule 