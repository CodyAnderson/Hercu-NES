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
  output logic [7:0] vRamDataIn;       //video data bus, used to read from the video RAM/cartridge ROM/RAM.

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
	
  logic [5:0]pixelIndexData; 

  MemoryStuffs mems(vRamRead, vRamAddressOut, vRamDataIn);

  logic [7:0] addrLatchIn;
  SN74LS373N addrLatch(memLatch, 0, addrLatchIn, vRamAddressOut[7:0]);

  NES2C02 The_PPU(clock, reset, rw, dataBusEnable, registerSelect, cpuDataIn, vRamDataIn, cpuDataOut, vRamDataOut, {vRamAddressOut[13:8], addrLatchIn}, memLatch, interrupt, vRamRead, vRamWrite, pixelIndexData);


  

endmodule // NesPpu

module MemoryStuffs(input logic rd, input logic[13:0] address, output logic[7:0] data);
  logic [7:0] ram [4096];
  logic [7:0] rom [8192];

  initial
  begin
    $readmemh("../../../BackgroundMemDump.hex", ram);
    $readmemh("../../../CharacterRom.hex", rom);
  end

  always_comb
  begin
    if(rd)
    begin
      if(address < 14'h2000)
        data = rom[address];
      else
        data = ram[address-14'h2000];
    end
    else
      data = 8'hZZ;
  end
endmodule

module NES2C02(
    /////////////
   // PPU Inputs
  /////////////
  input logic clock,                  // 21.47727 MHz clock input.
  input logic reset,                  // (ACTIVE LOW) Resets certain parts of the chip to their initial power on state.
  input logic rw,                     // read/write signal from the CPU
  input logic dataBusEnable,          //(ACTIVE LOW)enables reading/writing on the CPU data bus.
  input logic [2:0] registerSelect,   //used to address the internal registers on the PPU (connected to address 2-0 on the CPU).
  input logic [7:0] cpuDataIn,        //cpu data bus, used to read data from the CPU.
  input logic [7:0] vRamDataIn,       //video data bus, used to read from the video RAM/cartridge ROM/RAM.

    //////////////
   // PPU Outputs
  //////////////
  output logic [7:0] cpuDataOut,      //cpu data bus, used to write data to the CPU.
  output logic [7:0] vRamDataOut,     //video data bus, used to write to the video RAM/cartridge RAM.
  output logic [13:0] vRamAddressOut, //address for video RAM and cartridge ROM/RAM.
  output logic addressLatch,    //latches new address onto the address lines (needed because the address and data lines are on shared pins in the physical part).
  output logic interrupt,             //(ACTIVE LOW) Interrupts the CPU using the NMI input.
  output logic vRamRead,              //(ACTIVE LOW) Enables the video RAM to output data on the vRAM data bus.
  output logic vRamWrite,             //(ACTIVE LOW) Tells the video RAM to store the data on the vRAM data bus.

  output logic [5:0]pixelOut
  );



  logic [5:0] tileX = 2;
  logic [5:0] tileY;
  logic [2:0] tileRow;
  logic [7:0] tileLowByte;
  logic [7:0] tileHighByte;
  logic [1:0] tileAttribs;
  logic incrementTileX;
  logic memLatch;
  logic halfClock = 0;
  logic [8:0]pixelX = 0;
  logic [8:0]pixelY = 0;
  logic fetchEnable;

  logic [15:0]shiftyHigh;
  logic [15:0]shiftyLow;
  logic [7:0]shiftyAttrHigh;
  logic [7:0]shiftyAttrLow;

  logic pixelEnable;

  always_comb
  begin
    pixelEnable = 0;

    if(pixelX+halfClock > 1 && pixelX+halfClock < 258)
      if(pixelY < 240)
        pixelEnable = 1;
  end

  assign pixelOut = {pixelEnable, 1'b0, shiftyAttrHigh[0], shiftyAttrLow[0], shiftyHigh[0], shiftyLow[0]};

  //assign tileX = pixelX[7:3];
  assign tileY = pixelY[7:3];
  assign tileRow = pixelY[2:0];

always_comb //Decides whether or not the PPU should be fetching data for drawing on the screen
begin
  fetchEnable = 1;
  if(pixelX+halfClock == 0)
    fetchEnable = 0;
  if(pixelX+halfClock > 256 && pixelX+halfClock < 321) //shouldn't be here once sprites are in
    fetchEnable = 0;
  if(pixelX+halfClock > 340)
    fetchEnable = 0;
  if(pixelY > 239 && pixelY < 261)
    fetchEnable = 0;
end

always_ff@(posedge clock)
begin
  
  halfClock <= !halfClock;
  if(halfClock)
  begin
    pixelX <= pixelX + 1;
  end
  else
  begin
    if(fetchEnable)
    begin
      shiftyHigh <= shiftyHigh >> 1;
      shiftyLow <= shiftyLow >> 1;
      shiftyAttrHigh <= {tileAttribs[1],shiftyAttrHigh[7:1]};
      shiftyAttrLow <= {tileAttribs[0],shiftyAttrLow[7:1]};
    end
  end

  if(incrementTileX)
  begin
    tileX <= tileX + 1;
    shiftyHigh[15:8] <= tileHighByte;
    shiftyLow[15:8] <= tileLowByte;
  end

  if(pixelX == 256)
  begin
    if(halfClock == 0)
    begin
      pixelY <= pixelY + 1;
      if(pixelY == 261)
        pixelY <= 0;
    end
    else
      tileX <= 0;
  end
  if(pixelX == 340 && halfClock)
    pixelX <= 0;
end

  TileFetcher fetchfecth(clock, fetchEnable, tileX, tileY, tileRow, vRamDataIn, vRamAddressOut, addressLatch, vRamRead, tileLowByte, tileHighByte, tileAttribs, incrementTileX);
endmodule


module TileFetcher(
	input logic clock,
  input logic enable,
	input logic [5:0] tileX,
	input logic [5:0] tileY,
	input logic [2:0] tileRow,
	input logic [7:0] memData,
	output logic [13:0] memAddress,
	output logic memLatch,
	output logic memRead,
	output logic [7:0] tileLowByte,
	output logic [7:0] tileHighByte,
	output logic [1:0] tileAttribs,
  output logic counterRollover);
	
  logic [7:0] tileLowByteInt;
  logic [1:0] tileAttribsInt;

	logic [3:0]counter = 0;
  assign counterRollover = counter == 4'b1111;
  logic [3:0]counter2;
  assign counter2 = counter + 1;
	logic [7:0]nameTableByte = 0;
	logic [13:0]fetchAddress;
	logic [7:0]fetchData;
	assign tileHighByte = (counter == 4'b1111) ? memData : 8'hZZ;
	MemFetcher Fetch(clock,counter[1:0],fetchAddress,enable, memData,memLatch, memRead, memAddress, fetchData);
	
	always_comb
	begin
		case(counter2[3:2])
				0:fetchAddress = {2'h2,tileY[5], tileX[5], tileY[4:0], tileX[4:0]}; //memory address of nametable
				1:fetchAddress = {2'h2, tileY[5], tileX[5], 4'b1111, tileY[4:2], tileX[4:2]}; //Attribute address					
				2:fetchAddress = {1'b0,1'b1,nameTableByte, 1'b0, tileRow}; 
				3:fetchAddress = {1'b0,1'b1,nameTableByte, 1'b1, tileRow}; 
		endcase
	end
	
	always_ff@(posedge clock)
	begin
    if(enable)
      counter <= counter + 1;
    else
      counter <= 'h0;

		if(counter[1:0] == 0)
		begin
			case(counter[3:2])
				1:nameTableByte <= fetchData;
				2:tileAttribsInt <= fetchData >> {tileY[1],tileX[1],1'b0};
				3:begin
          tileLowByte <= fetchData;
          tileAttribs <= tileAttribsInt;
        end
				0:begin
        end
			endcase
		end
	end
endmodule
		



module MemFetcher(
	input logic clock,
	input logic [1:0] counter,
	input logic [13:0]addressIn,
	input logic enable, 
	input logic [7:0]dataIn, 
	output logic addressLatch, 
	output logic read, 
	output logic [13:0]addressOut,
	output logic [7:0] dataOut);
	
	always_ff@(posedge clock)
	begin
    if(enable)
    begin
  		case(counter)
  		0: begin
    		addressLatch <= 1;
    		addressOut[13:0] <= addressIn[13:0];
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
      end
  		3: begin ///Read in data here!!!!!!
    		dataOut <= dataIn;
    		addressLatch <= 0;
    		read <= 1;
      end
  		endcase
    end
    else
    begin
      addressOut <= 14'bZ;
      addressLatch <= 0;
      read <= 0;
    end
	end
endmodule

module SpriteSelector();

endmodule

module LoopyScrolling();

endmodule