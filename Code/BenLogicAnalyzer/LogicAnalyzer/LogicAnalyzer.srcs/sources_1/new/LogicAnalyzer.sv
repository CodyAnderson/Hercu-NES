`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2017 05:35:08 PM
// Design Name: 
// Module Name: LogicAnalyzer
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

function [7:0] Hex2Char;
  input [3:0] hex;
  begin
    if(hex < 10)
      Hex2Char = hex + "0";
    else
      Hex2Char = hex + "A" - 10;
  end
endfunction


module LogicAnalyzer(
  input clk,
  input logic btnC,
  input logic btnU,
  input logic [7:0]JA,
  input logic [7:0]JB,
  input logic [7:0]JC,
  input logic [7:0]JD,
  input logic [15:0]sw,
  output logic [15:0]led,
  output logic RsTx,

       
  output logic RamCLK,
  output logic RamADVn,
  output logic RamCEn,
  output logic RamCRE,
  output logic RamOEn,
  output logic RamWEn,
  output logic RamLBn,


  output logic RamUBn,
  input logic RamWait,
  inout logic[15:0] MemDB,
  output logic[22:0] MemAdr = 0

    );

logic cpuRead = 0;
logic cpuWrite = 0;
logic prevcpuclock = 0;
logic cpuClock = 0;
logic readNow;
assign readNow = cpuClock & (!prevcpuclock);
logic [15:0] cpuAddress;
assign cpuAddress = {JB,JA};

logic [15:0] memOut;
assign MemDB = cpuRead ? memOut : 16'bZ;
logic ramRead = 0;
logic ramReady = 0;
logic ramWrite = 0;
assign RamCLK = 0;
assign RamADVn = 0;
assign RamCRE = 0;
assign RamUBn = 0;
assign RamCEn = !(ramWrite | ramRead);
assign RamWEn = !ramWrite;
assign RamOEn = !ramRead;
assign RamLBn = 0;

logic [2:0]readStage = 0;
logic [2:0]writeStage = 0;
logic highLow = 0;
logic [15:0]highBuffer;

logic[7:0] uartData;
logic uartDataSend;
assign uartDataSend = cpuWrite;
logic uartDataSent;
UartTransmit tx(clk, uartDataSend, uartData, RsTx, uartDataSent);
assign led[0] = RsTx;
assign led[1] = uartDataSent;
assign led[2] = uartDataSend;
assign led[3] = cpuWrite;
assign led[4] = cpuRead;
assign led[5] = ramReady;
assign led[15:8] = MemAdr[22:15];


always_ff@(posedge clk)
begin
  if(btnC)
  begin
    MemAdr <= 0;
    cpuRead <= 0;
    ramReady <= 1;
    highLow <= 0;
    cpuWrite <= 0;
    readStage <= 0;
  end
  else if(ramReady == 1 && cpuRead == 0 && cpuAddress == 16'hFFFC)
  begin
    cpuRead <= 1;
    ramReady <= 0;
  end
  else if(cpuRead == 1)
  begin
    if(readNow)
    begin
      if(readStage < 5)
        readStage <= readStage + 1;
      else
        readStage <= 0;
      case(readStage)
        //1read into input buffer
        //1turn write on
        //1set valid data
        0:begin
          highBuffer <= {JD,JC};
          memOut <= {JB,JA};
          ramWrite <= 1;
        end
        //2turn write off
        1:begin
          ramWrite <= 0;
        end
        //3next address
        2:begin
          MemAdr <= MemAdr + 1;
        end
        //4set next data
        //4turn write on
        3:begin
          memOut <= highBuffer;
          ramWrite <= 1;
        end
        //5turn write off
        4:begin
          ramWrite <= 0;
        end
        //6next address
        5:begin
          if(MemAdr == 23'h7FFFFF)
            cpuRead <= 0;

          MemAdr <= MemAdr + 1;

        end
      endcase
    end
  end

  if(btnU && ramReady == 1 && cpuWrite == 0)
  begin
    ramReady <= 0;
    cpuWrite <= 1;
    MemAdr <= 0;
    writeStage <= 1;
    ramRead <= 1;
    uartData <= Hex2Char(MemAdr >> 12);
  end

  if(cpuWrite)
  begin
    if(uartDataSent)
    begin
      
      if(writeStage == 4)
        writeStage <= 0;
      else
        writeStage <= writeStage + 1;

      case(writeStage)
        0:uartData <= Hex2Char(MemDB >> 12);
        1:uartData <= Hex2Char(MemDB >> 8);
        2:uartData <= Hex2Char(MemDB >> 4);
        3:begin
          uartData <= Hex2Char(MemDB);
        end
        4:begin
          if(highLow)
            uartData <= "\r";
          else
            uartData <= " ";
          highLow <= !highLow;
          
          if(MemAdr == 23'h7FFFFF)
          begin
            cpuWrite <= 0;
            ramRead <= 0;
          end
          else
          begin
            MemAdr <= MemAdr + 1;
            
          end
        end
      endcase // writeStage
    end

  end

  cpuClock <= JD[0];
  prevcpuclock <= cpuClock;
end


endmodule


