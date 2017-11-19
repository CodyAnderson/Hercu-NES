module DataMultiplexer(
			input cpuRW, //whether cpu is reading or writing (low is writing).
			input ppuEnable, 
			input controller1Enable, 
			input controller2Enable, 
			input sramEnable, 
			input cartridgeEnable, 
			input[7:0] cpuData, 
			input[7:0] ppuData, 
			input[7:0] controller1Data, 
			input[7:0] controller2Data, 
			input[7:0] sramData, 
			input[7:0] cartridgeData, 
			output[7:0] dataOutput
			);
			
	always_comb
	begin
		if(cpuRW == 0)
			dataOutput = cpuData;
		else if(ppuEnable == 0)
			dataOutput = ppuData;
		else if(controller1Enable == 0)
			dataOutput = controller1Data;
		else if(controller2Enable == 0)
			dataOutput = controller2Data;
		else if(sramEnable == 0)
			dataOutput = sramData;
		else if(cartridgeEnable == 0)
			dataOutput = cartridgeData;
		else
			dataOutput = 'hZZ;
  end

endmodule // DataMultiplexer
