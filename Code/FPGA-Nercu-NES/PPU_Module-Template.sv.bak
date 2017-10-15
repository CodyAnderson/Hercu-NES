module NesPpu (clock, vgaClock, reset, rw, dataBusEnable, registerSelect, cpuDataIn, cpuDataOut, vRamDataIn, vRamDataOut, vRamAddressOut, addressLatchEnable, interrupt, vRamRead, vRamWrite);
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

endmodule // NesPpu