`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2018 07:07:18 PM
// Design Name: 
// Module Name: ADDRESSLOW_BUS
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


module ADDRESSLOW_BUS(
    input logic [7:0] data_IN,
    input logic bit0Drain_IN,
    input logic bit1Drain_IN,
    input logic bit2Drain_IN,
    output logic [7:0] addressLowBus_OUT);
    assign addressLowBus_OUT = ({5'b11111,!bit2Drain_IN,!bit1Drain_IN,!bit0Drain_IN} & data_IN);
endmodule
