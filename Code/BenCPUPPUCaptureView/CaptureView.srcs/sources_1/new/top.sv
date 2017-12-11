`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2017 04:37:12 PM
// Design Name: 
// Module Name: top
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


module top();

  logic [31:0]CPUdata[4194304];
  initial begin
    $readmemh("../../../CPUDataCapture2.txt", CPUdata);
  end

  logic [31:0]PPUdata[4194304];
  initial begin
    $readmemh("../../../PPUDataCapture2.txt", PPUdata);
  end

  logic[31:0]clockCount = 0;
  logic clk = 1;

  always #5 clk = !clk;

  always_ff@(posedge clk)
  begin
    clockCount = clockCount + 1;
  end

  logic [31:0]cpuIndex;
  assign cpuIndex = clockCount / 6;

  logic [31:0]ppuIndex;
  assign ppuIndex = (clockCount-138) / 4;


  logic [31:0]currentCPU;
  assign currentCPU = CPUdata[cpuIndex];




  logic [15:0]cpuAddress;
  assign cpuAddress = currentCPU[31:16];
  logic [7:0]cpuData;
  assign cpuData = currentCPU[7:0];
  logic cpuIRQ;
  assign cpuIRQ = currentCPU[9];
  logic cpuNMI;
  assign cpuNMI = currentCPU[10];
  logic cpuRW;
  assign cpuRW = currentCPU[11];
  logic cpuOe1;
  assign cpuOe1 = currentCPU[12];
  logic cpuOe2;
  assign cpuOe2 = currentCPU[13];

  logic [31:0]currentPPU;
  assign currentPPU = clockCount >= 138 ? PPUdata[ppuIndex] : 'hz;

  logic [7:0]ppuCpuData;
  assign ppuCpuData = currentPPU[7:0];

  logic [2:0]ppuCpuAddr;
  assign ppuCpuAddr = currentPPU[10:8];

  logic ppuCS;
  assign ppuCS = currentPPU[11];

  logic ppuALE;
  assign ppuALE = currentPPU[12];

  logic ppuINT;
  assign ppuINT = currentPPU[13];

  logic ppuRW;
  assign ppuRW = currentPPU[14];

  logic [13:0]ppuAddrDat;
  assign ppuAddrDat = currentPPU[29:16];

  logic ppuRD;
  assign ppuRD = currentPPU[30];

  logic ppuWR;
  assign ppuWR = currentPPU[31];


endmodule
