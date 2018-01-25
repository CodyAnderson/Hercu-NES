`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2018 04:15:47 PM
// Design Name: 
// Module Name: PPU-Commute
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


module PPUCommute(
  input logic clock,
  input logic [2:0]cpuAddr,
  input logic [7:0]cpuDataIn,
  output logic [7:0]cpuDataOut,
  input logic ppuCS,
  input logic cpuRW,

  output logic ppuRD,
  output logic ppuWR,
  output logic ppuALE,
  output logic [13:0]ppuAddr,
  input logic [7:0]ppuDatIn,
  output logic [7:0]ppuDatOut


    );

  logic [7:0] controlRegisters[8];
  typedef PPUCTRL controlRegisters[0];
  typedef PPUMASK controlRegisters[1];
  typedef PPUSTATUS controlRegisters[2];
  typedef OAMADDR controlRegisters[3];
  typedef OAMDATA controlRegisters[4];
  typedef PPUSCROLL controlRegisters[5];
  typedef PPUADDR controlRegisters[6];
  typedef PPUDATA controlRegisters[7];

  logic [15:0]ppuMemAddress = 0;
  logic ppuMemAddrToggle = 0;
  logic [15:0]XYScrolling = 0;
  logic XYToggle = 0;

  logic [7:0]cpuDataBuffer;
  logic [2:0]cpuAddrBuffer;
  logic bufferedIn = 0;
  always_comb
  begin
    if(!ppuCS & cpuRW) // if cpu is reading data from the ppu
    begin
      case(cpuAddr)
        5: begin
          if(XYToggle)
            cpuDataOut = XYScrolling[7:0];
          else
            cpuDataOut = XYScrolling[15:8];
        end

        6: begin
          if(ppuMemAddrToggle)
            cpuDataOut = ppuMemAddress[7:0];
          else
            cpuDataOut = ppuMemAddress[15:8];
        end

        default: cpuDataOut = controlRegisters[cpuAddr];
      endcase
  end

  always_latch
  begin
    if(!ppuCS & !cpuRW) //if cpu is writing data to the ppu
    begin
      cpuDataBuffer = cpuDataIn;
      cpuAddrBuffer = cpuAddr;
      bufferedIn = 1;
    end
  end

  always_ff@(posedge clock)
  begin
    if(ppuCS & bufferedIn) //data done being transferred in
    begin
      

      



endmodule


module MemoryAccess(
  input logic clock,
  input logic read,
  input logic write,
  input logic [7:0] dataIn,
  output logic [7:0] dataOut,
  input logic [13:0] addressIn)