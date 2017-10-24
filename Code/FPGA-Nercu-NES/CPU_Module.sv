module NesCpu(clock, reset, irq, nmi, dataIn, addressOut, dataOut, rw, oe, out, aux1, aux2);
	
	/////////////
	// CPU Inputs
	/////////////
	input logic clock;              //21.47727MHz clock input, this needs to be divided by 12
	input logic reset;              //(ACTIVE LOW) resets the cpu, reset vector address is 0xFFFC
	input logic irq;                //(ACTIVE LOW) Interrupt pin.
	input logic nmi;                //(ACTIVE LOW) NonMaskable Interrupt pin, connected to interrupt pin on PPU
	input logic [7:0] dataIn;       //CPU data input NOTE: on NES this is combined with dataOut
	
	//////////////
	// CPU Outputs
	//////////////
	output logic [15:0] addressOut; //Used for addressing ROM, RAM, PPU, and ALU(audio)
	output logic [7:0] dataOut;     // CPU data output NOTE: data in and out are same pins on NES
	output logic rw;                //Read/Write of the CPU, read is HIGH, write is LOW.
	output logic [1:0] oe;          //(ACTIVE LOW) output enable for the two controllers.
	output logic [2:0] out;         //output pins for the controllers
	output logic [7:0] aux1;        //audio output channel 1 (size may not be ideal)
	output logic [7:0] aux2;        //audio output channel 2 (size may not be ideal)
	
	logic dataLoad;
	logic [7:0] data;
	logic [7:0] stage;
	logic [7:0] instruction;
	
	always_ff @(posedge clock) 
		begin
			dataLoad = dataLoad + 1;
	
			if(dataLoad) 
				begin
					data <= dataIn;
					if(stage == 0)
						begin
							instruction <= dataIn;
						end
				end	
		
			else 
				begin
					case(instruction)
						//NOP
						8'hEA	:
							begin
								
							end
							
						//DEFAULT	
						default :
							begin
								
							end
				end
		
		end
endmodule