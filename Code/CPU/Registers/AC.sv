`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 01:44:25 PM
// Design Name: AC
// Module Name: AC
// Project Name: Hercu-NES
// Description: Accumulator implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AC(
    input logic [7:0] systemBus_IN,
    input logic [7:0] decAdjustAdders, //???
    input logic systemBusRead_EN,
    input logic systemBusWrite_EN,
    input logic dataBusWrite_EN,
    output logic [7:0] systemBus_OUT,
    output logic [7:0] dataBus_OUT);
    
    logic [7:0] data;
    
    always_comb
    begin
        if(systemBusWrite_EN)
            systemBus_OUT = data;
        else
            systemBus_OUT = 'bz;
            
        if(dataBusWrite_EN)
            dataBus_OUT = data;
    end
    
    always_latch
    begin
        if(systemBusRead_EN)
            data <= systemBus_IN;
    end
endmodule
