module PixelPrioritizer(
    input logic clock,
    input logic clock_EN,
    input logic backgroundDraw_EN,
    input logic spriteDraw_EN,
    input logic [4:0] backgroundPixel,
    input logic [5:0] spritePixel,
    output logic setCollision,
    output logic [4:0] pixel_OUT,
    input logic debugCollisionOff
    );
logic [4:0]maskedBackGroundPixel;
assign maskedBackGroundPixel = backgroundDraw_EN ? backgroundPixel : 0;

logic [5:0]maskedSpritePixel;
assign maskedSpritePixel = spriteDraw_EN ? spritePixel : 0;

always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(maskedBackGroundPixel[1:0] == 0) //Background isn't displaying anything, do the sprite.
            pixel_OUT <= {1'b1, maskedSpritePixel[3:0]};
        else if(maskedSpritePixel[1:0] == 0) //Sprite isn't displaying anything, do the background.
            pixel_OUT <= maskedBackGroundPixel;
        else    //Both are trying to display, must determine priority.
        begin
            if(maskedSpritePixel[4] == 0) //sprite in front of background
                pixel_OUT <= {1'b1, maskedSpritePixel[3:0]};
            else                    //sprite behind background
                pixel_OUT <= maskedBackGroundPixel;
        end

        

    end
end

always_comb
begin
    if(maskedBackGroundPixel[1:0] != 0 && maskedSpritePixel[1:0] != 0 && maskedSpritePixel[5] && !debugCollisionOff && clock == 0) //collision happened with sprite 0
            setCollision = 1;
        else
            setCollision = 0;
end

endmodule // PixelPrioritizer

