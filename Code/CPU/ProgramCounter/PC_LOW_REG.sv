`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2018 01:08:03 PM
// Design Name: 
// Module Name: PC_LOW_REG
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


module PC_LOW_REG(
    //Phi2 clock
    input logic phi2,
    //Enables address low bus output
    input logic addressLow_EN,
    //Enables data bus output
    input logic dataBus_EN,
    //Input from program counter increment logic
    input logic [7:0] pcLowInc_IN,
    
    //Output to program counter low select module
    output logic [7:0] pcLowSel_OUT,
    //Output to data bus
    output logic [7:0] dataBus_OUT,
    //Output to address high bus
    output logic [7:0] addressLowBus_OUT);
    
    //Upper byte of program counter
    logic [7:0] data;
    
    //On Phi2 clock
    always @(posedge phi2)
    begin
        //Send data out on address low bus if enabled
        if(addressLow_EN)
        begin
            addressLowBus_OUT = data;
        end
        
        //Send data out on data bus if enabled
        if(dataBus_EN)
        begin
            dataBus_OUT = data;
        end
        
        //Send data out to pc low select
        pcLowSel_OUT = data;
    end
    
    always_latch
    begin
        //Get new PC low on phi2
        if(phi2)
            data <= pcLowInc_IN;
    end
endmodule
