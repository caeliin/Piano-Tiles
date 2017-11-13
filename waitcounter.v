`timescale 1ns / 1ns

module waitcounter(enable, clk);
	input clk;
	output enable;
	wire clear;
	
	reg [22:0]count;
	
	assign enable=clear;
	assign clear=(count==23'd5000000)?1'b1:1'b0; //when counter hits 5m -- will give 10 enables a second
		
	always @(posedge clk)
		begin	
			if(clear) 
				count<=23'd0; 
			else 
				count <= count + 1'b1;
		end
endmodule

