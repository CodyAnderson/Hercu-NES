module NesPpu (clock, vgaClock, red, green, blue, hsync, vsync, reset, rw, dataBusEnable, registerSelect, cpuDataIn, cpuDataOut, vRamDataIn, vRamDataOut, vRamAddressOut, addressLatchEnable, interrupt, vRamRead, vRamWrite);
    /////////////
   // PPU Inputs
  /////////////
  input logic clock;                  // 21.47727 MHz clock input.
  input logic reset;                  // (ACTIVE LOW) Resets certain parts of the chip to their initial power on state.
  input logic rw;                     // read/write signal from the CPU
  input logic dataBusEnable;          //(ACTIVE LOW)enables reading/writing on the CPU data bus.
  input logic [2:0] registerSelect;   //used to address the internal registers on the PPU (connected to address 2-0 on the CPU).
  input logic [7:0] cpuDataIn;        //cpu data bus, used to read data from the CPU.
  input logic [7:0] vRamDataIn;       //video data bus, used to read from the video RAM/cartridge ROM/RAM.

    //////////////
   // PPU Outputs
  //////////////
  output logic [7:0] cpuDataOut;      //cpu data bus, used to write data to the CPU.
  output logic [7:0] vRamDataOut;     //video data bus, used to write to the video RAM/cartridge RAM.
  output logic [13:0] vRamAddressOut; //address for video RAM and cartridge ROM/RAM.
  output logic addressLatchEnable;    //latches new address onto the address lines (needed because the address and data lines are on shared pins in the physical part).
  output logic interrupt;             //(ACTIVE LOW) Interrupts the CPU using the NMI input.
  output logic vRamRead;              //(ACTIVE LOW) Enables the video RAM to output data on the vRAM data bus.
  output logic vRamWrite;             //(ACTIVE LOW) Tells the video RAM to store the data on the vRAM data bus.

    //////////////////////////////////////////////////////////////
   // VGA Output addition (merely a guess at what will be needed)
  //////////////////////////////////////////////////////////////
  input logic vgaClock;     // Clock for video signal
  output logic [7:0] red;   // Red channel output
  output logic [7:0] green; // Green channel output
  output logic [7:0] blue;  // Blue channel output
  output logic hsync;       // Horizontal Sync
  output logic vsync;       // Vertical Sync


    ////////////
	 // Variables
  ////////////
	
	logic [7:0] ppuControlOne;
  logic [7:0] ppuControlTwo;
  logic [7:0] ppuStatusRegister;
  logic [7:0] oamAddress;
  logic [7:0] oamData;
  logic [15:0] fineScroll;
  logic [15:0] ppuAddress;
  logic [7:0] ppuData;


  

endmodule // NesPpu


module TileFetcher(
	input logic clock,
	input logic [5:0] tileX,
	input logic [5:0] tileY,
	input logic [2:0] tileRow,
	input logic [7:0] memData,
	output logic [15:0] memAddress,
	output logic memLatch,
	output logic memRead,
	output logic [7:0] tileLowByte,
	output logic [7:0] tileHighByte,
	output logic [1:0] tileAttribs);
	
	logic [3:0]counter = 0;
	logic [7:0]nameTableByte = 0;
	logic [15:0]fetchAddress;
	logic [7:0]fetchData;
	
	MemFetcher Fetch(clock,counter[1:0],fetchAddress,1, memData,memLatch, memRead, memAddress, fetchData);
	
	always_comb
	begin
		case(counter[3:2])
				0:fetchAddress = {4'b0010,tileY[5], tileX[5], tileY[4:0], tileX[4:0]}; //memory address of nametable
				1:fetchAddress = {4'h2, tileY[5], tileX[5], 4'b11, tileY[4:2] + tileX[4:2]}; //Attribute address					
				2:fetchAddress = {1'b0,1'b1,nameTableByte, 1'b0, tileRow}; 
				3:fetchAddress = {1'b0,1'b1,nameTableByte, 1'b1, tileRow}; 
		endcase
	end
	
	always_ff@(posedge clk)
	begin
		if(counter[1:0] == 0)
		begin
			case(counter[3:2])
				0:nameTableByte <= fetchData;
				1:tileAttribs <= fetchData[{tileY[1],tileX[1]}+1:{tileY[1],tileX[1]}];
				2:tileLowByte <= fetchData;
				3:tileHighByte <= fetchData;
			endcase
		end
			
		



module MemFetcher(
	input logic clock,
	input logic [1:0] counter,
	input logic [15:0]addressIn,
	input logic enable, 
	input logic [7:0]dataIn, 
	output logic addressLatch, 
	output logic read, 
	output logic [15:0]addressOut,
	output logic [7:0] dataOut);
	
	always_ff@(posedge clock)
	begin
		case(counter)
		0: begin
		addressLatch <= 1;
		addressOut[7:0] <= addressIn[7:0];
		read <= 0;
		end
		1: begin
		addressLatch <= 0;
		read <= 0;
		end
		2: begin
		addressLatch <= 0;
		addressOut[7:0] <= 8'bZ;
		read <= 1;
		3: begin ///Read in data here!!!!!!
		dataOut <= dataIn;
		addressLatch <= 0;
		read <= 1;
		endcase
	end
endmodule

module SpriteSelector();

endmodule

module LoopyScrolling();

endmodule