`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Hercu-NES
// Engineer: Ben Nollan
// 
// Create Date: 02/20/2018 03:33:55 PM
// Design Name: 
// Module Name: RegisterHandler
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

  
`define CONTROL_REGISTER {interrupt_EN, ppuMasterSlave, spriteSize, backgroundPatternTableAddress, spritePatternTableAddress, incrementMode, tempVideoRamAddress[11:10]}
`define MASK_REGISTER {colorEmphasis, sprite_EN, background_EN, spriteLeftColumn_EN, backgroundLeftColumn_EN, greyscale_EN}
`define STATUS_REGISTER {verticalBlankRegion, spriteCollision, spriteOverflow, 5'bZ}
`define SCROLL_W0 {tempVideoRamAddress[4:0], fineXScroll}
`define SCROLL_W1 {tempVideoRamAddress[9:5], tempVideoRamAddress[14:12]}
`define VRAM_ADDR_W0 {tempVideoRamAddress[14:8]}
`define VRAM_ADDR_W1 {tempVideoRamAddress[7:0]}
`define COARSE_PAGE_X {videoRamAddress[10], videoRamAddress[4:0]}
`define FINE_Y (videoRamAddress[14:12])
`define COARSE_Y (videoRamAddress[9:5])
`define PAGE_Y (videoRamAddress[11])

module RegisterHandler(
    input logic clk,
    input logic readWrite,
    input logic control_EN, //0
    input logic mask_EN,    //1
    input logic status_EN,  //2
    input logic oamAddr_EN, //3
    input logic oamData_EN, //4
    input logic scroll_EN,  //5
    input logic ramAddr_EN, //6
    input logic ramData_EN,  //7
    input logic [7:0]cpuData_IN,
    output logic [7:0]cpuData_OUT,
    input logic spriteOverflow,
    input logic spriteCollision,
    input logic verticalBlankRegion,
    output logic clearVerticalBlank,
    output logic [7:0]oamAddress,
    output logic [14:0]videoRamAddress,
    
    );

    //For Control REG
    logic incrementMode;
    logic spritePatternTableAddress; //only for 8x8 sprites
    logic backgroundPatternTableAddress;
    logic spriteSize;               //0=8x8, 1=8x16
    logic ppuMasterSlave;           //NOT USED!!
    logic interrupt_EN;

    //For Mask REG
    logic greyscale_EN;
    logic backgroundLeftColumn_EN;
    logic spriteLeftColumn_EN;
    logic background_EN;
    logic sprite_EN;
    logic [2:0]colorEmphasis;

    
    logic [14:0]tempVideoRamAddress;
    logic [2:0]fineXScroll;


    logic writeToggle = 0;
    logic shouldToggleWrite;
    logic prevShouldToggleWrite = 0;

    always_comb
    begin
        if(readWrite == 1)
        begin
            if(status_EN)
                cpuData_OUT = STATUS_REGISTER;
            else
                cpuData_OUT = 'bZ;

        end
        else
            cpuData_OUT = 'bZ;

    end


    assign shouldToggleWrite = scroll_EN | ramAddr_EN;

    always_ff@(posedge clk) 
    begin
        prevShouldToggleWrite <= shouldToggleWrite;
        if(prevShouldToggleWrite & !shouldToggleWrite) //time to toggle
            writeToggle <= !writeToggle;
        else if(status_EN && readWrite)
            writeToggle <= 0;

        if(readWrite == 0) //Writing data
        begin
            if(control_EN)
                CONTROL_REGISTER <= cpuData_IN;
            if(mask_EN)
                MASK_REGISTER <= cpuData_IN;
            if(scroll_EN)
            begin
                if(writeToggle == 0)
                    SCROLL_W0 <= cpuData_IN;
                else
                    SCROLL_W1 <= cpuData_IN;
            end

            if(ramAddr_EN)
            begin
                if(writeToggle == 0)
                    VRAM_ADDR_W0 <= {1'b0, cpuData_IN[5:0]}
                else
                begin
                    VRAM_ADDR_W1 <= cpuData_IN;
                    videoRamAddress <= tempVideoRamAddress;
                end
            end
        end

        if(incrementX) //combines coarse x with page table select bit and adds
            COARSE_PAGE_X <= COARSE_PAGE_X + 1;

        if(resetX) //copy coarse x and page table select back into the address register
        begin
            videoRamAddress[4:0] <= tempVideoRamAddress[4:0];
            videoRamAddress[10] <= tempVideoRamAddress[10];
        end

        if(incrementY)
        begin
            {COARSE_Y, FINE_Y} <= {COARSE_Y, FINE_Y} + 1;
            if(COARSE_Y == 29)
            begin
                COARSE_Y <= 0;
                PAGE_Y <= !PAGE_Y;
            end
        end

        if(resetY)
        begin
            PAGE_Y <= tempVideoRamAddress[11];
            FINE_Y <= tempVideoRamAddress[14:12];
            COARSE_Y <= tempVideoRamAddress[9:5];
        end

        if(oamNextEntry)
        begin
            oamAddress[1:0] <= oamAddress[1:0] + 1;
        end

        if(oamNextObject)
        begin
            oamAddress[7:2] <= oamAddress[7:2] + 1;
        end


    end



endmodule
