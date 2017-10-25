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
	
	//Just some house-keeping stuff for us
	logic dataLoad;
	logic [7:0] data;
	logic [7:0] stage;
	logic [7:0] instruction;
	
	//Internal registers of import
	logic [15:0] programCounterPC;
	logic [7:0] accumulatorAC;
	logic [7:0] Xregister;
	logic [7:0] Yregister;
	logic [7:0] statusRegisterSR;
	logic [7:0] stackPointerSP;
	
	//Status register flags
	logic negativeN;
	logic overflowV;
	logic ignored;
	logic breakB;
	logic decimalD;
	logic interruptI;
	logic zeroZ = 1;
	logic carryC;
	
	always_ff @(posedge clock) 
		begin
			//Update the dataLoad flag
			dataLoad <= dataLoad + 1;
			// ?
			addressOut <= programCounterPC;
			//If we're in the data load part
			if(dataLoad) 
				begin
					//Update the Program Counter
					programCounterPC <= programCounterPC + 1;
					//Let's read in the data we got
					data <= dataIn;
					if(stage == 0)
						begin
							//And maybe it's the instruction
							instruction <= dataIn;
							
							//Accumulator flag updates
							negativeN <= accumulatorAC[7];
							if(accumulatorAC == 0)
								begin
									zeroZ <= 1;
								end
							else
								begin
									zeroZ <= 0;
								end
						end
				end	
			//If we're in the do stuff part, let's get on it
			else 
				begin
					case(instruction)
						//BRK
						8'h00	:
							begin
								
							end
							
						//AND
						8'h29 :
							begin
								if(stage == 0)
									begin
										stage <= 1;
									end
								else if(stage == 1)
									begin
										accumulatorAC <= accumulatorAC & data;
										stage <= 0;
									end
							end
						//LDA
						8'hA9 :
							begin
								if(stage == 0)
									begin
										stage <= 1;
									end
								else if(stage == 1)
									begin
										accumulatorAC <= data;
									end
							end
						//NOP
						8'hEA	:
							begin
								
							end
						//BEQ
						8'hF0 :
							begin
								if(stage == 0)
									begin
										//Kick it
										stage <= 1;
									end
								else if(stage == 1)
									begin
										//if(zeroZ == 1)
											//begin
												programCounterPC[7:0] <= programCounterPC[7:0] + data;
											//end
										stage <= 0;
									end
							end
							
						//DEFAULT	
						default :
							begin
								
							end
				endcase
			end
		end
endmodule