
`timescale 1ns / 1ns

module counteroffset(
	input resetn, 
	input edge_go,
	input offset_increase,
	input clk,
	
	output reg offset[5:0]);

		 
	always @(posedge clk)
		begin	
			if(!resetn) 
				offset <=5'd0; 
			if(edge_go)
				offset <=5'd0;
			if(offset=5'd39)
				offset <= 5'd0;
			if(offset_increase)
				offset <= offset + 1'b1;
		end

	 endmodule 