`timescale 1ns / 1ns

module waitcounter(clk, wait_done, wait_go, Q);
	input clk, wait_go;
	input [23:0] Q;
	output reg wait_done;
	
	reg [22:0] count;
	
	reg [20:0] level;
	
	always @(*) begin
		if (Q[23:3] < 20)
			level [20:0] = Q[23:3];
		else 
			level = 21'd10;
	end

	always @(posedge clk) begin
		if(!wait_go) begin
			count <= level * 20000;
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

