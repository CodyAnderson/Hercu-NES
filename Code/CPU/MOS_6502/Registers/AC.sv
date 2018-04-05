`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2018 01:44:25 PM
// Design Name: AC
// Module Name: AC
// Project Name: Hercu-NES
// Description: Accumulator implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AC(
    input logic [7:0] systemBus_IN,
    input logic [7:0] decAdjustAdders, //???
    input logic systemBusRead_EN,
    input logic systemBusWrite_EN,
    input logic dataBusWrite_EN,
    output logic [7:0] systemBus_OUT,
    output logic [7:0] dataBus_OUT);
    
    logic [7:0] data;
    logic [7:0] intr_systemBus_OUT;
    logic [7:0] intr_dataBus_OUT;
    
    assign (strong0, weak1) systemBus_OUT = intr_systemBus_OUT;
    assign (strong0, weak1) dataBus_OUT = intr_dataBus_OUT;
    
    always_comb
    begin
        if(systemBusWrite_EN)
            intr_systemBus_OUT = data;
        else
            intr_systemBus_OUT = 'hff;
            
        if(dataBusWrite_EN)
            intr_dataBus_OUT = data;
    end
    
    always_latch
    begin
        if(systemBusRead_EN)
            data <= systemBus_IN;
    end
endmodule
