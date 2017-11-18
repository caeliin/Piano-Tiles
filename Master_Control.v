module master_control (
	input clock,
		resetn,
		reset_screen_done,
		draw_done,
		wait_done,
		check_input_done,
		correct,
		incorrect,
		correct_done,
		incorrect_input_done,
		colour_line_done,
		input [5:0] offset, 
		input [2:0] line_6,
	output reg reset_screen_go,
		draw_go,
		wait_go,
		edge_go,
		offset_increase,
		check_input_go,
		correct_go,
		incorrect_input_go,
		colour_line_go,
output reg [5:0] current_state
		);
		
	reg [5:0] next_state;
	
	localparam 	WAIT_FOR_RESET = 5'd0,
					RESET_SCREEN	= 5'd1,
						CHECK_INPUT		= 5'd7,
						CORRECT_INPUT	= 5'd8,
						INCORRECT_INPUT= 5'd9,
					DETECT_EDGE		= 5'd2,
					EDGE_STUFF		= 5'd3,
						EDGE_FAIL		= 5'd10,
					DRAW_ENABLE		= 5'd4,
					WAIT_FOR_NEXT	= 5'd5,
					NEXT_ROW			= 5'd6;
	
	initial current_state = WAIT_FOR_RESET;
	
	always @(*)
	begin: state_table
			case (current_state)
				WAIT_FOR_RESET : next_state = resetn ? WAIT_FOR_RESET : RESET_SCREEN;
				RESET_SCREEN	: next_state = reset_screen_done ? CHECK_INPUT : RESET_SCREEN;
				CHECK_INPUT		: begin
								if (check_input_done & correct)
									next_state = CORRECT_INPUT;
								else if (check_input_done & incorrect)
									next_state = INCORRECT_INPUT;
								else
									next_state = CHECK_INPUT;
								end
				CORRECT_INPUT	: next_state = correct_done ? DETECT_EDGE : CORRECT_INPUT;
				INCORRECT_INPUT: next_state = incorrect_input_done ? WAIT_FOR_RESET : INCORRECT_INPUT;
				DETECT_EDGE		: next_state = (offset == 40) ? EDGE_STUFF : DRAW_ENABLE;
				EDGE_STUFF		: next_state = (line_6 == 3'b000) ? DRAW_ENABLE : EDGE_FAIL;
				EDGE_FAIL		: next_state = colour_line_done ? WAIT_FOR_RESET : EDGE_FAIL;
				DRAW_ENABLE		: next_state = draw_done ? WAIT_FOR_NEXT : DRAW_ENABLE;
				WAIT_FOR_NEXT	: next_state = wait_done ? NEXT_ROW : WAIT_FOR_NEXT;
				NEXT_ROW			: next_state = DETECT_EDGE;
			default: next_state = WAIT_FOR_RESET;
		endcase
	end //state_table
	
	always @(*)
	begin: enable_signals
		reset_screen_go = 1'b0;
		draw_go = 1'b0;
		wait_go = 1'b0;
		edge_go = 1'b0;
		offset_increase = 1'b0;
		check_input_go = 1'b0;
		correct_go = 1'b0;
		incorrect_input_go = 1'b0;
		colour_line_go = 1'b0;
		
		case (current_state)
			//WAIT_FOR_RESET :
			RESET_SCREEN	: reset_screen_go = 1'b1;
			CHECK_INPUT		: check_input_go = 1'b1;
			CORRECT_INPUT	: correct_go = 1'b1;
			INCORRECT_INPUT: incorrect_input_go = 1'b1;
			//DETECT_EDGE		: 
			EDGE_STUFF		: edge_go = 1'b1;
			EDGE_FAIL		: colour_line_go = 1'b1;
			DRAW_ENABLE		: draw_go = 1'b1;
			WAIT_FOR_NEXT	: wait_go = 1'b1;
			NEXT_ROW			: offset_increase = 1'b1;
			default: reset_screen_go = 1'b0; //just to make quartus stop screaming at me
		endcase
	end //enable_signals
		
	always @(posedge clock)
	begin: state_FFs
		if (!resetn)
			current_state <= RESET_SCREEN;
		else
			current_state <= next_state;
	end //state FFs
endmodule
