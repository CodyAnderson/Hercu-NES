`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2018 02:42:03 PM
// Design Name: 
// Module Name: INVERTER
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


module INVERTER(DataBus,DataOut);

    input logic [7:0] DataBus;
    output logic [7:0] DataOut;
    
    //Invert data and ship it
    always_comb
        begin
            DataOut = ~DataBus;
        end
endmodule
