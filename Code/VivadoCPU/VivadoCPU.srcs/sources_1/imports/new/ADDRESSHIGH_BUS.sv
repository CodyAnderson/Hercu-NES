`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2018 07:07:18 PM
// Design Name: 
// Module Name: ADDRESSHIGH_BUS
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


module ADDRESSHIGH_BUS(
    input logic [7:0] data_IN,
    input logic bit0Drain_IN,
    input logic bit1to7Drain_IN,
    output logic [7:0] addressLowBus_OUT);
        
    logic [6:0] mask;
    assign mask = (bit1to7Drain_IN)? {6'b000000,bit0Drain_IN} : {6'b111111,bit0Drain_IN};
    assign addressLowBus_OUT = (mask & data_IN);
endmodule
