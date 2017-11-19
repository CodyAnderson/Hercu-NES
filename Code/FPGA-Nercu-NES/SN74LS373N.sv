module SN74LS373N(
            input latchEnable,   // enables latching of data
            //PIN11
						input outputEnable,  //(ACTIVE LOW) enables output data signals
            //PIN1
						input[7:0] dataIn, 	 // data input
            //PINS 3,4,7,8,13,14,17,18
						output[7:0] dataOut	 // data output
            //PINS 2,5,6,9,12,15,16,19
						);
	
  reg[7:0] data = 0;
always_latch
begin
	if(latchEnable)
    data = dataIn;
  
end

assign dataOut = outputEnable ? 'hZZ : data;
    
endmodule