`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2018 01:08:03 PM
// Design Name: 
// Module Name: PC_LOW_SEL
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


module PC_LOW_SEL(
    //Enables incrementing the byte from the select module
    input logic pcLowInc_EN,
    //Program counter low from the program counter select module
    input logic [7:0] pcLowSel_IN,
    
    //Carry out from pc low increment to pc high increment enable
    output logic pcLowCarry_EN,
    //Output to program counter high register
    output logic [7:0] pcLow_OUT);
    
    always_comb
    begin
        //Output pcLowSel_IN +1 if increment line is high
        if(pcLowInc_EN)
        begin
            //Give pcLowCarry_EN the carry bit
            {pcLowCarry_EN,pcLow_OUT} =  pcLowSel_IN + 1;
        end
        
        //Output pcHighSel_IN unmodified if no carry
        else
        begin
            pcLow_OUT = pcLowSel_IN;
        end
    end
endmodule
