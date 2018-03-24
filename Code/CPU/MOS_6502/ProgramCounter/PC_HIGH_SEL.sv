`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2018 01:08:03 PM
// Design Name: 
// Module Name: PC_HIGH_SEL
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


module PC_HIGH_SEL(
    //Enable line for grabbing input from address high bus
    input logic addressHigh_EN,
    //Enable line for grabbing input from program counter high register
    input logic pcHigh_EN,
    //Input from address high bus
    input logic [7:0] addressHighBus_IN,
    //Input from program counter high register
    input logic [7:0] pcHigh_IN,
    
    //Output to program counter high increment
    output logic [7:0] pcHighInc_OUT);
    
    always_comb
    begin
        if(addressHigh_EN)
        begin
            pcHighInc_OUT = addressHighBus_IN;
        end
        
        else if(pcHigh_IN)
        begin
            pcHighInc_OUT = pcHigh_IN;
        end
    end
endmodule
