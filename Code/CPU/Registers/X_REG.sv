`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 01:44:25 PM
// Design Name: X_REG
// Module Name: X_REG
// Project Name: Hercu-NES
// Description: X register implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module X_REG(
    input logic [7:0] systemBus_IN,
    input logic systemBusRead_EN,
    input logic systemBusWrite_EN,
    output logic [7:0] systemBus_OUT);
    
    logic [7:0] data;
    
    always_comb
    begin
        if(systemBusWrite_EN)
            systemBus_OUT = data;
        else
            systemBus_OUT = 'bz;
    end
    
    always_latch
    begin
        if(systemBusRead_EN)
            data <= systemBus_IN;
    end
    
endmodule
