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

  
  /*struct{
	logic N;
	logic Z;
	logic C;
	logic I;
	logic D;
	logic V;
	} SR = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};*/
  
	logic [1:0] stage = 0;
	//Execution stage
		//Stages:
			//0 : load next instruction
			//1 : load last data
			//2 : load 2nd to last data
	logic [7:0] instruction = 0;
	
	logic [7:0] instructionData = 0;
  
	//Registers
	logic [15:0] PC = 0;//	....	program counter	(16 bit)
	logic [7:0]  AC;//	....	accumulator	(8 bit)
	logic [7:0]  X;//	....	X register	(8 bit)
	logic [7:0]  Y;//	....	Y register	(8 bit)
	logic [7:0] SR;//	....	status register [NV-BDIZC]	(8 bit)
	logic [7:0] SP;//	....	stack pointer	(8 bit)
  
	//Flags
	logic N;
	logic Z = 0;
	logic C;
	logic I;
	logic D;
	logic V;

	assign addressOut = PC;
  
	always_ff@(posedge clock)
	begin
		if(stage == 0)
		begin
			instruction <= dataIn;
			if(dataIn == 240) //BEQ
			begin
				if(Z == 0)
				begin
					stage <= 2;
					PC <= PC + 1;
				end
				else
				begin
					stage <= 0;
					PC <= PC + 3;
				end
			end
			else
			begin
				stage <= 0;
				PC <= 0;
			end
		end
		
		else
		begin
			if(instruction == 240) //BEQ
			begin
				if(stage == 2)
				begin
					instructionData <= dataIn;
					PC <= PC + 1;
					stage <= 1;
				end
				else if(stage == 1)
				begin
					PC <= {dataIn,instructionData};
					stage <= 0;
				end
			end
			else
			begin
				PC <= 3;
			end
		end
	end
endmodule // NesCpu