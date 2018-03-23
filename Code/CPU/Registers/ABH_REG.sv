`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2018 02:19:00 PM
// Design Name: 
// Module Name: ABH_REG
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

module ABH_REG(
    //Phi 1 clock
    input logic phi1,
    //Load enable from address high bus
    input logic load_EN,
    //Input from address high bus
    input logic [7:0] addressHighBus_IN,
    
    //External address output
    output logic [7:0] address_OUT);
    
    //Register data
    logic [7:0] data;
    
    //Assign address_OUT to be the data in the register (?)
    assign address_OUT = data;
    
    //On phi 1
    always @(posedge phi1)
    begin
        //If load enabled, data = address high bus value
        if(load_EN)
        begin
            data = addressHighBus_IN;
        end
    end
endmodule
