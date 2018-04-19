`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2018 03:22:23 PM
// Design Name: 
// Module Name: TestBench
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



module TestBench();

    typedef enum logic [2:0] {CTRL, MASK, STATUS, OAM_ADDR, OAM_DATA, SCROLL, ADDR, DATA} ppuReg;
    typedef enum logic {WRITE, READ} readWrite;
    reg [12:0] fakeCPU [1024];
    integer count = 0;
    task AddLine;
    input [12:0]line;
    begin
        fakeCPU[count] = line;
        count = count + 1;
    end
    endtask : AddLine

    task CODE;
    input readWrite in1; //read/Write
    input ppuReg in2; //command
    input logic[7:0] in3; //data
    begin
        AddLine({in1, CTRL, 8'b0, 1'b1}); // dummy line
        AddLine({in1, in2, 8'b0, 1'b0}); // switch address and rw first
        AddLine({in1, in2, in3, 1'b0}); // switch data second
        AddLine({in1, MASK, in3, 1'b1}); //turn off rw, address, and cable select
    end
    endtask : CODE

    initial begin
        for(integer i = 0; i < 1024; i = i+1)
            fakeCPU[i] = 1;
        CODE(WRITE, CTRL, 8'h80);
        CODE(WRITE, MASK, 8'b00011110);
        //CODE(WRITE, MASK, 8'b00011110);
    end



    logic clock = 0;
    always#5 clock = !clock;

    logic [10:0]clockDivisor = 0;
    logic dividedClock = 1;

    always_ff@(posedge clock)
    begin
        if(clockDivisor == 5)
        begin
            dividedClock <= !dividedClock;
            clockDivisor <= 0;
        end
        else
            clockDivisor <= clockDivisor + 1;
    end

    logic[9:0] commandCounter = 0;
    always_ff@(posedge dividedClock)
    begin
        if(commandCounter < 1000)
            commandCounter <= commandCounter + 1;
    end

      /////////////
     // Chip Stuff
    /////////////
    readWrite RW;
    logic [7:0]cpuDataInjection;
    logic [7:0]cpuDataReceived;
    wire [7:0]CPU_D;
    assign cpuDataReceived = CPU_D;
    assign (strong0, weak1) CPU_D = RW ? 8'hZZ : cpuDataInjection;
    ppuReg CPU_A;
    logic CS;
    logic [3:0]EXT;
    logic INT;
    logic PLUS_5V = 1;
    logic ALE;
    logic [7:0]ppuDataInjection = 8'hff;
    logic [13:0]ppuDataInput;
    wire [13:0]PPU_AD;
    assign ppuDataInput = PPU_AD;
    assign PPU_AD[13:8] = 'bzzzzzz;
    
    logic RD;
    logic WR;
    logic RST = 1;
    logic [7:0]VOUT;
    assign (strong0, weak1) PPU_AD[7:0] = RD ? 8'hZZ : ppuDataInjection;
    assign {RW, CPU_A, cpuDataInjection, CS} = fakeCPU[commandCounter];
      //////////////
     // Debug Stuff
    //////////////

    logic [9:0]SW = 'b00_1111_1111;
    logic [9:0]LEDR;
    logic [7:0]LEDG;
    RP2C02G ThePPU(
      /////////////
     // Chip Stuff
    /////////////
    RW,
    CPU_D,
    CPU_A,
    CS,
    ,//EXT,
    clock,
    INT,
    PLUS_5V,
    ALE,
    PPU_AD,
    RD,
    WR,
    RST,
    VOUT,

      //////////////
     // Debug Stuff
    //////////////

    SW,
    LEDR,
    LEDG
);

endmodule
