module RenderController(
    input logic clock, //PPU clock/3
    input logic clock_EN,
    input logic background_EN,
    input logic sprite_EN,
    input logic greyscale_EN,
    output logic backgroundFetch_EN,
    output logic spriteEval_EN,
    output logic spriteEvalReset,
    output logic spriteFetch_EN,
    output logic dummyFetch_EN,
    output logic pixelShifty_EN,
    output logic luminance_EN,
    output logic chrominance_EN,
    output logic sync_EN,
    output logic colorBurst_EN,
    output logic incrementX,
    output logic incrementY,
    output logic resetX,
    output logic resetY,
    output logic idle,
    output logic setVBlank,
    output logic clearVBlank,
    output logic [8:0]lineCount
     );

    logic [9:0] xPos = 0;
    logic [8:0] yPos = 0;
    logic renderingOn;
    assign renderingOn = sprite_EN || background_EN;
    assign lineCount = yPos;
    logic oddFrame = 0;
    always @(posedge clock) begin
        if(clock_EN)
        begin
            if (xPos == 340) begin
                xPos <= 0;

                if (yPos == 261)
                begin
                    if(oddFrame && renderingOn)
                        xPos <= 1;
                    yPos <= 0;
                    oddFrame <= !oddFrame;
                end
                else
                    yPos <= yPos + 1;
            end else
                xPos <= xPos + 1;
        end
    end

logic hSync;
assign hSync = xPos >= 280 && xPos < 305;
logic vSync;
assign vSync = yPos >= 245 && yPos <= 247;

always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        clearVBlank <= xPos == 1 && yPos == 261;
        setVBlank <= xPos == 1 && yPos == 241;
        incrementX <= renderingOn & ((xPos % 8 == 0 && xPos != 0 && xPos < 257 && (yPos < 240 || yPos == 261)) | xPos == 328 | xPos == 336);
        incrementY <= renderingOn & (xPos == 256 && (yPos < 240 || yPos == 261));
        
        resetX <= renderingOn & (xPos == 257 && (yPos < 240 || yPos == 261));
        resetY <= renderingOn & (yPos == 261 && (xPos > 279 && xPos < 305));

        backgroundFetch_EN <= renderingOn && (xPos < 257 || xPos > 320) && xPos != 0 && (yPos < 240 || yPos == 261);
        spriteFetch_EN <= renderingOn && xPos > 256 && xPos < 321 && (yPos < 240 || yPos == 261);
        spriteEvalReset <= renderingOn && xPos == 340 && (yPos < 240 || yPos == 261);
        spriteEval_EN <= renderingOn && xPos != 0 && xPos <= 256 && yPos < 240;



        dummyFetch_EN <= renderingOn && xPos > 336;
        idle <= xPos == 0;
        pixelShifty_EN <= renderingOn && xPos > 0 && xPos < 257;

        
        sync_EN <= hSync || vSync;

        colorBurst_EN <= xPos > 308 && xPos < 308+16 && !sync_EN;
        luminance_EN <= yPos < 240 && (xPos >= 329 || xPos < 260+11);
        chrominance_EN <= !greyscale_EN && yPos < 240 && (xPos >= 330 || xPos < 260+11);
    end
end

    /*
    assign clearVBlank = xPos == 1 && yPos == 261;
    assign setVBlank = xPos == 1 && yPos == 241;
    assign incrementX = background_EN & ((xPos % 8 == 0 && xPos != 0 && xPos < 257 && (yPos < 240 || yPos == 261)) | xPos == 328 | xPos == 336);
    assign incrementY = background_EN & (xPos == 256 && (yPos < 240 || yPos == 261));
    
    assign resetX = background_EN & (xPos == 257 && (yPos < 240 || yPos == 261));
    assign resetY = background_EN & (yPos == 261 && (xPos > 279 && xPos < 305));

    assign backgroundFetch_EN = background_EN && (xPos < 257 || xPos > 320) && xPos != 0 && (yPos < 240 || yPos == 261);
    assign spriteFetch_EN = sprite_EN && xPos > 256 && xPos < 321 && (yPos < 240 || yPos == 261);
    assign dummyFetch_EN = background_EN && xPos > 336;
    assign idle = xPos == 0;
    assign pixelShifty_EN = xPos > 0 && xPos < 257;

    logic hSync;
    assign hSync = xPos >= 280 && xPos < 305;
    logic vSync;
    assign vSync = yPos >= 245 && yPos <= 247;
    assign sync_EN = hSync || vSync;

    assign colorBurst_EN = xPos > 308 && xPos < 308+16 && !sync_EN;
    assign luminance_EN = yPos < 240 && (xPos >= 329 || xPos < 260+11);
    assign chrominance_EN = !greyscale_EN && yPos < 240 && (xPos >= 330 || xPos < 260+11);
    */



endmodule // RenderController