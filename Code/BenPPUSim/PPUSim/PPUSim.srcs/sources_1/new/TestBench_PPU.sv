`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2017 03:19:53 PM
// Design Name: 
// Module Name: TestBench_PPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TestBench_PPU();

  logic clock = 1;


    /////////////
   // PPU Inputs
  /////////////                 // 21.47727 MHz clock input.
  logic reset;                  // (ACTIVE LOW) Resets certain parts of the chip to their initial power on state.
  logic rw;                     // read/write signal from the CPU
  logic dataBusEnable;          //(ACTIVE LOW)enables reading/writing on the CPU data bus.
  logic [2:0] registerSelect;   //used to address the internal registers on the PPU (connected to address 2-0 on the CPU).
  logic [7:0] cpuDataIn;        //cpu data bus, used to read data from the CPU.
  logic [7:0] vRamDataIn;       //video data bus, used to read from the video RAM/cartridge ROM/RAM.

    //////////////
   // PPU Outputs
  //////////////
  logic [7:0] cpuDataOut;      //cpu data bus, used to write data to the CPU.
  logic [7:0] vRamDataOut;     //video data bus, used to write to the video RAM/cartridge RAM.
  logic [13:0] vRamAddressOut; //address for video RAM and cartridge ROM/RAM.
  logic addressLatchEnable;    //latches new address onto the address lines (needed because the address and data lines are on shared pins in the physical part).
  logic interrupt;             //(ACTIVE LOW) Interrupts the CPU using the NMI input.
  logic vRamRead;              //(ACTIVE LOW) Enables the video RAM to output data on the vRAM data bus.
  logic vRamWrite;             //(ACTIVE LOW) Tells the video RAM to store the data on the vRAM data bus.

    //////////////////////////////////////////////////////////////
   // VGA Output addition (merely a guess at what will be needed)
  //////////////////////////////////////////////////////////////
  logic vgaClock;     // Clock for video signal
  logic [7:0] red;   // Red channel output
  logic [7:0] green; // Green channel output
  logic [7:0] blue;  // Blue channel output
  logic hsync;       // Horizontal Sync
  logic vsync;       // Vertical Sync

  always #5 clock = !clock;


  NesPpu PPU(clock, vgaClock, red, green, blue, hsync, vsync, reset, rw, dataBusEnable, registerSelect, cpuDataIn, cpuDataOut, vRamDataIn, vRamDataOut, vRamAddressOut, addressLatchEnable, interrupt, vRamRead, vRamWrite);




endmodule


/*module TestBench_PPU();

  logic [15:0] memAddress;
  logic [7:0] addrLatchIn;
  logic [7:0] memData;
  logic [5:0] tileX = 2;
  logic [5:0] tileY;
  logic [2:0] tileRow;
  logic [7:0] tileLowByte;
  logic [7:0] tileHighByte;
  logic [1:0] tileAttribs;
  logic incrementTileX;
  logic memLatch;
  logic memRead;
  logic clock = 1;
  logic halfClock = 0;
  logic [8:0]pixelX = 0;
  logic [8:0]pixelY = 0;
  logic fetchEnable;

  logic [15:0]shiftyHigh;
  logic [15:0]shiftyLow;
  logic [7:0]shiftyAttrHigh;
  logic [7:0]shiftyAttrLow;



  //assign tileX = pixelX[7:3];
  assign tileY = pixelY[7:3];
  assign tileRow = pixelY[2:0];

always #5 clock = !clock;

always_comb
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

  MemoryStuffs mems(memRead, memAddress, memData);

  SN74LS373N addrLatch(memLatch, 0, addrLatchIn, memAddress[7:0]);

  TileFetcher fetchfecth(clock, fetchEnable, tileX, tileY, tileRow, memData, {memAddress[15:8], addrLatchIn}, memLatch, memRead, tileLowByte, tileHighByte, tileAttribs, incrementTileX);


endmodule*/



