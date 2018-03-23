module SpriteHandler(
    input logic clock,
    input logic clock_EN,
    input logic spriteFetch_EN,
    input logic spriteEval_EN,
    input logic spriteEvalReset,
    input logic drawTime,
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
    output logic spriteCollision = 0,
    output logic [11:0]spriteAddress_OUT
    );

logic [7:0] spriteYPos;
logic [7:0] spriteTileIndex;
logic [7:0] spriteAttribute;
always_comb
begin
    logic[3:0] fineYspritePos;
    if(spriteAttribute[7]) //If the tile is flipped vertically
    begin
        fineYspritePos = 15 - (yPosition - spritePos);
    end
    else
        fineYspritePos = yPosition - spritePos;

    if(tallSprites)
        spriteAddress_OUT = {spriteTileIndex[0], spriteTileIndex[7:1], fineYspritePos};
    else
        spriteAddress_OUT = {spritePatternTableAddress, spriteTileIndex, fineYspritePos[2:0]};
end



logic [4:0] secondaryAddress = 0;
logic [7:0] dataToPrimary;
logic [7:0] dataFromPrimary;
logic writeSecondary = 0;
logic [7:0] dataToSecondary;
logic [7:0] dataFromSecondary;
logic [7:0] dataReg;
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
            secondaryAddress <= 0;
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
                    secondaryAddress <= secondaryAddress + 1;
                    if(secondaryAddress == 'b11111)
                        stage <= stage + 1;
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

                        if(secondaryAddress[1:0] || drawSprite) //If this sprite exists on this line, increment address
                        begin
                            if(evalDone == 0)
                                secondaryAddress <= secondaryAddress + 1;

                            if(firstSprite)
                                possiblySpriteCollisionNextLine <= 1; //Evaluation takes place one line before it gets rendered

                            if(secondaryAddress == 'b11111) //If sprite memory is full, set the flag
                            begin
                                secondaryOamFull <= 1;
                                evalDone <= 1;
                            end
                        end
                    end
                end // 1:
            endcase // stage
            
            if(spriteFetch_EN)
            begin
                case(fetchingCounter)
                    0:begin
                        spriteYPos <= dataFromSecondary;
                        secondaryAddress <= secondaryAddress + 1;
                    end
                    1:begin
                        spriteTileIndex <= dataFromSecondary;
                        secondaryAddress <= secondaryAddress + 1;
                    end
                    2:begin
                        spriteAttribute <= dataFromSecondary;
                        spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b00}] <= dataFromSecondary;
                        spriteDrawCounter <= spriteDrawCounter + 1;
                        secondaryAddress <= secondaryAddress + 1;
                    end
                    3:begin
                        spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b01}] <= dataFromSecondary;
                        spriteDrawCounter <= spriteDrawCounter + 1;
                        secondaryAddress <= secondaryAddress + 1;
                    end
                    //4 waiting for ram read
                    5:begin
                        spriteDrawCounter <= spriteDrawCounter + 1;
                        if(spriteAttribute[6]) //need to flip data bits
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
                        if(spriteAttribute[6]) //need to flip data bits
                        begin
                            for(integer i = 0; i < 8; i = i + 1)
                                spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b11}][i] <= vRamData[7-i];
                        end
                        else
                            spriteDrawingFlippyFloppies[{spriteDrawCounter,2'b11}] <= vRamData;
                    end


            end
        end

        if(pixelShifty_EN)
            for(integer i = 0; i < 8; i=i+1)
            begin
                

    end
end






