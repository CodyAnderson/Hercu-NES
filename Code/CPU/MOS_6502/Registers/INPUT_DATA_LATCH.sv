`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2018 04:31:43 PM
// Design Name: INPUT_DATA_LATCH
// Module Name: INPUT_DATA_LATCH
// Project Name: Hercu-NES
// Description: Input data latch
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module INPUT_DATA_LATCH(
    input logic [7:0] data_IN,
    input logic addressHighWrite_EN,
    input logic addressLowWrite_EN,
    input logic dataBusWrite_EN,
    input logic phi2,
    output logic [7:0] dataBus_OUT,
    output logic [7:0] addressLow_OUT,
    output logic [7:0] addressHigh_OUT);
    
    logic [7:0] data;
    
    logic [7:0] intr_dataBus_OUT;
    logic [7:0] intr_addressHigh_OUT;
    logic [7:0] intr_addressLow_OUT;
    
    assign (strong0, weak1) addressHigh_OUT = intr_addressHigh_OUT;
    assign (strong0, weak1) addressLow_OUT = intr_addressLow_OUT;
    assign (strong0, weak1) dataBus_OUT = intr_dataBus_OUT;
    
    always_comb
    begin
        if(addressHighWrite_EN)
            intr_addressHigh_OUT = data;
        else
            intr_addressHigh_OUT = 'hff;
        
        if(addressLowWrite_EN)
            intr_addressLow_OUT = data;
        else
            intr_addressLow_OUT = 'hff;
        
        if(dataBusWrite_EN)
            intr_dataBus_OUT = data;
        else
            intr_dataBus_OUT = 'hff;
    end
    
    always_latch
    begin
        if(phi2) 
        begin
            data <= data_IN;        
        end
    end
endmodule
