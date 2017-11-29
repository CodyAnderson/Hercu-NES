`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2017 09:22:29 PM
// Design Name: 
// Module Name: logicsim
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


module logicsim();

logic clk = 1;
always #5 clk = !clk;

  logic btnC = 0;
  logic btnU = 0;
  logic [7:0]JA;
  logic [7:0]JB;
  logic [7:0]JC;
  logic [7:0]JD;
  logic [15:0]sw;
  logic [15:0]led;
  logic RsTx;

  logic RamCLK;
  logic RamADVn;
  logic RamCEn;
  logic RamCRE;
  logic RamOEn;
  logic RamWEn;
  logic RamLBn;


  logic RamUBn;
  logic RamWait;
  logic[15:0] MemDB;
  logic[22:0] MemAdr;
  assign MemDB = MemAdr[15:0];

initial
begin
  #30 btnC = 1;
  #40 btnC = 0;
  #50 btnU = 1;
  #60 btnU = 0;
end

  LogicAnalyzer logi(clk, btnC, btnU, JA, JB, JC, JD, sw, led, RsTx, RamCLK, RamADVn, RamCEn, RamCRE, RamOEn, RamWEn, RamLBn, RamUBn, RamWait, MemDB, MemAdr);
endmodule
