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
  input logic [7:0]cpuDat,
  input logic ppuCs,
  input logic cpuRW

  output logic ppuRD,
  output logic ppuWR,
  output logic ppuALE,
  output logic [13:0]ppuAddr,
  input logic [7:0]ppuDatIn,
  output logic [7:0]ppuDatOut


    );

  always_ff@(posedge clock)
  begin
    
  end



endmodule
