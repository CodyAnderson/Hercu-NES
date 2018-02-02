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

module B_INPUT_REGISTER(DataBus, AddressLow, DataBusEn, InvDataBusEn, AddressLowEn, RegisterOut);

    //Data bus line
    input logic [7:0] DataBus;
    
    //Address low line
    input logic [7:0] AddressLow;
    
    //Read enable from data bus
    input logic DataBusEn;
    
    //Read enable from data bus, invert data
    input logic InvDataBusEn;
    
    //Read enable from address low line
    input logic AddressLowEn;
    
    //Output value to ALU
    output logic RegisterOut;
    
    //Register value
    logic [7:0] Regval;
    
    //Update register
    always_latch
    begin
        //Read from data bus
        if(DataBusEn)
            begin
                Regval = DataBus;
            end
        //Read from data bus, invert data
        else if(InvDataBusEn)
            begin
                Regval = ~DataBus;
            end
        //Read from address low bus
        else if(AddressLowEn)
            begin
                Regval = AddressLow;   
            end
            
        //Update register output
        RegisterOut = Regval;
    end
endmodule
