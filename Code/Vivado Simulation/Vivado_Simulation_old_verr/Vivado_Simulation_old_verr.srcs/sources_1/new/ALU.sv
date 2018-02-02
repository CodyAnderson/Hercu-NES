`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2018 12:38:12 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic [7:0] b_REG_IN,
    input logic [7:0] a_REG_IN,
    
    input logic shiftRight_EN,
    input logic eor_EN,
    input logic and_EN,
    input logic sum_EN,
    input logic or_EN,
    
    output logic [7:0] hold_REG_OUT,
    output logic overflow_FLAG,
    output logic carry_FLAG);
    
    logic [7:0] eorResult;
    logic [7:0] andResult;
    logic [7:0] sumResult;
    logic [7:0] shiftRightResult;
    logic [7:0] orResult;
    
    always_comb
    begin
       eorResult = b_REG_IN ^ a_REG_IN;
       andResult = b_REG_IN & a_REG_IN;
       shiftRightResult = a_REG_IN >> 1;
       sumResult = b_REG_IN + a_REG_IN; 
        
        
    end
    
endmodule
