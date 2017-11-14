`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2017 03:53:17 PM
// Design Name: 
// Module Name: testbench
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


module testbench; 
    logic clk, reset, enable; 
    logic [7:0] count;
    
      /////////////
      // CPU Inputs
      /////////////
      logic cpuClock;              //21.47727MHz clock input, this needs to be divided by 12
      logic cpuReset;              //(ACTIVE LOW) resets the cpu, reset vector address is 0xFFFC
      logic cpuIrq;                //(ACTIVE LOW) Interrupt pin.
      logic cpuNmi;                //(ACTIVE LOW) NonMaskable Interrupt pin, connected to interrupt pin on PPU
      logic [7:0] cpuDataIn;       //CPU data input NOTE: on NES this is combined with dataOut
      
      //////////////
      // CPU Outputs
      //////////////
      logic [15:0] addressIn; //Used for addressing ROM, RAM, PPU, and ALU(audio)
      logic [7:0] cpuDataOut;     // CPU data output NOTE: data in and out are same pins on NES
      logic cpuRW;                //Read/Write of the CPU, read is HIGH, write is LOW.
      logic [1:0] cpuOE;          //(ACTIVE LOW) output enable for the two controllers.
      logic [2:0] cpuOut;         //output pins for the controllers
      logic [7:0] cpuAux1;        //audio output channel 1 (size may not be ideal)
      logic [7:0] cpuAux2;        //audio output channel 2 (size may not be ideal)
      
      NesCpu bob(cpuClock, reset ,cpuIrq, cpuNmi, cpuDataIn, cpuAddressOut, cpuDataOut, cpuRW, cpuOE, cpuOut, cpuAux1, cpuAux2);
      MemDogMillionaire bobIEEE(cpuClock, reset, cpuAddressOut, cpuDataIn);
      
    initial begin 
        clk = 0; 
        reset = 1; 
        enable = 0; 
        count = 0;
        
        cpuReset = 0;
        cpuClock = 0;
        cpuIrq = 0;
        cpuNmi = 0;
    end 
    
    always begin
        #5 clk =  ! clk;
    end 
    
    always @(posedge clk) begin
        cpuClock <= ~cpuClock;
        count <= count + 1;
        if(count == 1)
          begin
            reset <= 0;
          end
        else if(count == 255)
          begin
            $finish();
          end
    end

 endmodule 
