`timescale 1ns / 1ns

module waitcounter(clk, wait_done, wait_go);
	input clk, wait_go;
	output reg wait_done;
	
	reg [22:0]count;

	always @(posedge clk) begin
		if(!wait_go) begin
			count <= 23'd0;
			wait_done <= 1'b0;
			end
		else begin
			if(count == 23'd500000)
				wait_done <= 1'b1;
			else 
				count <= count + 1'b1;
		end
	end
endmodule

