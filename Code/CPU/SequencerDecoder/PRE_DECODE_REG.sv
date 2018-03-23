`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2018 04:55:02 PM
// Design Name: 
// Module Name: PRE_DECODE_REG
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


module PRE_DECODE_REG(
    input logic [7:0] data_IN,
    input logic phi2,
    output logic [7:0] preDecode_OUT);
    
    logic [7:0] data;
    
    always_comb
    begin
            preDecode_OUT = data;
    end
    
    always_latch
    begin
        if(phi2) 
        begin
            data <= data_IN;        
        end
    end
endmodule
