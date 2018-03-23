`define NEUTRAL_LEVEL ('b101110)
`define MAX_WHITE ('b10101000 - NEUTRAL_LEVEL)
`define COLOR_BURST_AMPLITUDE ('b101110)
`define MAX_SATURATION_AMPLITUDE ('b110 * 16)



module RP2C02G (
    input logic PLUS_5V,
    input logic [7:0]CPU_D,
    input logic [2:0]CPU_A,
    input logic RW,
    input logic CS,
    input logic [3:0]EXT,
    input logic INT,
    input logic ALE,
    input logic [13:0]PPU_AD,
    input logic RD,
    input logic WR,
    input logic RST,
    input logic EXT_CLOCK,
    input logic CLK,
    input logic [9:0]SW,
    output logic [7:0]VOUT,
    output logic [9:0]LEDR,
    output logic [29:29]GPIO_1
);

logic newclock;
logic doubleClock;
assign GPIO_1[29] = CLK;
//assign newclock = CLK;
pll makemorebuffer(
    EXT_CLOCK,
    newclock,
    doubleClock);
logic hsync;
logic vsync;
logic active;
logic oddFrame;
reg [3:0] count;
wire clk10 = count[2];

logic [11:0]crappyColorBurst = 0;
assign crappyColorBurst[11:6] = ~crappyColorBurst[5:0];
logic [2:0]evenColorCounter;
always_ff@(posedge newclock)
begin

    crappyColorBurst[1] <= crappyColorBurst[3];
    crappyColorBurst[3] <= crappyColorBurst[5];
    crappyColorBurst[5] <= !crappyColorBurst[1];
end

always_ff@(negedge newclock)
begin
    for(integer i = 0; i < 3; ++i)
    begin
            crappyColorBurst[2*i] <= crappyColorBurst[2*i+1];
    end
end


always @(posedge newclock) begin
    if (count == 3)
        count <= 0;
    else
        count <= count + 1;
end

reg [9:0] xpos;
reg [8:0] ypos;
logic [6:0] frames;
always @(posedge newclock) begin
    if(count == 0)
    begin
    if (xpos == 341) begin
        xpos <= 0;
        if (ypos == 261)
        begin
            //if(oddFrame)
                //xpos <= 1;
            ypos <= 0;
            oddFrame <= !oddFrame;
            frames <= frames + 1;
        end
        else
            ypos <= ypos + 1;
    end else
        xpos <= xpos + 1;
    end
end

always_comb
begin
    if(xpos >= 280 && xpos < 305)
        hsync = 1;
    else 
        hsync = 0;

    if(ypos >= 245 && ypos <= 247)
        vsync = 1;
    else
        vsync = 0;
    if(ypos < 240 && (xpos >= 330 || xpos < 260+11))
        active = 1;
    else
        active = 0;
end

logic colorBurst;
assign colorBurst = !vsync & (xpos >= 309 && xpos < 309+14);

logic [6:0] brightness;
assign brightness = (ypos+xpos+frames)%127;//SW[2:0];
logic [5:0] saturation;
assign saturation = (ypos/2)%64; //(ypos/16)%8;
logic [3:0] hue;
assign hue = (xpos/16+frames/5) % 12;//SW[9:6];
logic [7:0] pixelValue;
assign pixelValue = active ? ((crappyColorBurst[hue] ? brightness + saturation : brightness - saturation)) : 0;
//assign GPIO_1[4:1] = ({active,active,active,active} & pixelValue) | {2'b0,colorBurst & crappyColorBurst[0],1'b0};
//assign GPIO_1[0] = !(hsync || vsync);
logic sync;
assign sync = !(hsync || vsync);

logic [7:0] neutralPlusBurst;
assign neutralPlusBurst = colorBurst ? (crappyColorBurst[0] ? `NEUTRAL_LEVEL + `COLOR_BURST_AMPLITUDE/2 : `NEUTRAL_LEVEL - `COLOR_BURST_AMPLITUDE/2) : `NEUTRAL_LEVEL;

assign VOUT = SW[8] ? SW[7:0] : sync ? pixelValue + neutralPlusBurst : 0;


endmodule