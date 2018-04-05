`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2018 03:06:36 PM
// Design Name: 
// Module Name: MOS_6502
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

module MOS_6502(
    //input logic vss1,        //pin 1
    input logic rdy,           //pin 2
    input logic notIRQ,        //pin 4
    //input logic nc1,         //pin 5
    input logic notNMI,        //pin 6
    input logic vcc,           //pin 8
    //input logic vss2,        //pin 21
    input logic [7:0] data_In, //pins [26:33]
    //input logic nc2,         //pin 35
    //input logic nc3,         //pin 36
    input logic phi0,          //pin 37
    input logic notSO,         //pin 38
    input logic notRES,        //pin 40


    output logic phi1_Out,       //pin 3
    output logic sync,           //pin 7
    output logic [15:0] address, //pins {[25:22], [20:9]}
    output logic [7:0] data_Out, //pins [26:33]
    output logic readNotWrite,   //pin 34
    output logic phi2_Out        //pin 39
    );

endmodule