module PixelPrioritizer(
    input logic clock,
    input logic clock_EN,
    input logic [4:0] backgroundPixel,
    input logic [5:0] spritePixel,
    output logic setCollision,
    output logic [4:0] pixel_OUT
    );
//assign pixel_OUT = backgroundPixel;
always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(backgroundPixel[1:0] == 0) //Background isn't displaying anything, do the sprite.
            pixel_OUT <= {1'b1, spritePixel[3:0]};
        else if(spritePixel[1:0] == 0) //Sprite isn't displaying anything, do the background.
            pixel_OUT <= backgroundPixel;
        else    //Both are trying to display, must determine priority.
        begin
            if(spritePixel[4] == 0) //sprite in front of background
                pixel_OUT <= {1'b1, spritePixel[3:0]};
            else                    //sprite behind background
                pixel_OUT <= backgroundPixel;
        end

        if(backgroundPixel[1:0] != 0 && spritePixel[1:0] != 0 && spritePixel[5]) //collision happened with sprite 0
            setCollision <= 1;
        else
            setCollision <= 0;

    end
end

endmodule // PixelPrioritizer

