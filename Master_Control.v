module master_control (
	input clock,
		resetn,
		reset_screen_done,
		draw_done,
		wait_done,
		input [5:0] offset, 
	output reg reset_screen_go,
		draw_go,
		wait_go,
		edge_go,
		offset_increase,
output reg [4:0] current_state
		);
		
	reg [4:0] next_state;
	
	localparam 	WAIT_FOR_RESET = 4'd0,
					RESET_SCREEN	= 4'd1,
					DETECT_EDGE		= 4'd2,
					EDGE_STUFF		= 4'd3,
					DRAW_ENABLE		= 4'd4,
					WAIT_FOR_NEXT	= 4'd5,
					NEXT_ROW			= 4'd6;
	
	initial current_state = WAIT_FOR_RESET;
	
	always @(*)
	begin: state_table
			case (current_state)
				WAIT_FOR_RESET : next_state = resetn ? WAIT_FOR_RESET : RESET_SCREEN;
				RESET_SCREEN	: next_state = reset_screen_done ? DETECT_EDGE : RESET_SCREEN;
				DETECT_EDGE		: next_state = (offset == 40) ? EDGE_STUFF : DRAW_ENABLE;
				EDGE_STUFF		: next_state = DRAW_ENABLE;
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
		
		case (current_state)
			//WAIT_FOR_RESET :
			RESET_SCREEN	: reset_screen_go = 1'b1;
			//DETECT_EDGE		: 
			EDGE_STUFF		: edge_go = 1'b1;
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
