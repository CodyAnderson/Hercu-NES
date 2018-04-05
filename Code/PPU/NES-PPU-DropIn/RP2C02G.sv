//`define SIMULATING
`define NOT_SIMULATING

module RP2C02G (
      /////////////
     // Chip Stuff
    /////////////
    input RW,
    inout [7:0]CPU_D,
    input [2:0]CPU_A,
    input CS,
    inout [3:0]EXT,
    input CLK,
    output INT,
    input PLUS_5V,
    output ALE,
    inout [13:0]PPU_AD,
    output RD,
    output WR,
    input RST,
    output [7:0]VOUT,
    `ifdef NOT_SIMULATING
    output logic [29:29]GPIO_1,
    input logic EXT_CLOCK,
    `endif

      //////////////
     // Debug Stuff
    //////////////

    input [9:0]SW,
    output [9:0]LEDR,
    output [7:0]LEDG
    `ifdef NOT_SIMULATING,
    output [3:0]VGA_B,
    output [3:0]VGA_G,
    output [3:0]VGA_R,
    output VGA_HS,
    output VGA_VS,
    output [6:0]HEX0,
    output [6:0]HEX1,
    output [6:0]HEX2,
    output [6:0]HEX3
    `endif
);
  logic [14:0]videoRamAddress;
  `ifdef NOT_SIMULATING
SevenSeg seg0(videoRamAddress[3:0], HEX0);
SevenSeg seg1(videoRamAddress[7:4], HEX1);
SevenSeg seg2(videoRamAddress[12:8], HEX2);
SevenSeg seg3(videoRamAddress[14:13], HEX3);
`endif


logic noOutput;
assign noOutput = !PLUS_5V || !RST;
logic interrupt;
assign INT = noOutput ? 'bZ : interrupt;
logic memRead;
assign RD = noOutput ? 'bZ : memRead;
logic memWrite;
assign WR = noOutput ? 'bZ : memWrite;
logic memLatch;
assign ALE = noOutput ? 'bZ : memLatch;
logic [7:0]videoOut;
assign VOUT = noOutput ? 'bZ : videoOut;



logic doubleClock;
logic bufferedClock;
logic vgaClock;
`ifdef SIMULATING
assign bufferedClock = CLK;
`endif
`ifdef NOT_SIMULATING
assign GPIO_1[29] = CLK;
pll makemorebuffer(
    EXT_CLOCK,
    bufferedClock,
    doubleClock,
    vgaClock);
`endif
logic oneHalfClock = 0;
logic oneQuarterClock = 0;
logic [1:0]clockCount = 0;
always_ff@(posedge bufferedClock)
begin
  if(oneHalfClock == 0)
    oneQuarterClock <= !oneQuarterClock;
  oneHalfClock <= !oneHalfClock;
  clockCount <= clockCount + 1;
end

  wire[7:0] dataFromComponents; //Data internal input
  wire[7:0] dataFromRegisters; 
  wire[7:0] dataFromMemory;
  wire[7:0] dataToComponents; //Data internal output
  
  logic control_EN; //0
  logic mask_EN;    //1
  logic status_EN;  //2
  logic oamAddr_EN; //3
  logic oamData_EN; //4
  logic scroll_EN;  //5
  logic ramAddr_EN; //6
  logic ramData_EN; //7

  logic rwBuffered;

CpuCommunicator ExternalCommute(
  bufferedClock,
  CPU_A,

  CPU_D, //Data external inoutput
  
  RW,
  rwBuffered,
  CS,

  dataFromComponents, //Data internal input
  dataToComponents, //Data internal output
  
  control_EN, //0
  mask_EN,    //1
  status_EN,  //2
  oamAddr_EN, //3
  oamData_EN, //4
  scroll_EN,  //5
  ramAddr_EN, //6
  ramData_EN  //7
  
);

  logic spriteOverflow;
  logic setSpriteCollision;
  logic setVerticalBlank;
  logic clearVerticalBlank;
  logic verticalBlank;
  logic [7:0]oamAddress;

  logic incrementX;
  logic incrementY;
  logic vramIncrement;
  logic resetX;
  logic resetY;
  logic oamNextAttr;
  logic oamNextEntry;
  logic [4:0]palleteSelect;
  logic [5:0]selectedColour;
  logic [2:0]fineXScroll;


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
  logic spriteFetch_EN;

assign interrupt = !(interrupt_EN & verticalBlank);
assign dataFromComponents = ramData_EN & videoRamAddress < 'h3f00 ? dataFromMemory : dataFromRegisters;
RegisterHandler HandlesRegs(
    bufferedClock, //nes/4
    clockCount == 3,
    rwBuffered,
    control_EN, //0
    mask_EN,    //1
    status_EN,  //2
    oamAddr_EN, //3
    oamData_EN, //4
    scroll_EN,  //5
    ramAddr_EN, //6
    ramData_EN, //7
    
    dataToComponents,
    dataFromRegisters,
    spriteOverflow,
    setSpriteCollision,
    setVerticalBlank,
    clearVerticalBlank,
    verticalBlank,
    oamAddress,
    videoRamAddress,
    incrementX,
    incrementY,
    vramIncrement,
    resetX,
    resetY,
    oamNextAttr,
    oamNextEntry,
    spriteFetch_EN,
    palleteSelect,
    selectedColour,
    fineXScroll,


    //For Control REG
    incrementMode,
    spritePatternTableAddress, //only for 8x8 sprites
    backgroundPatternTableAddress,
    spriteSize,               //0=8x8, 1=8x16
    ppuMasterSlave,           //NOT USED!!
    interrupt_EN,

    //For Mask REG
    greyscale_EN,
    backgroundLeftColumn_EN,
    spriteLeftColumn_EN,
    background_EN,
    sprite_EN,
    colorEmphasis
    );

    logic backgroundFetch_EN;
    
    logic spriteEval_EN;
    logic spriteEvalReset;
    logic dummyFetch_EN;
    logic backgroundPixelShifty_EN;
    logic spritePixelShifty_EN;
    logic vgaPixelOut_EN;
    logic spriteDraw_EN;
    logic backgroundDraw_EN;
    logic luminance_EN;
    logic chrominance_EN;
    logic sync_EN;
    logic colorBurst_EN;
    logic idle;
    logic vSync;
    logic [8:0]lineCount;

RenderController ControlDaRender(
    bufferedClock, //nes/4
    clockCount == 3,
    background_EN,
    sprite_EN,
    backgroundLeftColumn_EN,
    spriteLeftColumn_EN,
    greyscale_EN,
    backgroundFetch_EN,
    spriteEval_EN,
    spriteEvalReset,
    spriteFetch_EN,
    dummyFetch_EN,
    backgroundPixelShifty_EN,
    spritePixelShifty_EN,
    vgaPixelOut_EN,
    spriteDraw_EN,
    backgroundDraw_EN,
    luminance_EN,
    chrominance_EN,
    sync_EN,
    colorBurst_EN,
    incrementX,
    incrementY,
    resetX,
    resetY,
    idle,
    setVerticalBlank,
    clearVerticalBlank,
    vSync,
    lineCount
     );

    logic [11:0]spriteAddress;
    logic [1:0] tileAttribute_REG;
    logic [7:0] tileLowByte;
    logic [7:0] tileHighByte;
    logic[7:0] dataRender_OUT;

VramController DaVideoMemories(
    bufferedClock, //nes/4
    clockCount[0],
    rwBuffered,
    ramData_EN,  //7
    videoRamAddress,
    dataToComponents,
    dataFromMemory,
    vramIncrement,
    backgroundFetch_EN,
    spriteFetch_EN,
    dummyFetch_EN,
    idle,
    backgroundPatternTableAddress,
    spriteAddress,
    tileAttribute_REG,
    tileLowByte,
    tileHighByte,
    dataRender_OUT,

    //To the memory bus
    PPU_AD,
    memLatch,
    memRead,
    memWrite
    );

logic [5:0]spritePixel;
SpriteHandler ElSprites(
    bufferedClock,
    clockCount == 3,
    spriteFetch_EN,
    spriteEval_EN,
    oamData_EN,
    rwBuffered,
    dataToComponents,
    dataFromComponents,
    spriteEvalReset,
    clearVerticalBlank,
    spriteSize,
    spritePixelShifty_EN,
    spritePatternTableAddress,
    oamAddress,
    lineCount,
    dataRender_OUT,
    oamNextAttr,
    oamNextEntry,
    spriteOverflow,
    spriteAddress,
    spritePixel,
    SW[7:0]
    );
logic [4:0]backgroundPixel;
BackgroundPixelGen BackGen(
    bufferedClock, //nes/4
    clockCount == 3,
    backgroundPixelShifty_EN,
    incrementX,
    tileAttribute_REG,
    tileHighByte,
    tileLowByte,
    fineXScroll,
    backgroundPixel
    );

PixelPrioritizer DaSelectionOfDaPixelyBits(
    bufferedClock,
    clockCount == 3,
    backgroundDraw_EN,
    spriteDraw_EN,
    backgroundPixel,
    spritePixel,
    setSpriteCollision,
    palleteSelect,
    SW[8]
    );

NtscVideoGenerator VideoGen(
    doubleClock, //bufferedClock, // the full 21MHz clock
    luminance_EN,
    chrominance_EN,
    sync_EN,
    colorBurst_EN,
    colorEmphasis,
    selectedColour,
    videoOut
    );

VGA ViolentGatorArray(
    vgaClock, 
    0,//SW, 
    bufferedClock, //nes/4
    clockCount == 3,
    vgaPixelOut_EN,
    vSync,
    lineCount[4:0],
    selectedColour,
    VGA_R, 
    VGA_G, 
    VGA_B, 
    VGA_HS, 
    VGA_VS);

endmodule
