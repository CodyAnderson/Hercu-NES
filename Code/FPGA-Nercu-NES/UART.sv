`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// Company: DigiPen Institute of Technology
// Engineer: Ben Nollan
//           Cody Anderson
// 
// Module Name: UartTransmit
// Project Name: Daltonismo
// Target Devices: Digilent Nexys Video
// Tool Versions: Vivado 2016.4
// Description: Transmits a byte of data using the UART protocol.
// Inputs:
//  clk - internal reference clock
//  newData - set high for at least one clock cycle to start transmission
//  dataIn - byte of data that will be transmitted
//  
// Outputs:
//  tx - the UART transmission pin
//  done - signaling if the data has finished sending
// 
///////////////////////////////////////////////////////////////////////////////

module UartTransmit(input clk, input newData, input [7:0]dataIn, 
            output logic tx = 1, output done
            );

parameter BAUD_RATE = 9_600; //Transmitting serial speed (commonly 9600).
parameter CLOCK_SPEED = 50_000_000;  //Internal clock speed (usually 100Mhz).


logic [26:0]divider = 0;
logic transmitting;
logic[9:0] transmitReg = 0;
assign done = !transmitting;
assign transmitting = |(transmitReg);

always_ff@(posedge clk)
begin
  

  //if module is not sending and new data has been loaded in
  if(newData && transmitting == 0)
  begin
      // Loads the transmitter with a UART packet.
    transmitReg <= {1'b1, dataIn, 1'b0};
  end
  //if module is currently transmitting
  if(transmitting && divider < CLOCK_SPEED/BAUD_RATE - 1)
    divider <= divider + 1;
  else
  begin
    divider <= 0;
    if(transmitReg != 0)
    begin
      //Transmit the least significant bit and shift by one.
      tx <= transmitReg[0];
      transmitReg <= transmitReg >> 1;
    end
  end
end

endmodule





///////////////////////////////////////////////////////////////////////////////
// Company: DigiPen Institute of Technology
// Engineer: Ben Nollan
//           Cody Anderson
// 
// Module Name: UartReceive
// Project Name: Daltonismo
// Target Devices: Digilent Nexys Video
// Tool Versions: Vivado 2016.4
// Description: Receives a byte of data using the UART protocol.
// Inputs:
//  clk - internal reference clock
//  readData - Set high to indicate that the current byte has been read.
//  rx - the UART reception pin.
//  
// Outputs:
//  ready - Goes high when a new byte has been read.
//  dataOut - the most current data byte that has been read.
// 
///////////////////////////////////////////////////////////////////////////////

module UartReceive(input clk, input readData, input rx,  
            output logic ready = 0, output [7:0]dataOut
            );

parameter BAUD_RATE = 2_000_000; //Transmitting serial speed (commonly 9600).
parameter CLOCK_SPEED = 100_000_000;  //Internal clock speed (usually 100Mhz).
typedef enum logic[1:0] {LOOK4START,WAIT2READ,READ} ReceptionStages;
logic [26:0]divider = 0;
logic [2:0]prevReceive = ~3'b0;
logic [8:0]internalData;
ReceptionStages stage = LOOK4START;
always_ff@(posedge clk)
begin
  //Keeps track of previous values of rx for detecting the start bit.
  prevReceive <= {prevReceive[1:0],rx};
  if(readData)
    ready <= 0;
  case(stage)
      //checks if the rx line has transitioned from high to low for the start bit.
      //prevReceive used to be one bit wide but was expanded to remove false starts.
    LOOK4START:if(prevReceive == 3'b100 && !rx)
      begin
        stage <= WAIT2READ;
        internalData <= ~8'b0;
          //Delays for half a period to get to the middle of the data bit.
        divider <= (CLOCK_SPEED/BAUD_RATE)/2 + 3;
      end
        //Waits for one period to get to the next bit.
    WAIT2READ:begin
      divider <= divider + 1;
      if(divider > CLOCK_SPEED/BAUD_RATE-3)
        stage <= READ;
    end
      //Reads in one bit, bitshifting the rest
    READ:begin    
      divider <= 0;
        //Data has all been read in when the start bit (0) is the least significant.
      if(internalData[0])
      begin
        internalData <= {rx,internalData[7:1]};
        stage <= WAIT2READ;
      end
      else
      begin
        dataOut <= {rx,internalData[7:1]};
        ready <= 1;
        stage <= LOOK4START;
      end
    end
    default:stage <= LOOK4START;
  endcase
end
endmodule




///////////////////////////////////////////////////////////////////////////////
// Company: DigiPen Institute of Technology
// Engineer: Ben Nollan
//           Cody Anderson
// 
// Module Name: Char2Hex
// Project Name: Daltonismo
// Target Devices: Digilent Nexys Video
// Tool Versions: Vivado 2016.4
// Description: Turns a letter into it's hexadecimal representation
// Inputs:
//  dataIn - Character to convert
//  
// Outputs:
//  validChar - high if character is 0-9 or A-F or a-f.
//  numOut - The converted number (0 to 15).
// 
///////////////////////////////////////////////////////////////////////////////

module Char2Hex (
  input logic[7:0] dataIn,  // Input Character
  output logic validChar,    // If the Character is hex
  output logic[3:0] numOut  // Output Hex number  
);

always_comb
begin
  if(dataIn >= "0" && dataIn <= "9")
  begin
    validChar = 1;
    numOut = dataIn - "0";
  end
  else if(dataIn >= "A" && dataIn <= "F")
  begin
    validChar = 1;
    numOut = dataIn - ("A" - 10);
  end
  else if(dataIn >= "a" && dataIn <= "f")
  begin
    validChar = 1;
    numOut = dataIn - ("a" - 10);
  end
  else
  begin
    validChar = 0;
    numOut = 'hX;
  end
end
endmodule

