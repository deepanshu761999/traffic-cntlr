'define RESET 3'd0
'define T1 3'd1
'define T2 3'd2
'define T3 3'd3
'define T4 3'd4
'define T5 3'd5
'define T6 3'd6
'define T7 3'd7


module timer (clk, timer_hw_reset, timer_fw_reset, reset, short_timeout, long_timeout);
	input clk;
	input timer_hw_reset;
	input timer_fw_reset;
	input reset;
	
	output short_timeout;
	output long_timeout;
	
	reg [2:0] state;
	
	initial state = RESET;
	
	//Moore machine
	//state
	always@(posedge clk) begin
		case(state) 
			RESET:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T1;
					
			T1:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T2;
					
			T2:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T3;
					
			T3:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T4;
					
			T4:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T5;
					
			T5:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T6;
					
			T6:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T7;
					
			T7:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state = RESET;
				else
					state = T7;
					
		endcase
	end
	
	//output of moore machine
	assign short_timeout = (state == T3) ||
							(state == T4) ||
							(state == T5) ||
							(state == T6) ||
							(state == T7);
							
	assign long_timeout = (state == T7);
	
endmodule
