'define RED 2'd0
'define GREEN 2'd1
'define YELLOW 2'd2

module hw_mod (clk, invk_hw, short_timeout, 
				long_timeout, car_on_fw, 
				invk_fw, timer_hw_reset);
	input clk;
	input invk_hw;
	input short_timeout;
	input long_timeout;
	input car_on_fw;
	
	output timer_hw_reset;
	
	reg [1:0] state_hw;
	wire invk_fw;
	
	//initial condition
	initial state_hw = GREEN;
	
	//Mealy machine outputs
	//invoking fw
	assign invk_fw = (state_hw == GREEN) && long_timeout) && cars_on_fw;
	
	//timer reset signal
	assign timer_hw_reset = invk_fw;
	
	//state transition
	always@(posedge clk) begin
		case(state_hw)
			RED: 
				state_hw = (invk_hw) ? YELLOW : RED;
			YELLOW:
				state_hw = (short_timeout) ? GREEN : YELLOW;
			GREEN:
				state_hw = (long_timeout && cars_on_fw) ? RED : GREEN;
		endcase
	end
	
endmodule
