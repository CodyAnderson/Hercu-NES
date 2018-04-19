`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2016 12:52:08 PM
// Design Name: 
// Module Name: VGA
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


module VGA(
    input logic clk, 
    input logic [9:0]sw, 
    input logic nesClock,
    input logic nesClock_EN,
    input logic dataWrite,
    input logic syncroSignal,
    input logic [4:0]memAddrInRow,
    input logic [5:0]dataIn,

    output logic [3:0]vgaRed_OUT, 
    output logic[3:0]vgaGreen_OUT, 
    output logic[3:0]vgaBlue_OUT, 
    output logic Hsync_OUT, 
    output logic Vsync_OUT);


    /* The original NES pallete is hardcoded into the PPU and this is our rendition of that pallete */
    const logic[11:0]pallete[0:63] = '{ 12'h555, 12'h027, 12'h019, 12'h308, 12'h406, 12'h603, 12'h500, 12'h410, 12'h220, 12'h020, 12'h130, 12'h040, 12'h034, 12'h000, 12'h000, 12'h000,
                                        12'h999, 12'h15C, 12'h33F, 12'h62E, 12'h91B, 12'hA16, 12'h822, 12'h740, 12'h550, 12'h270, 12'h180, 12'h072, 12'h067, 12'h000, 12'h000, 12'h000,
                                        12'hCCC, 12'h5AF, 12'h78F, 12'hB6F, 12'hE5F, 12'hF5B, 12'hF66, 12'hD82, 12'hAA0, 12'h7C0, 12'h4D2, 12'h3D6, 12'h3BD, 12'h333, 12'h000, 12'h000,
                                        12'hFFF, 12'hADF, 12'hCCF, 12'hDBF, 12'hFBF, 12'hFBD, 12'hFBB, 12'hEC9, 12'hDD7, 12'hBE8, 12'hBE9, 12'hAEB, 12'hADE, 12'hAAA, 12'h000, 12'h000};

    logic [11:0]hline;
    logic [11:0]vline;
    logic [8:0]offset;
    logic [5:0]swb;

    logic [7:0]memAddrOutCol = 0;
    logic [4:0]memAddrOutRow = 0;
    assign memAddrOutCol = (hline - (448+FrontPorchW))/4;
    assign memAddrOutRow = (vline - (60+FrontPorchH))/4;
    logic [7:0]ramData;
    logic readEnable;

    logic [7:0]memAddrInCol = 0;
    
    logic dataWrite_PREV = 0;
    logic writeEnable;
    assign writeEnable = nesClock_EN && dataWrite;
    always_ff@(posedge nesClock)
    begin
        if(syncroSignal)
        begin
            memAddrInCol <= 0;
        end
        if(writeEnable)
            memAddrInCol <= memAddrInCol + 1;
    end


    VGAScreenBuffer BuffThemPixels(
    {2'b0, dataIn},
    {memAddrOutRow, memAddrOutCol},
    clk,
    {memAddrInRow, memAddrInCol},
    nesClock,
    writeEnable,
    ramData);

    logic Vsync, Hsync;
    logic [3:0] vgaRed, vgaGreen, vgaBlue;
    LogoAdd PlsAddLogo4Me(
    clk,
    hline >= 1000 && hline < 1000+400+sw && vline >= 500 && vline < 600,
    Vsync,
    Hsync,
    {vgaRed, vgaGreen, vgaBlue},
    Vsync_OUT,
    Hsync_OUT,
    {vgaRed_OUT, vgaGreen_OUT, vgaBlue_OUT}
    );

    parameter ScreenW = 1920, FrontPorchW = 180, SyncWidthW = 44, TotalPixelsW = 2229;
    parameter ScreenH = 1080, FrontPorchH = 35,  SyncWidthH = 5,  TotalPixelsH = 1122;

    logic [8:0] microPixel = 0;
    logic extraPixel = 0;

    logic syncroSignal_PREV = 0;
    always@(posedge clk)
    begin
        syncroSignal_PREV <= syncroSignal;
        if(syncroSignal == 1 && syncroSignal_PREV == 0)
        begin
            hline <= 0;
            vline <= TotalPixelsH - 'b111100;
        end

        hline <= hline + 1;
        if(hline == TotalPixelsW - 1 + extraPixel)
        begin
            if(microPixel > 187)
            begin
                extraPixel <= 1;
                microPixel <= microPixel - (187-104);
            end
            else
            begin
                extraPixel <= 0;
                microPixel <= microPixel + 104;
            end

            hline <= 0;
            vline <= vline + 1;
        end
        
        if(vline == TotalPixelsH)
        begin
            vline <= 0;
            offset <= offset + 1;
            swb <= sw;
        end
        
        if(hline > TotalPixelsW - SyncWidthW - 1 + extraPixel)
            Hsync <= 1;
        else
            Hsync <= 0;
            
        if(vline > TotalPixelsH - SyncWidthH - 1)
            Vsync <= 0;
        else
            Vsync <= 1;
            
            
        if(hline > FrontPorchW - 1 && hline < FrontPorchW + ScreenW && vline > FrontPorchH - 1 && vline < FrontPorchH + ScreenH)
        begin
            if(hline >= 448+FrontPorchW && hline < 1472+FrontPorchW && vline >= 60+FrontPorchH && vline < 1020+FrontPorchH)
            begin
                {vgaRed, vgaGreen, vgaBlue} <= pallete[ramData];
            end
            else if(swb[2])
            begin
                vgaRed <= ((hline + offset) / 16)%16;
                vgaGreen <= ((vline + (offset)/2) / 16)%16;
                vgaBlue <= ((hline + vline - offset) / 32)%16;
            end
            else if(swb[3] && !(offset % 4))
            begin
                vgaRed <= 15;
                vgaGreen <= 15;
                vgaBlue <= 15;
            end
            else if(swb[4] && hline % 2)
            begin
                vgaRed <= 15;
                vgaGreen <= 15;
                vgaBlue <= 15;
            end
            else if(swb[5] && vline % 2)
            begin
                vgaRed <= 15;
                vgaGreen <= 15;
                vgaBlue <= 15;
            end
            else
            begin
                vgaRed <= 0;
                vgaGreen <= 0;
                vgaBlue <= 0;
            end
                    
                
        end
        else
        begin
            vgaRed <= 0;
            vgaGreen <= 0;
            vgaBlue <= 0;
        end
        
    end
endmodule
