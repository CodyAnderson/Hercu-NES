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
    always_comb
    begin
        if(addressHighWrite_EN)
        begin
            addressHigh_OUT = data;
        end
        
        if(addressLowWrite_EN)
        begin
            addressLow_OUT = data;
        end
        
        if(dataBusWrite_EN)
        begin
            dataBus_OUT = data;
        end
    end
    
    always_latch
    begin
        if(phi2) 
        begin
            data <= data_IN;        
        end
    end
endmodule
