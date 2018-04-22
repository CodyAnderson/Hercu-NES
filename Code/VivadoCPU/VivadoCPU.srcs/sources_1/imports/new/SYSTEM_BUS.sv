`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2018 07:07:18 PM
// Design Name: 
// Module Name: SYSTEM_BUS
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


module SYSTEM_BUS(
    input logic [7:0] data_IN,
    input logic addressHighPass_EN,
    input logic addressLowPass_EN,
    output logic [7:0] systemBus_OUT,
    output logic [7:0] addressHigh_OUT,
    output logic [7:0] addressLow_OUT);
        
    logic [7:0] intr_addressHigh_OUT;
    logic [7:0] intr_addressLow_OUT;
    assign systemBus_OUT = data_IN;
    assign intr_addressHigh_OUT = (addressHighPass_EN)? data_IN : 'hff;
    assign intr_addressLow_OUT = (addressLowPass_EN)? data_IN : 'hff;
    assign (strong0, weak1) addressHigh_OUT = intr_addressHigh_OUT;
    assign (strong0, weak1) addressLow_OUT = intr_addressLow_OUT; 
    
endmodule
