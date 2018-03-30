module SpriteHandler(
    input logic clock,
    input logic clock_EN,
    input logic spriteFetch_EN,
    input logic spriteEval_EN,
    input logic cpuComm_EN,
    input logic cpuRW,
    input logic[7:0] cpuData_IN,
    output logic[7:0] cpuData_OUT,
    input logic spriteEvalReset,
    input logic resetFlags,
    input logic tallSprites,
    input logic pixelShifty_EN,
    input logic spritePatternTableAddress,
    input logic [7:0]primaryAddress,
    input logic [8:0]yPosition,
    input logic [7:0]vRamData,
    output logic oamNextAttr,
    output logic oamNextEntry,
    output logic spriteOverflow = 0,
    output logic [11:0]spriteAddress_OUT,
    output logic [5:0]spritePixel_OUT
    );

logic [7:0] spriteYPos;
logic [7:0] spriteTileIndex;
logic [7:0] spriteAttribute;
always_comb //handles mapping the sprite information and current line to a sprite address
begin
    logic[3:0] fineYspritePos;
    if(spriteAttribute[7]) //If the tile is flipped vertically
    begin
        fineYspritePos = 15 - (yPosition - spriteYPos);
    end
    else
        fineYspritePos = yPosition - spriteYPos;

    if(tallSprites)
        spriteAddress_OUT = {spriteTileIndex[0], spriteTileIndex[7:1], fineYspritePos};
    else
        spriteAddress_OUT = {spritePatternTableAddress, spriteTileIndex, fineYspritePos[2:0]};
end




logic primaryWrite;
logic [7:0] dataToPrimary;
logic [7:0] dataFromPrimary;
ObjectAttributeMemory OAM(
    clock,
    clock_EN,
    primaryWrite,
    primaryAddress,
    dataToPrimary,
    dataFromPrimary
);
//assign (weak1, strong0) cpuData_OUT = cpuComm_EN ? dataFromPrimary : 8'hZZ;
assign cpuData_OUT = 8'hzz;
always_comb // handles the cpu reading and writing OAM data
begin
    if(cpuComm_EN)
    begin
        dataToPrimary = cpuData_IN;
    end
    else
    begin
        dataToPrimary = 'bx;
    end
    if(cpuComm_EN && cpuRW == 0)
        primaryWrite = 1;
    else
        primaryWrite = 0;
end

logic [4:0] secondaryAddress;
logic [4:0] stageOneSecondaryAddress = 0;
logic [4:0] stageTwoSecondaryAddress = 0;
assign secondaryAddress = spriteFetch_EN ? stageTwoSecondaryAddress : stageOneSecondaryAddress;
logic writeSecondary = 0;
logic [7:0] dataToSecondary;
logic [7:0] dataFromSecondary;
ObjectAttributeMemorySecondary OAM_Secondary(
    clock,
    clock_EN,
    writeSecondary,
    secondaryAddress,
    dataToSecondary,
    dataFromSecondary
);



logic [7:0] dataReg;
assign dataToSecondary = stage == 0 ? 'hFF : dataReg;
logic [12:0] stage = 0;
logic evenCycle = 0;
logic secondaryOamFull = 0;
logic [1:0]miniStage = 0;
logic firstSprite = 0;
logic evalDone = 0;
logic possiblySpriteCollisionNextLine = 0;
logic possiblySpriteCollisionThisLine = 0;
logic drawSprite;
assign drawSprite = dataReg <= yPosition && (dataReg+(8 << tallSprites) >= yPosition);


logic [2:0] spriteDrawCounter = 0;
    //Contains attribute, x-coordinate, tile low byte, and tile high byte for eight sprites
logic [7:0] spriteDrawingFlippyFloppies[4*8];

logic [2:0] fetchingCounter = 0;
always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(spriteFetch_EN)
            fetchingCounter <= fetchingCounter + 1;
        else
            fetchingCounter <= 0;
    end
end

always_comb
begin
    oamNextAttr = 0;
    oamNextEntry = 0;
    if(spriteEval_EN && stage == 1 && evenCycle)
    begin
        if(secondaryOamFull == 1) //Adding in bugs!!
        begin
            oamNextAttr = 1;
        end
        if(secondaryAddress[1:0] || drawSprite)  //If this sprite exists on this line, increment respective counters.
        begin
            oamNextAttr = 1;
            if(secondaryAddress[1:0] == 'b11)
                oamNextEntry = 1;
        end
        else // If the sprite doesn't exist, move on to the next sprite.
        begin
            oamNextEntry = 1;
        end
    end
end

always_latch
begin
    if(resetFlags)
        spriteOverflow <= 0;
    else if(evenCycle == 1 && drawSprite && secondaryOamFull)
        spriteOverflow <= 1;
end


always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(spriteEvalReset)
        begin
            possiblySpriteCollisionThisLine <= possiblySpriteCollisionNextLine;
            stageOneSecondaryAddress <= 0;
            stageTwoSecondaryAddress <= 0;
            evalDone <= 0;
            stage <= 0;
            secondaryOamFull <= 0;
            firstSprite <= 1;
            evenCycle <= 0;
            spriteDrawCounter <= 0;
        end

        if(spriteEval_EN)
        begin
            case(stage)
                0: begin //Initialize Secondary OAM
                    possiblySpriteCollisionNextLine <= 0;
                    stageOneSecondaryAddress <= stageOneSecondaryAddress + 1;
                    writeSecondary <= 1;
                    if(stageOneSecondaryAddress == 'b11111)
                    begin
                        stage <= stage + 1;
                        writeSecondary <= 0;
                    end
                end
                1: begin //Search for sprites to be drawn on the next line
                    evenCycle <= !evenCycle;
                    if(evenCycle == 0) // Read data from primary OAM
                    begin
                        dataReg <= dataFromPrimary;
                        if(evalDone == 0)
                            writeSecondary <= 1;
                    end
                    else
                    begin
                        firstSprite <= 0;
                        if(writeSecondary == 0) //Read from secondary instead of writing
                        begin
                            dataReg <= dataFromSecondary;
                        end
                        else
                            writeSecondary <= 0;

                        if(stageOneSecondaryAddress[1:0] || drawSprite) //If this sprite exists on this line, increment address
                        begin
                            if(evalDone == 0)
                                stageOneSecondaryAddress <= stageOneSecondaryAddress + 1;

                            if(firstSprite)
                                possiblySpriteCollisionNextLine <= 1; //Evaluation takes place one line before it gets rendered

                            if(stageOneSecondaryAddress == 'b11111) //If sprite memory is full, set the flag
                            begin
                                secondaryOamFull <= 1;
                                evalDone <= 1;
                            end
                        end
                    end
                end // 1:
            endcase // stage
        end
        if(spriteFetch_EN)
        begin
            case(fetchingCounter)
                0:begin //ypos
                    spriteYPos <= dataFromSecondary;
                    stageTwoSecondaryAddress <= stageTwoSecondaryAddress + 1;
                end
                1:begin //tile index
                    spriteTileIndex <= dataFromSecondary;
                    stageTwoSecondaryAddress <= stageTwoSecondaryAddress + 1;
                end
                2:begin //tile attributes
                    spriteAttribute <= dataFromSecondary;
                    spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b00}] <= dataFromSecondary;
                    //spriteDrawCounter <= spriteDrawCounter + 1;
                    stageTwoSecondaryAddress <= stageTwoSecondaryAddress + 1;
                end
                3:begin //xpos
                    spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b01}] <= dataFromSecondary;
                    //spriteDrawCounter <= spriteDrawCounter + 1;
                    stageTwoSecondaryAddress <= stageTwoSecondaryAddress + 1;
                end
                //4 waiting for ram read
                5:begin
                    //spriteDrawCounter <= spriteDrawCounter + 1;
                    if(spriteAttribute[6] == 0) //need to flip data bits
                    begin
                        for(integer i = 0; i < 8; i = i + 1)
                            spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b10}][i] <= vRamData[7-i];
                    end
                    else
                        spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b10}] <= vRamData;

                end
                //6 waiting for ram read
                7:begin
                    spriteDrawCounter <= spriteDrawCounter + 1;
                    if(spriteAttribute[6] == 0) //need to flip data bits
                    begin
                        for(integer i = 0; i < 8; i = i + 1)
                            spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b11}][i] <= vRamData[7-i];
                    end
                    else
                        spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b11}] <= vRamData;
                end

            endcase
        end

        if(pixelShifty_EN)
        begin
            automatic logic [1:0]spriteDats[8];
            automatic logic priorityBit = 0;
            automatic logic spriteCollison = 0;
            automatic logic [5:0]spritePixel = 0;

            for(logic[3:0] i = 0; i < 8; i=i+1)
            begin
                if(spriteDrawingFlippyFloppies[{i[2:0], 2'b01}] > 0) //Count down the position of each sprite until zero (time to draw it)
                begin
                    spriteDrawingFlippyFloppies[{i[2:0], 2'b01}] <= spriteDrawingFlippyFloppies[{i[2:0], 2'b01}] - 1;
                    spriteDats[i[2:0]] = 0;
                end
                else //Drawing sprites works by bit shifting the high and low bits out
                begin
                    spriteDats[i] = {spriteDrawingFlippyFloppies[{i[2:0], 2'b10}][0], spriteDrawingFlippyFloppies[{i[2:0], 2'b11}][0]};
                    spriteDrawingFlippyFloppies[{i[2:0], 2'b11}] <= spriteDrawingFlippyFloppies[{i[2:0], 2'b11}] >> 1;
                    spriteDrawingFlippyFloppies[{i[2:0], 2'b10}] <= spriteDrawingFlippyFloppies[{i[2:0], 2'b10}] >> 1;
                end
            end
            
            for(logic[3:0] i = 0; i < 8; i=i+1)
            begin
                if(spriteDats[i] && priorityBit == 0) //got the highest priority sprite
                begin
                    if(i == 0 && possiblySpriteCollisionThisLine)
                        spriteCollison = 1;
                    priorityBit = 1;
                    spritePixel[1:0] = spriteDats[i[2:0]];
                    spritePixel[3:2] = spriteDrawingFlippyFloppies[{i[2:0], 2'b11}][1:0];
                    spritePixel[4] = spriteDrawingFlippyFloppies[{i[2:0], 2'b11}][5];
                    spritePixel[5] = spriteCollison;
                end
            end
            spritePixel_OUT <= spritePixel;
        end
    end
end





endmodule // SpriteHandler
