`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2018 01:08:03 PM
// Design Name: 
// Module Name: PC_HIGH_INC
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


module PC_HIGH_INC(
    //Carry from pc low increment enable
    input logic pcLowCarry_EN,
    //Program counter high from the program counter select module
    input logic [7:0] pcHighSel_IN,
    //Output to program counter high register
    output logic [7:0] pcHigh_OUT);
    
    always_comb
    begin
        //Output pcHighSel_IN +1 if there was a carry from the pc low increment
        if(pcLowCarry_EN)
        begin
            pcHigh_OUT =  pcHighSel_IN + 1;
        end
        
        //Output pcHighSel_IN unmodified if no carry
        else
        begin
            pcHigh_OUT = pcHighSel_IN;
        end
    end
endmodule
