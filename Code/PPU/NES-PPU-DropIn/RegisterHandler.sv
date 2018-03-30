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
`define STATUS_REGISTER {verticalBlank,spriteCollision, spriteOverflow, 5'b10000}
`define SCROLL_W0 {tempVideoRamAddress[4:0], fineXScroll}
`define SCROLL_W1 {tempVideoRamAddress[9:5], tempVideoRamAddress[14:12]}
`define VRAM_ADDR_W0 {tempVideoRamAddress[14:8]}
`define VRAM_ADDR_W1 {tempVideoRamAddress[7:0]}
`define COARSE_PAGE_X {videoRamAddress[10], videoRamAddress[4:0]}
`define FINE_Y videoRamAddress[14:12]
`define COARSE_Y videoRamAddress[9:5]
`define PAGE_Y videoRamAddress[11]

module RegisterHandler(
    input logic clk,
    input logic clkEn,
    input logic readWrite,
    input logic control_EN, //0
    input logic mask_EN,    //1
    input logic status_EN,  //2
    input logic oamAddr_EN, //3
    input logic oamData_EN, //4
    input logic scroll_EN,  //5
    input logic ramAddr_EN, //6
    input logic ramData_EN, //7
    
    input logic [7:0]cpuData_IN,
    output logic [7:0]cpuData_OUT,
    input logic spriteOverflow,
    input logic setSpriteCollision,
    input logic setVerticalBlank,
    input logic clearVerticalBlank,
    output logic verticalBlank = 0,
    output logic [7:0]oamAddress = 0,
    output logic [14:0]videoRamAddress = 0,
    input logic incrementX,
    input logic incrementY,
    input logic vramIncrement,
    input logic resetX,
    input logic resetY,
    input logic oamNextEntry,
    input logic oamNextObject,
    input logic oamReset,
    input logic [4:0]palleteSelect,
    output logic [5:0]selectedColour,
    output logic [2:0]fineXScroll = 0,

    //For Control REG
    output logic incrementMode = 0,
    output logic spritePatternTableAddress = 0, //only for 8x8 sprites
    output logic backgroundPatternTableAddress = 0,
    output logic spriteSize = 0,               //0=8x8, 1=8x16
    output logic ppuMasterSlave = 0,           //NOT USED!!
    output logic interrupt_EN = 0,

    //For Mask REG
    output logic greyscale_EN = 0,
    output logic backgroundLeftColumn_EN = 0,
    output logic spriteLeftColumn_EN = 0,
    output logic background_EN = 0,
    output logic sprite_EN = 0,
    output logic [2:0]colorEmphasis = 0
    );
    
    logic [14:0]tempVideoRamAddress = 0;
    

    logic spriteCollision = 0;
    logic writeToggle = 0;
    logic shouldToggleWrite;
    logic prevShouldToggleWrite = 0;
    logic [5:0]colourPalletes[32];
    initial for (integer i = 0; i < 32; i=i+1) colourPalletes[i] = 0;



    //assign cpuData_OUT = readWrite & status_EN ? `STATUS_REGISTER : 'bz;
    always_comb
    begin
        if(readWrite)
        begin
            if(status_EN)
                cpuData_OUT = `STATUS_REGISTER;
            else if(ramData_EN)
            begin
                if(videoRamAddress[1:0] == 0)
                    cpuData_OUT = {2'b0, colourPalletes[0]};
                else 
                    cpuData_OUT = {2'b0, colourPalletes[videoRamAddress[4:0]]};
            end
            else
                cpuData_OUT = 'bZ;
        end
        else
            cpuData_OUT = 'bZ;
    end

    logic oamData_EN_PREV = 0;
    logic shouldIncrementOamAddr = 0;
    logic shouldClearVblank = 0;
    assign shouldToggleWrite = scroll_EN | ramAddr_EN;

    always_ff@(posedge clk) 
    begin
        oamData_EN_PREV <= oamData_EN;
        if(oamData_EN == 0 && oamData_EN_PREV)
            shouldIncrementOamAddr <= 1;

        if(readWrite == 0) //Writing data
        begin
            if(oamAddr_EN)
                oamAddress <= cpuData_IN;
            if(control_EN)
                `CONTROL_REGISTER <= cpuData_IN;
            if(mask_EN)
                `MASK_REGISTER <= cpuData_IN;
            if(scroll_EN)
            begin
                if(writeToggle == 0)
                    `SCROLL_W0 <= cpuData_IN;
                else
                    `SCROLL_W1 <= cpuData_IN;
            end

            if(ramAddr_EN)
            begin
                if(writeToggle == 0)
                    `VRAM_ADDR_W0 <= {1'b0, cpuData_IN[5:0]};
                else
                begin
                    `VRAM_ADDR_W1 <= cpuData_IN;
                    videoRamAddress <= cpuData_IN;
                    videoRamAddress[14:8] <= tempVideoRamAddress[14:8];
                end
            end
            if(ramData_EN & videoRamAddress >= 'h3f00)
            begin
                if(videoRamAddress[1:0] == 0)
                    colourPalletes[0] <= cpuData_IN[5:0];
                else 
                    colourPalletes[videoRamAddress[4:0]] <= cpuData_IN[5:0];
            end
        end

        if(clkEn)
        begin
            prevShouldToggleWrite <= shouldToggleWrite;
            if(prevShouldToggleWrite & !shouldToggleWrite) //toggles the lsb msb selector
                writeToggle <= !writeToggle;
            else if(status_EN && readWrite)
                writeToggle <= 0;

                //Maps the first colour of every pallete to the background colour.
            selectedColour <= palleteSelect[1:0] == 0 ? colourPalletes[0] : colourPalletes[palleteSelect];

            


            if(readWrite == 1 && status_EN == 1)
            begin
                shouldClearVblank <= 1;
            end

            if((status_EN == 0 && shouldClearVblank == 1) || clearVerticalBlank == 1)
            begin
                shouldClearVblank <= 0;
                verticalBlank <= 0;
            end

            if(clearVerticalBlank)
            begin
                spriteCollision <= 0;
            end

            if(setSpriteCollision == 1)
                spriteCollision <= 1;

            if(setVerticalBlank)
            begin
                verticalBlank <= 1;
            end

            if(vramIncrement)
            begin
                if(incrementMode)
                    videoRamAddress <= videoRamAddress + 32;
                else
                    videoRamAddress <= videoRamAddress + 1;
            end

            if(incrementX) //combines coarse x with page table select bit and adds
                `COARSE_PAGE_X <= `COARSE_PAGE_X + 1;

            if(resetX) //copy coarse x and page table select back into the address register
            begin
                videoRamAddress[4:0] <= tempVideoRamAddress[4:0];
                videoRamAddress[10] <= tempVideoRamAddress[10];
            end

            if(incrementY)
            begin
                {`COARSE_Y, `FINE_Y} <= {`COARSE_Y, `FINE_Y} + 1;
                if(`COARSE_Y == 29)
                begin
                    `COARSE_Y <= 0;
                    `PAGE_Y <= !`PAGE_Y;
                end
            end

            if(resetY)
            begin
                `PAGE_Y <= tempVideoRamAddress[11];
                `FINE_Y <= tempVideoRamAddress[14:12];
                `COARSE_Y <= tempVideoRamAddress[9:5];
            end
            if(oamReset)
                oamAddress <= 0;
            if(oamNextEntry || shouldIncrementOamAddr)
            begin
                oamAddress[1:0] <= oamAddress[1:0] + 1;
                shouldIncrementOamAddr <= 0;
            end

            if(oamNextObject || ((oamNextEntry || shouldIncrementOamAddr) && oamAddress[1:0] == 2'b11))
            begin
                oamAddress[7:2] <= oamAddress[7:2] + 1;
            end
        end

    end



endmodule
