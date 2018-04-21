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
//    input logic [7:0] datalatch_IN,
//    input logic [7:0] systemBus_IN,
//    input logic [7:0] programCounterLow_IN,
//    input logic [7:0] stackPointer_IN,
//    input logic [7:0] adderReg_IN,
    input logic [7:0] data_IN,
    input logic bit0Drain_IN,
    input logic bit1Drain_IN,
    input logic bit2Drain_IN,
    output logic [7:0] addressLowBus_OUT);
            
//    logic [7:0] intr_datalatch_IN;
//    logic [7:0] intr_systemBus_IN;
//    logic [7:0] intr_programCounterLow_IN;
//    logic [7:0] intr_addressLowBus_OUT;
//    logic [7:0] intr_stackPointer_IN;
//    logic [7:0] intr_adderReg_IN;
//    assign (strong0, weak1) intr_datalatch_IN = datalatch_IN;
//    assign (strong0, weak1) intr_systemBus_IN = systemBus_IN;
//    assign (strong0, weak1) intr_programCounterLow_IN = programCounterLow_IN;
//    assign (strong0, weak1) addressLowBus_OUT = intr_addressLowBus_OUT;
//    assign (strong0, weak1) intr_stackPointer_IN = stackPointer_IN;
//    assign (strong0, weak1) intr_adderReg_IN = adderReg_IN;
    assign addressLowBus_OUT = ({5'b11111,!bit2Drain_IN,!bit1Drain_IN,!bit0Drain_IN} & data_IN);
endmodule
