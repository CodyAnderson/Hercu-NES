`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Team HercuNES
// Engineer: Ryan Price
// 
// Create Date: 02/02/2018 01:45:25 PM
// Design Name: ALU
// Module Name: ALU
// Project Name: HercuNES
// Target Devices: 
// Tool Versions: 
// Description: Implementation of 6502 ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input logic [7:0] a_REG_IN,
    input logic [7:0] b_REG_IN,
    
    input logic shiftRight_EN,
    input logic eor_EN,
    input logic and_EN,
    input logic sum_EN,
    input logic or_EN,
    input logic carry_FLAG_IN,
    
    
    output logic [7:0] hold_REG_OUT,
    output logic overflow_FLAG_OUT,
    output logic carry_FLAG_OUT,
    output logic negative_FLAG_OUT,
    output logic zero_FLAG_OUT);
    
    logic [7:0] eorResult = 0;
    logic [7:0] andResult = 0;
    logic [7:0] sumResult = 0;
    logic [7:0] shiftRightResult = 0;
    logic [7:0] orResult = 0;
    
    always_comb
    begin
        //Get eor result
        eorResult = b_REG_IN ^ a_REG_IN;
        //Get and result
        andResult = b_REG_IN & a_REG_IN;
        //Get shift result
        shiftRightResult = a_REG_IN >> 1;
        //Get carry flag out and summation
        {carry_FLAG_OUT,sumResult} = b_REG_IN + a_REG_IN + carry_FLAG_IN;
        //Get or result
        orResult = (a_REG_IN | b_REG_IN);
    
        //XOR
        if(eor_EN)
        begin
            //Negative flag is bit 7 of result
            negative_FLAG_OUT = (b_REG_IN ^ a_REG_IN) > 7;
            //Zero flag is set if result is 0
            zero_FLAG_OUT = ((b_REG_IN ^ a_REG_IN) == 0);
            //Output value
            hold_REG_OUT = eorResult;
        end
        
        //AND
        if(and_EN)
        begin
            //Negative flag is bit 7 of result
            negative_FLAG_OUT = (b_REG_IN & a_REG_IN) > 7;
            //Zero flag is set if result is 0
            zero_FLAG_OUT = ((b_REG_IN & a_REG_IN) == 0);
            //Output value
            hold_REG_OUT = andResult;
        end
        //Right shift
        if(shiftRight_EN)
        begin
            //Negative flag is bit 7 of result
            negative_FLAG_OUT = (a_REG_IN >> 1) > 7;
            //Zero flag is set if result is 0
            zero_FLAG_OUT = ((a_REG_IN >> 1) == 0);
            //Output value
            hold_REG_OUT = shiftRightResult;
        end
        
        //Summation
        if(sum_EN)
        begin
            //Get carry from 7th bit addition, xor with carry out (carry from 8th bit addition) to get overflow
            overflow_FLAG_OUT = ( ({1'b0,a_REG_IN[6:0]} + b_REG_IN[6:0]) >> 7 ) ^ carry_FLAG_OUT; 
            //Zero flag is set if result is 0
            zero_FLAG_OUT = ((b_REG_IN + a_REG_IN + carry_FLAG_IN) == 0);      
            //Negative flag is bit 7 of result
            negative_FLAG_OUT = (b_REG_IN + a_REG_IN + carry_FLAG_IN) >> 7;
            //Output value
            hold_REG_OUT = sumResult;
        end
        
        //OR
        if(or_EN)
        begin

            //Zero flag is set if result is 0
            zero_FLAG_OUT = ((b_REG_IN | a_REG_IN) == 0);
            //Negative flag is bit 7 of result
            negative_FLAG_OUT = (b_REG_IN | a_REG_IN) > 7;
            //Output value
            hold_REG_OUT = orResult;
             
        end
    end
    
endmodule
