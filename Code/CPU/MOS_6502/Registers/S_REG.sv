`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 01:44:25 PM
// Design Name: S_REG
// Module Name: S_REG
// Project Name: Hercu-NES
// Description: Stack Pointer register implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module S_REG(
    input logic [7:0] systemBus_IN,
    input logic systemBusWrite_EN,
    input logic systemBusRead_EN,
    input logic addressLowWrite_EN,
    input logic hold_EN,
    input logic phi2, //I don't know if phi2 is needed or not
    output logic systemBus_OUT,
    output logic addressLowBus_OUT);
    
    logic [7:0] data_IN;
    logic [7:0] data_OUT;
    
    always_comb
    begin
        if(systemBusWrite_EN)
            systemBus_OUT = data_OUT;
        else
            systemBus_OUT = 'bz;
        
        if(addressLowWrite_EN)
            addressLowBus_OUT = data_OUT;
        else
            addressLowBus_OUT = 'bz;
    end
    
    always_latch
    begin
        if(systemBusRead_EN && !hold_EN)
            data_IN = systemBus_IN;
            
        if(phi2) //SERIOUS DOUBTS ABOUT THIS CODE
            data_OUT = data_IN;
    
    end
    
    
endmodule
