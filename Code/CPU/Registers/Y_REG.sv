`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 01:44:25 PM
// Design Name: Y_REG
// Module Name: Y_REG
// Project Name: Hercu-NES
// Description: Y register implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Y_REG(
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
