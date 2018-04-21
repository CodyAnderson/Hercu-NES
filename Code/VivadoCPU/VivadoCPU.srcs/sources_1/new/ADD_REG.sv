`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 12:05:04 PM
// Design Name: ADD_REG
// Module Name: ADD_REG
// Project Name: Hercu-NES
// Description: ADDER Hold register implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ADD_REG(
    //Output from ALU
    input logic [7:0] alu_OUT,
    //Address low enable line
    input logic adl_EN,
    //System bus bits 0-6 enable
    input logic sb06_EN,
    //System bus bit 7 enable (related to right shifting)
    input logic sb7_EN,
    //Phi2 clock
    input logic phi2,
    //Address low bus output
    output logic [7:0] addressLowBus,
    //System bus output
    output logic [7:0] systemBus);
    
    //Data held in register
    logic [7:0] data;
    
    always_comb
    begin
        if(adl_EN)
            addressLowBus = data;
        else
            addressLowBus = 'bz;
            
        if(sb06_EN)
            systemBus[6:0] = alu_OUT[6:0];
        else
            systemBus[6:0] = 'bz;
        
        if(sb7_EN)
            systemBus[7] = alu_OUT[7];
        else
            systemBus[7] = 'bz;  
    end
    
    always_latch
    begin
        if(phi2)
            data <= alu_OUT;
    end
endmodule
