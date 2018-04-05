`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HercuNES
// Engineer: Ryan Price
// 
// Create Date: 02/01/2018 12:29:25 PM
// Design Name: B_INPUT_REGISTER
// Module Name: B_INPUT_REGISTER
// Project Name: HercuNES

// Description: Implementation for B_INPUT_REGISTER, which is an input register for the ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module B_INPUT_REGISTER(
    input logic [7:0] dataBus_IN,
    input logic [7:0] addressLow_IN,
    
    input logic dataBus_EN,
    input logic dataBusInvert_EN,
    input logic addressLow_EN,
    
    output logic [7:0] b_REG_OUT);

    //Register value
    reg [7:0] b_REG;
    
    //Update register
    always_latch
    begin
        //Read from data bus
        if(dataBus_EN)
        begin
            b_REG = dataBus_IN;
        end
        //Read from data bus, invert data
        else if(dataBusInvert_EN)
        begin
            b_REG = ~dataBus_IN;
        end
        //Read from address low bus
        else if(addressLow_EN)
        begin
            b_REG = addressLow_IN;   
        end
            
        //Update register output
        b_REG_OUT = b_REG;
    end
endmodule
