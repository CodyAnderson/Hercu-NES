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


module A_INPUT_REGISTER(SystemBus, SystemBusEn, ZeroEn, RegisterOut);

    //Data bus line
    input logic [7:0] SystemBus;
    
    //Read enable from data bus
    input logic SystemBusEn;
    
    //Zeros out register when enabled
    input logic ZeroEn;
    
    //Output value to ALU
    output logic RegisterOut;
    
    //Register value
    logic [7:0] Regval;
    
    //Update register
    always_latch
    begin
        //Read from data bus
        if(SystemBusEn)
            begin
                Regval = SystemBusEn;
            end
        //Read from address low bus
        else if(ZeroEn)
            begin
                Regval = 0;   
            end
            
        //Update register output
        RegisterOut = Regval;
    end
endmodule
