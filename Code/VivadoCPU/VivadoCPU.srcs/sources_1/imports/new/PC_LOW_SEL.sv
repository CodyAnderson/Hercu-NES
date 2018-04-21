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
    //Enable line for grabbing input from address low bus
    input logic addressLow_EN,
    //Enable line for grabbing input from program counter low register
    input logic pcLow_EN,
    //Input from address low bus
    input logic [7:0] addressLowBus_IN,
    //Input from program counter low register
    input logic [7:0] pcLow_IN,
    
    //Output to program counter low increment
    output logic [7:0] pcLowInc_OUT);
    
    always_comb
    begin
        if(addressLow_EN)
        begin
            pcLowInc_OUT = addressLowBus_IN;
        end
        
        else if(pcLow_IN)
        begin
            pcLowInc_OUT = pcLow_IN;
        end
    end
endmodule
