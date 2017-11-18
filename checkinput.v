module checkInput(
	input check_input_go,
		key3, key2, key1, key0,
		[2:0] line_6,
	output check_input_done,
		correct,
		incorrect
	);
	
	always @(posedge clock) 
	begin		
		if (!check_input_go) begin
			correct <= 1'b0;
			incorrect <= 1'b0;
			check_input_done <= 1'b0;
		end
		else begin
			case (line_6)
				3'b000: begin
					correct <= 1'b0;
					incorrect <= 1'b0;
					check_input_done <= 1'b1;
				end
				3'b001: begin
					if (key3 == 1'b0) begin
						correct <= 1'b1;
						incorrect <= 1'b0;
						check_input_done <= 1'b1;
						end
					else if (key2 == 1'b0 | key1 == 1'b0 | key0 == 1'b0) begin
						correct <= 1'b0;
						incorrect <= 1'b1;
						check_input_done <= 1'b1;
					end
				end
				3'b010: begin
					if (key2 == 1'b0) begin
						correct <= 1'b1;
						incorrect <= 1'b0;
						check_input_done <= 1'b1;
						end
					else if (key3 == 1'b0 | key1 == 1'b0 | key0 == 1'b0) begin
						correct <= 1'b0;
						incorrect <= 1'b1;
						check_input_done <= 1'b1;
					end
				end
				3'b011: begin
					if (key1 == 1'b0) begin
						correct <= 1'b1;
						incorrect <= 1'b0;
						check_input_done <= 1'b1;
						end
					else if (key2 == 1'b0 | key3 == 1'b0 | key0 == 1'b0) begin
						correct <= 1'b0;
						incorrect <= 1'b1;
						check_input_done <= 1'b1;
					end
				end
				3'b100: begin
					if (key0 == 1'b0) begin
						correct <= 1'b1;
						incorrect <= 1'b0;
						check_input_done <= 1'b1;
						end
					else if (key2 == 1'b0 | key1 == 1'b0 | key3 == 1'b0) begin
						correct <= 1'b0;
						incorrect <= 1'b1;
						check_input_done <= 1'b1;
					end
				end
				default: begin
					check_input_done <= 1'b0;
					correct <= 1'b0;
					incorrect <= 1'b0;
				end
			endcase
		end
	end
	
endmodule
