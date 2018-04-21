`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2018 01:45:25 PM
// Design Name: A_INPUT_REGISTER
// Module Name: A_INPUT_REGISTER
// Project Name: HercuNES
// Target Devices: 
// Tool Versions: 
// Description: Implementation for A_INPUT_REGISTER, which is an input register for the ALU
// 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module A_INPUT_REGISTER(
    input logic [7:0]systemBus_IN,
    
    input logic systemBus_EN, 
    input logic zero_EN, 
    
    output logic [7:0] a_REG_OUT);

    
    //Register value
    logic [7:0] a_REG = 0;
    
    //Update register
    always_latch
    begin
        //Read from data bus
        if(systemBus_EN)
        begin
            a_REG = systemBus_IN;
        end
        //Read from address low bus
        else if(zero_EN)
        begin
            a_REG = 0;   
        end
            
        //Update register output
        a_REG_OUT = a_REG;
    end
endmodule
