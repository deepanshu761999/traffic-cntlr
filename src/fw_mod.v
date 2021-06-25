module fw_mod (clk, reset, invk_fw, short_timeout, 
				long_timeout, car_on_fw, 
				invk_hw, timer_fw_reset);
	input clk;
	input reset;
	input invk_fw;
	input short_timeout;
	input long_timeout;
	input car_on_fw;
	
	output invk_hw;
	output timer_fw_reset;
	
	localparam [1:0] RED = 2'd0;
	localparam [1:0] YELLOW = 2'd1;
	localparam [1:0] GREEN = 2'd2;
	
	reg [1:0] state_fw;
	
	//initial condition
	initial state_fw = RED;
	
	//Mealy machine outputs
	//invoking fw
	assign invk_hw = ((state_fw == GREEN) && (~long_timeout) && (~car_on_fw)) || 
					((state_fw == GREEN ) && (long_timeout));
	
	//timer reset signal
	assign timer_fw_reset = invk_hw || 
							((state_fw == GREEN) && (~long_timeout) && (~car_on_fw)) ||
							((state_fw == GREEN) && (long_timeout)) ||
							((state_fw == YELLOW) && short_timeout);
	
	//state transition
	always@(posedge clk) begin
		if(reset)
			state_fw <= RED;
		else begin
			case(state_fw)
				RED: 
					state_fw <= (invk_fw) ? GREEN : RED;
				YELLOW:
					state_fw <= (short_timeout) ? RED : YELLOW;
				GREEN:
					state_fw <= ((~long_timeout) && (~car_on_fw) || 
								long_timeout) ? YELLOW : GREEN;
				default: 
					state_fw <= RED;
			endcase
		end
	end
	
endmodule
