`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2018 02:50:20 AM
// Design Name: 
// Module Name: RunLengthDecoder
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

module LogoAdd(
    input logic clock,
    input logic enable,
    input logic vSync_IN,
    input logic hSync_IN,
    input logic [11:0]vgaColors_IN,
    output logic vSync_OUT,
    output logic hSync_OUT,
    output logic [11:0]vgaColors_OUT
    );

    logic [3:0]logoAlpha;
    logic [3:0]logoBrightness;
    RunLengthDecoder LogoDecoder(
        clock, 
        !vSync_IN,
        enable,
        logoAlpha,
        logoBrightness
        );


    always_ff@(posedge clock)
    begin
        vSync_OUT <= vSync_IN;
        hSync_OUT <= hSync_IN;

        /*vgaColors_OUT[3:0] <= (logoBrightness * logoAlpha + vgaColors_IN[3:0] * (15-logoAlpha)) / 15;
        vgaColors_OUT[7:4] <= (logoBrightness * logoAlpha + vgaColors_IN[7:4] * (15-logoAlpha)) / 15;
        vgaColors_OUT[11:8] <= (logoBrightness * logoAlpha + vgaColors_IN[11:8] * (15-logoAlpha)) / 15;*/
        vgaColors_OUT[3:0] <= logoAlpha ? logoBrightness : vgaColors_IN[3:0];
        vgaColors_OUT[7:4] <=  logoAlpha ? logoBrightness : vgaColors_IN[7:4] ;
        vgaColors_OUT[11:8] <= logoAlpha ? logoBrightness : vgaColors_IN[11:8];

    end



endmodule

module RunLengthDecoder(
    input logic clock, 
    input logic reset,
    input logic enable,
    output logic [3:0] alpha,
    output logic [3:0] brightness
    );
    logic [7:0] currentCount = 0;
    logic [7:0] currentValue = 0;
    logic [12:0] memIndex = 0;
    logic [15:0] logoData;
logoROM TheLogo(
    memIndex,
    clock,
    logoData);
    
    assign alpha = enable ? currentValue[3:0] : 'b0;
    assign brightness = enable ? currentValue[7:4] : 'b0;
    
    always@(posedge clock)
    begin
        if(reset)
        begin
            memIndex <= 0;
            currentCount <= 0;
            currentValue <= 0;
        end
        if(enable & 0)
        begin
            if(currentCount == 0)
            begin
                {currentCount, currentValue} <= logoData;
                if(memIndex == 3438)
                    memIndex <= 0;
                else
                    memIndex <= memIndex + 1;
                    
            end
            else
                currentCount <= currentCount - 1;
        end
    end
endmodule
