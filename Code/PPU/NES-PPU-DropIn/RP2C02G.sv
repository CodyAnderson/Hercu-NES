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
    output VOUT,

      //////////////
     // Debug Stuff
    //////////////

    input [9:0]SW,
    output [9:0]LEDR,
    output [7:0]LEDG
);

endmodule