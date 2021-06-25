module timer (clk, reset, timer_hw_reset, timer_fw_reset, short_timeout, long_timeout);
	input clk;
	input reset;
	input timer_hw_reset;
	input timer_fw_reset;
	
	output short_timeout;
	output long_timeout;
	
	localparam RESETk = 3'd0;
	localparam T1 = 3'd1;
	localparam T2 = 3'd2;
	localparam T3 = 3'd3;
	localparam T4 = 3'd4;
	localparam T5 = 3'd5;
	localparam T6 = 3'd6;
	localparam T7 = 3'd7;

	reg [2:0] state;
	
	initial state = RESETk;
	
	//Moore machine
	//state
	always@(posedge clk) begin
		case(state) 
			RESETk:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T1;
					
			T1:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T2;
					
			T2:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T3;
					
			T3:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T4;
					
			T4:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T5;
					
			T5:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T6;
					
			T6:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T7;
					
			T7:
				if (reset || timer_hw_reset || timer_fw_reset) 
					state <= RESETk;
				else
					state <= T7;
			default:
				state <= RESETk;
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
