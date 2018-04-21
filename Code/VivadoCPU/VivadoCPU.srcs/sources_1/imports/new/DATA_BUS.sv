`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2018 07:07:18 PM
// Design Name: 
// Module Name: DATA_BUS
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


module DATA_BUS(
    input logic [7:0] data_IN,
    output logic [7:0] dataBus_OUT);
        
    assign dataBus_OUT = data_IN;
endmodule
