module scoreregister (clock, resetn, increment,HEX0,HEX1,HEX2,HEX3,HEX4, HEX5);

	input clock, resetn, increment;
	
	reg [23:0]Q;
	output [6:0]HEX0, HEX1,HEX2,HEX3,HEX4,HEX5;
	
	hexdisplay h1(.c3(Q[3]), .c2(Q[2]), .c1(Q[1]), .c0(Q[0]), .s(HEX0));
	hexdisplay h2(.c3(Q[7]), .c2(Q[6]), .c1(Q[5]), .c0(Q[4]), .s(HEX1));
	hexdisplay h3(.c3(Q[11]), .c2(Q[10]), .c1(Q[9]), .c0(Q[8]), .s(HEX2));
	hexdisplay h4(.c3(Q[15]), .c2(Q[14]), .c1(Q[13]), .c0(Q[12]), .s(HEX3));
	hexdisplay h5(.c3(Q[19]), .c2(Q[18]), .c1(Q[17]), .c0(Q[16]), .s(HEX4));
	hexdisplay h6(.c3(Q[23]), .c2(Q[22]), .c1(Q[21]), .c0(Q[20]), .s(HEX5));
			
always@ (posedge clock)
	begin 
	if (!resetn) 
	
		Q<= 24'b0;
	else if (increment) 

		Q <= Q + 1'b1;

end

endmodule

module hexdisplay(c3, c2, c1, c0, s);
    input c3, c2, c1, c0; //binary digits
	 output [7:0]s; //hex display segments

//assigning segments of the hex display
    assign s[0] = ((~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&c0));
	 assign s[1] = ((~c3&c2&~c1&c0)|(~c3&c2&c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0));
	 assign s[2] = ((~c3&~c2&c1&~c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0));
	 assign s[3] = ((~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&c1&c0)|(c3&~c2&c1&~c0)|(c3&c2&c1&c0));
	 assign s[4] = ((~c3&~c2&~c1&c0)|(~c3&~c2&c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&~c2&~c1&c0));
	 assign s[5] = ((~c3&~c2&~c1&c0)|(~c3&~c2&c1&~c0)|(~c3&~c2&c1&c0)|(~c3&c2&c1&c0)|(c3&c2&~c1&c0));
	 assign s[6] = ((~c3&~c2&~c1&~c0)|(~c3&~c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&c2&~c1&~c0));

endmodule

