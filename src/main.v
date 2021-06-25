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
	timer timer_ins1 (clk, reset, timer_hw_reset, 
					timer_fw_reset, 
					short_timeout, long_timeout);
					
	hw_mod hw_mod_ins1 (clk, reset, invk_hw, short_timeout,
						long_timeout, car_on_fw,
						invk_fw, timer_hw_reset);
						
	fw_mod fw_mod_ins1 (clk, reset, invk_fw, short_timeout,
						long_timeout, car_on_fw,
						invk_hw, timer_fw_reset);
	
	
	//sensor data modelling
	initial begin
		car_on_fw = 1'b0;
	end
	
	always@(posedge clk) begin
		car_on_fw <= ($random%3 > 0) ? 1'b1 : 1'b0; 
	end
	
	//waveform dumping
	initial begin
    		$dumpfile("test.vcd");
			$dumpvars;
    		#5000;
    		$finish;
	 end			
	
endmodule
