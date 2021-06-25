module hw_mod (clk, reset, invk_hw, short_timeout, 
				long_timeout, car_on_fw, 
				invk_fw, timer_hw_reset);
	input clk;
	input reset;
	input invk_hw;
	input short_timeout;
	input long_timeout;
	input car_on_fw;
	
	output invk_fw;
	output timer_hw_reset;
	
	localparam [1:0] RED = 2'd0;
	localparam [1:0] YELLOW = 2'd1;
	localparam [1:0] GREEN = 2'd2;

	reg [1:0] state_hw;
	
	//initial condition
	initial state_hw = GREEN;
	
	//Mealy machine outputs
	//invoking fw
	assign invk_fw = (state_hw == GREEN) && long_timeout && car_on_fw;
	
	//timer reset signal
	assign timer_hw_reset = invk_fw;
	
	//state transition
	always@(posedge clk) begin
		if(reset) 
			state_hw <= GREEN;
		else begin
			case(state_hw)
				RED: 
					state_hw <= (invk_hw) ? YELLOW : RED;
				YELLOW:
					state_hw <= (short_timeout) ? GREEN : YELLOW;
				GREEN:
					state_hw <= (long_timeout && car_on_fw) ? RED : GREEN;
				default: 
					state_hw <= GREEN;
			endcase
		end
	end
	
endmodule
