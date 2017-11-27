module scoreregister (clock, resetn, startn, current_state, increment,HEX0,HEX1,HEX2,HEX3,HEX4, HEX5, Q);

	input clock, resetn, startn, increment;
	input [5:0] current_state;
	output reg [23:0]Q;
	reg everyOther;
	output [6:0]HEX0, HEX1,HEX2,HEX3,HEX4,HEX5;
	
	reg [3:0] digit_5, digit_4, digit_3, digit_2, digit_1, digit_0;
	
	always@(*) begin
		digit_0 = Q[3:0];
		digit_1 = Q[7:4];
		digit_2 = Q[11:8];
		digit_3 = Q[15:12];
		digit_4 = Q[19:16];
		digit_5 = Q[23:20];
		
		if (digit_0 > 9) begin
			digit_1 = digit_1 + 1;
			digit_0 = digit_0 - 10;
		end
		if (digit_1 > 9) begin
			digit_2 = digit_2 + 1;
			digit_1 = digit_1 - 10;
		end
		if (digit_2 > 9) begin
			digit_3 = digit_3 + 1;
			digit_2 = digit_2 - 10;
		end
		if (digit_3 > 9) begin
			digit_4 = digit_4 + 1;
			digit_3 = digit_3 - 10;
		end
		if (digit_4 > 9) begin
			digit_5 = digit_5 + 1;
			digit_4 = digit_4 - 10;
		end
		if (digit_5 > 9) begin
			digit_0 = 9;
			digit_1 = 9;
			digit_2 = 9;
			digit_3 = 9;
			digit_4 = 9;
			digit_5 = 9;
		end
	
	end
	
	hexdisplay h1(.c3(digit_0[3]), .c2(digit_0[2]), .c1(digit_0[1]), .c0(digit_0[0]), .s(HEX0));
	hexdisplay h2(.c3(digit_1[3]), .c2(digit_1[2]), .c1(digit_1[1]), .c0(digit_1[0]), .s(HEX1));
	hexdisplay h3(.c3(digit_2[3]), .c2(digit_2[2]), .c1(digit_2[1]), .c0(digit_2[0]), .s(HEX2));
	hexdisplay h4(.c3(digit_3[3]), .c2(digit_3[2]), .c1(digit_3[1]), .c0(digit_3[0]), .s(HEX3));
	hexdisplay h5(.c3(digit_4[3]), .c2(digit_4[2]), .c1(digit_4[1]), .c0(digit_4[0]), .s(HEX4));
	hexdisplay h6(.c3(digit_5[3]), .c2(digit_5[2]), .c1(digit_5[1]), .c0(digit_5[0]), .s(HEX5));
			
always@ (posedge clock)
	begin 
	if (!resetn | (!startn & current_state == 5'd0)) begin
		everyOther <= 1'b0;
		Q <= 24'b000000000000000000000000;
	end
	else if (increment) begin
		if (everyOther) begin
			Q <= Q + 1'b1;
			everyOther <= 1'b0;
		end
		else 
			everyOther <= everyOther + 1'b1;
	end
end

endmodule

module hexdisplay(c3, c2, c1, c0, s);
    input c3, c2, c1, c0; //binary digits
	 output [6:0]s; //hex display segments

//assigning segments of the hex display
    assign s[0] = ((~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&c0));
	 assign s[1] = ((~c3&c2&~c1&c0)|(~c3&c2&c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0));
	 assign s[2] = ((~c3&~c2&c1&~c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0));
	 assign s[3] = ((~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&c1&c0)|(c3&~c2&c1&~c0)|(c3&c2&c1&c0));
	 assign s[4] = ((~c3&~c2&~c1&c0)|(~c3&~c2&c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&~c2&~c1&c0));
	 assign s[5] = ((~c3&~c2&~c1&c0)|(~c3&~c2&c1&~c0)|(~c3&~c2&c1&c0)|(~c3&c2&c1&c0)|(c3&c2&~c1&c0));
	 assign s[6] = ((~c3&~c2&~c1&~c0)|(~c3&~c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&c2&~c1&~c0));

endmodule

