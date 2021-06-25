module main ;
	
	//important
	reg clk;
	reg reset;
	reg car_on_fw;
	
	wire timer_hw_reset;
	wire timer_fw_reset;
	wire invk_hw;
	wire invk_fw;
	wire short_timeout;
	wire long_timeout;
	
	//clock 
	initial clk = 1'b0;
	
	always #10 clk = ~clk;
	
	//reset
	initial begin 	
		reset = 1'b1;
		@(posedge clk) reset = 1'b0;
	end
	
	//module instantiations
	timer_ins1 timer (clk, timer_hw_reset, 
					timer_fw_reset, reset, 
					short_timeout, long_timeout);
					
	hw_mod_ins1 hw_mod (clk, invk_hw, short_timeout,
						long_timeout, car_on_fw,
						invk_fw, timer_hw_reset);
						
	fw_mod_ins1 fw_mod (clk, invk_fw, short_timeout,
						long_timeout, car_on_fw,
						invk_hw, timer_fw_reset);
	
	
	//sensor data modelling
	initial begin
		car_on_fw = 1'b0;
	end
	
	always@(posedge clk) begin
		car_on_fw = ($random()%3 > 0) ? 1b'1 : 1'b0; 
	end
	
endmodule
