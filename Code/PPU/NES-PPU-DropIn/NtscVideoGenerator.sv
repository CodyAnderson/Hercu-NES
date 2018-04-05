`define MAX_WHITE ('b1010_1000)
`define NEUTRAL ('b0010_1110)
`define COLORBURST_LOW (`NEUTRAL - 'b10111)
`define COLORBURST_HIGH (`NEUTRAL + 'b10111)
`define SYNC (8'b0)


module NtscVideoGenerator(
    input logic clock, // doubled clock
    input logic luminance_EN,
    input logic chrominance_EN,
    input logic sync_EN,
    input logic colorBurst_EN,
    input logic [2:0]emphasis,
    input logic [5:0]pixelColour,
    output logic [7:0] videoOut
    );
// These values sourced from NES Dev Wiki, may need correction at some point
logic [7:0] daHighLevels[8]; //00,10,20,30, Attenuated
assign daHighLevels[0] = `MAX_WHITE * 616/1100; //00
assign daHighLevels[1] = `MAX_WHITE * 840/1100; //10
assign daHighLevels[2] = `MAX_WHITE           ; //20
assign daHighLevels[3] = `MAX_WHITE           ; //30
assign daHighLevels[4] = `MAX_WHITE * 500/1100; //00 Att
assign daHighLevels[5] = `MAX_WHITE * 676/1100; //10 Att
assign daHighLevels[6] = `MAX_WHITE * 896/1100; //20 Att
assign daHighLevels[7] = `MAX_WHITE * 896/1100; //30 Att

logic [7:0] daLowLevels[8]; //0d, 1d, 2d, 3d, Attenuated
assign daLowLevels[0] = `MAX_WHITE * 228/1100; //0d
assign daLowLevels[1] = `MAX_WHITE * 312/1100; //1d
assign daLowLevels[2] = `MAX_WHITE * 552/1100; //2d
assign daLowLevels[3] = `MAX_WHITE * 880/1100; //3d
assign daLowLevels[4] = `MAX_WHITE * 192/1100; //0d Att
assign daLowLevels[5] = `MAX_WHITE * 256/1100; //1d Att
assign daLowLevels[6] = `MAX_WHITE * 448/1100; //2d Att
assign daLowLevels[7] = `MAX_WHITE * 721/1100; //3d Att


logic [5:0]crappyColorBurstReg = 0;
logic [11:0]crappyColorBurst;
assign crappyColorBurst[5:0] = crappyColorBurstReg;
assign crappyColorBurst[11:6] = ~crappyColorBurstReg;
logic everyOther = 0;
always_ff@(posedge clock)
begin
    everyOther <= !everyOther;
    if(everyOther)
    begin
        crappyColorBurstReg[1] <= crappyColorBurstReg[3];
        crappyColorBurstReg[3] <= crappyColorBurstReg[5];
        crappyColorBurstReg[5] <= !crappyColorBurstReg[1];
    end
    else
    begin
        for(integer i = 0; i < 3; ++i)
        begin
                crappyColorBurstReg[2*i] <= crappyColorBurstReg[2*i+1];
        end
    end
end

/*always_ff@(negedge clock)
begin
    for(integer i = 0; i < 3; ++i)
    begin
            crappyColorBurstReg[2*i] <= crappyColorBurstReg[2*i+1];
    end
end*/

wire attenuationEnable;

assign attenuationEnable = chrominance_EN & ((emphasis[2] & crappyColorBurst[7]) | 
                           (emphasis[1] & crappyColorBurst[3]) | 
                           (emphasis[0] & crappyColorBurst[11]));

logic [7:0]selectedColour;
always_comb
begin
    if(((!chrominance_EN) | pixelColour[3:0] == 0 | crappyColorBurst[pixelColour[3:0]-1]) & pixelColour[3:0] != 4'hD)
        selectedColour = daHighLevels[{attenuationEnable, pixelColour[5:4]}];
    else
        selectedColour = daLowLevels[{attenuationEnable, pixelColour[5:4]}];
end


always_comb
begin
    if(sync_EN)
        videoOut = `SYNC;

    else if(colorBurst_EN)
    begin
        if(crappyColorBurst[7])
            videoOut = `COLORBURST_HIGH;
        else
            videoOut = `COLORBURST_LOW;
    end

    else if(!luminance_EN)
        videoOut = daLowLevels[1]; //Black

    else if(pixelColour[3:1] == 3'b111) //E or F
        videoOut = daLowLevels[1]; //Black

    else
        videoOut = selectedColour;
end

endmodule // NtscVideoGenerator