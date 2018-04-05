`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2018 03:06:36 PM
// Design Name: 
// Module Name: DecodeRom
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

module DecodeRom(
    //For some reason the inputs here are:
        //1: the full OP code
        //2: a not'd version of the OP code (but only 7 bits of it (I'm not sure WHICH 7 bits, though))
            //So I'm going to see if I can intake this, but ignore it, and only use the normal opcode
                //but modify it how I need
        //3: 6 bits of timing info
    input logic [7:0] opCode , input logic [6:0] notOpCode , input logic [5:0] timingIn ,
    //Then there's these 130 outputs
    output logic [129:0] allOutputs);
    
    `define STY 0
    `define T3INDYA 1
    `define T2ABSY 2
    `define T0CPYINY 3
    `define T0TYAA 4
    `define T0DEYINY 5
    `define T5INT 6
    `define LDXSDX 7
    `define T2ANYX 8
    `define T2XIND 9
    `define T0TXAA 10
    `define T0DEX 11
    `define T0CPXINX 12
    `define T0TXS 13
    `define SDX 14
    `define T0TALDTSX 15
    `define T1DEX 16
    `define T1INX 17
    `define T0TSX 18
    `define T1DEYINY 19
    `define T0LDY1 20
    `define T0LDY2TAY 21
    `define CCC 22
    `define T0JSR 23
    `define T0PSHASHP 24
    `define T4RTS 25
    `define T3PLAPLPA 26
    `define T5RTI 27
    `define RORRORA 28
    `define T2JSR 29
    `define JMPA 30
    `define T2 31
    `define T2EXT 32
    `define RTIRTS 33
    `define T4XIND 34
    `define T0A 35
    `define T2NANYABS 36
    `define T4RTIA 37
    `define T4JSRINT 38
    `define NAME1 39
        `define T3_RTI_RTS_JSR_JMP_INT_PULA_PUPL 39
    `define T3INDYB 40
    `define T3XIND 41
    `define T4INDYA 42
    `define T2INDY 43
    `define T3ABSXYA 44
    `define PULAPULP 45
    `define INC 46
    `define T0EOR 47
    `define T0CMP 48
    `define NAME2 49
        `define T0_CPX_CPY_INX_INY 49
    `define T0ADCSBC 50
    `define T0SBC 51
    `define ROLROLA 52
    `define T3JMP 53
    `define T0ORA 54
    `define NAME8 55
        `define ROL_ROLA_ASL_ASLA 55
    `define T0TYAB 56
    `define T0TXAB 57
    `define T1ADCSBCA 58
    `define NAME7 59
        `define T1_AND_EOR_OR_ADC 59
    `define NAME4 60
        `define T1_ASLA_ROLA_LSRA 60
    `define T0PULA 61
    `define T4ABSXYA 62
    `define T5INDY 63
    `define T0LDA 64
    `define T0G1 65
    `define T0AND 66
    `define T0BITA 67
    `define NAME6 68
        `define T0_ASLA_ROLA_LSRA 68
    `define T0TAX 69
    `define T0TAY 70
    `define T0LSRA 71
    `define LSRLSRA 72
    `define T5JSRA 73
    `define T2BR 74
    `define T2INT 75
    `define T3JSR 76
    `define T2ANYZP 77
    `define T2ANYIND 78
    `define T4 79
    `define T3 80
    `define T0RTIINT 81
    `define T0JMP 82
    `define NAME3 83
        `define T2_RTI_RTS_JSR_INT_PULA_PUPLP_PSHA_PSHP 83
    `define T5RTS 84
    `define T2ANYABS 85
    `define STA 86
    `define T2PSHA 87
    `define T0BR 88
    `define PSHPULA 89
    `define T5XIND 90
    `define T3ANYABS 91
    `define T4INDYB 92
    `define T3ABSXYB 93
    `define RTIINT 94
    `define JSR 95
    `define JMPB 96
    `define T1CPX2CY2 97
    `define T1ASLARLA 98
    `define T1CPX1CY1 99
    `define T1CMP 100
    `define T1ADCSBCB 101
    `define NAME5 102
        `define ROL_ROLA_ASL_ASLA 102
    `define LSRRADCIC 103
    `define T1BIT 104
    `define T2PSHP 105
    `define T4INT 106
    `define STASTYSTX 107
    `define T4ABSXYB 108
    `define T5ANYIND 109
    `define T2ZP 110
    `define T3ABS 111
    `define T3ZPX 112
    `define T2PSHASHP 113
    `define T5RTIRTS 114
    `define T5JSRB 115
    `define T4JMP 116
    `define T2JMPABS 117
    `define T3PLAPLPB 118
    `define T3BR 119
    `define T0BITB 120
    `define T4RTIB 121
    `define T0PULP 122
    `define PSHPULB 123
    `define CLV 124
    `define T0CLCSEC 125
    `define T0CLISEI 126
    `define T0CLDSED 127
    `define NI7P 128
    `define NI6P 129    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    logic [1:0] G;

    logic [15:0] fullReg;
    
    assign G[1:0] = opCode[1:0];

    assign fullReg = {opCode[7:0],G[1:0],timingIn[5:0]}; 
    
    always_comb
    begin
        allOutputs = 0;


        if(fullReg ==? 16'b100X_X1XX_00XX_XXXX)
        begin
            allOutputs[`STY] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_X1_001000)
        begin
            allOutputs[`T3INDYA] = 1'b1;
        end

        if(fullReg ==? 16'bXXX110XX_X1_000100)
        begin
            allOutputs[`T2ABSY] = 1'b1;
        end

        if(fullReg ==? 16'b1100XXXX_00_000001)
        begin
            allOutputs[`T0CPYINY] = 1'b1;
        end

        if(fullReg ==? 16'b100110XX_00_000001)
        begin
            allOutputs[`T0TYAA] = 1'b1;
        end

        if(fullReg ==? 16'b1X0010XX_00_000001)
        begin
            allOutputs[`T0DEYINY] = 1'b1;
        end

        if(fullReg ==? 16'b000000XX_00_100000)
        begin
            allOutputs[`T5INT] = 1'b1;
        end

        if(fullReg ==? 16'b10XXXXXX_1X_XXXXXX)
        begin
            allOutputs[`LDXSDX] = 1'b1;
        end

        if(fullReg ==? 16'bXXX1X1XX_XX_000100)
        begin
            allOutputs[`T2ANYX] = 1'b1;
        end

        if(fullReg ==? 16'bXXX000XX_X1_000100)
        begin
            allOutputs[`T2XIND] = 1'b1;
        end

        if(fullReg ==? 16'b100010XX_1X_000001)
        begin
            allOutputs[`T0TXAA] = 1'b1;
        end

        if(fullReg ==? 16'b110010XX_1X_000001)
        begin
            allOutputs[`T0DEX] = 1'b1;
        end

        if(fullReg ==? 16'b1110XXXX_00_000001)
        begin
            allOutputs[`T0CPXINX] = 1'b1;
        end

        if(fullReg ==? 16'b100110XX_1X_000001)
        begin
            allOutputs[`T0TXS] = 1'b1;
        end

        if(fullReg ==? 16'b100XXXXX_1X_XXXXXX)
        begin
            allOutputs[`SDX] = 1'b1;
        end

        if(fullReg ==? 16'b101XXXXX_1X_000001)
        begin
            allOutputs[`T0TALDTSX] = 1'b1;
        end

        if(fullReg ==? 16'b110010XX_1X_000010)
        begin
            allOutputs[`T1DEX] = 1'b1;
        end

        if(fullReg ==? 16'b111010XX_00_000010)
        begin
            allOutputs[`T1INX] = 1'b1;
        end

        if(fullReg ==? 16'b101110XX_1X_000001)
        begin
            allOutputs[`T0TSX] = 1'b1;
        end

        if(fullReg ==? 16'b1X0010XX_00_000010)
        begin
            allOutputs[`T1DEYINY] = 1'b1;
        end

        if(fullReg ==? 16'b101XX1XX_00_000001)
        begin
            allOutputs[`T0LDY1] = 1'b1;
        end

        if(fullReg ==? 16'b1010XXXX_00_000001)
        begin
            allOutputs[`T0LDY2TAY] = 1'b1;
        end

        if(fullReg ==? 16'b0XX0X0XX_00_000100)
        begin
            allOutputs[`CCC] = 1'b1;
        end

        if(fullReg ==? 16'b001000XX_00_000001)
        begin
            allOutputs[`T0JSR] = 1'b1;
        end

        if(fullReg ==? 16'b0X0010XX_00_000001)
        begin
            allOutputs[`T0PSHASHP] = 1'b1;
        end

        if(fullReg ==? 16'b011000XX_00_010000)
        begin
            allOutputs[`T4RTS] = 1'b1;
        end

        if(fullReg ==? 16'b0X1010XX_00_001000)
        begin
            allOutputs[`T3PLAPLPA] = 1'b1;
        end

        if(fullReg ==? 16'b010000XX_00_100000)
        begin
            allOutputs[`T5RTI] = 1'b1;
        end

        if(fullReg ==? 16'b011XXXXX_1X_XXXXXX)
        begin
            allOutputs[`RORRORA] = 1'b1;
        end

        if(fullReg ==? 16'b001000XX_00_000100)
        begin
            allOutputs[`T2JSR] = 1'b1;
        end

        if(fullReg ==? 16'b01X011XX_00_XXXXXX)
        begin
            allOutputs[`JMPA] = 1'b1;
        end

        if(fullReg ==? 16'bXXXXXXXX_XX_000100)
        begin
            allOutputs[`T2] = 1'b1;
        end

        if(fullReg ==? 16'bXXX011XX_XX_000100)
        begin
            allOutputs[`T2EXT] = 1'b1;
        end

        if(fullReg ==? 16'b01X000XX_00_XXXXXX)
        begin
            allOutputs[`RTIRTS] = 1'b1;
        end

        if(fullReg ==? 16'bXXX000XX_X1_010000)
        begin
            allOutputs[`T4XIND] = 1'b1;
        end

        if(fullReg ==? 16'bXXXXXXXX_XX_000001)
        begin
            allOutputs[`T0A] = 1'b1;
        end

        if(fullReg ==? 16'bXXXX0XXX_XX_000100)
        begin
            allOutputs[`T2NANYABS] = 1'b1;
        end

        if(fullReg ==? 16'b010000XX_00_010000)
        begin
            allOutputs[`T4RTIA] = 1'b1;
        end

        if(fullReg ==? 16'b00X000XX_00_010000)
        begin
            allOutputs[`T4JSRINT] = 1'b1;
        end

        if(fullReg ==? 16'b0XX0XXXX_00_001000)
        begin
            allOutputs[`NAME1] = 1'b1;
            /*T3_RTI_RTS_JSR_JMP_INT_PULA_PUPL*/
        end

        if(fullReg ==? 16'bXXX100XX_X1_001000)
        begin
            allOutputs[`T3INDYB] = 1'b1;
        end

        if(fullReg ==? 16'bXXX000XX_X1_001000)
        begin
            allOutputs[`T3XIND] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_X1_010000)
        begin
            allOutputs[`T4INDYA] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_X1_000100)
        begin
            allOutputs[`T2INDY] = 1'b1;
        end

        if(fullReg ==? 16'bXXX11XXX_XX_001000)
        begin
            allOutputs[`T3ABSXYA] = 1'b1;
        end

        if(fullReg ==? 16'b0X1010XX_00_XXXXXX)
        begin
            allOutputs[`PULAPULP] = 1'b1;
        end

        if(fullReg ==? 16'b111XXXXX_1X_XXXXXX)
        begin
            allOutputs[`INC] = 1'b1;
        end

        if(fullReg ==? 16'b010XXXXX_X1_000001)
        begin
            allOutputs[`T0EOR] = 1'b1;
        end

        if(fullReg ==? 16'b110XXXXX_X1_000001)
        begin
            allOutputs[`T0CMP] = 1'b1;
        end

        if(fullReg ==? 16'b11X0XXXX_00_000001)
        begin
            allOutputs[`NAME2] = 1'b1;
            /*T0_CPX_CPY_INX_INY*/
        end

        if(fullReg ==? 16'bX11XXXXX_X1_000001)
        begin
            allOutputs[`T0ADCSBC] = 1'b1;
        end

        if(fullReg ==? 16'b111XXXXX_X1_000001)
        begin
            allOutputs[`T0SBC] = 1'b1;
        end

        if(fullReg ==? 16'b001XXXXX_1X_XXXXXX)
        begin
            allOutputs[`ROLROLA] = 1'b1;
        end

        if(fullReg ==? 16'b01X011XX_00_001000)
        begin
            allOutputs[`T3JMP] = 1'b1;
        end

        if(fullReg ==? 16'b000XXXXX_X1_000001)
        begin
            allOutputs[`T0ORA] = 1'b1;
        end

        if(fullReg ==? 16'b00XXXXXX_1X_XXXXXX)
        begin
            allOutputs[`NAME8] = 1'b1;
            /*ROL_ROLA_ASL_ASLA*/
        end

        if(fullReg ==? 16'b100110XX_00_000001)
        begin
            allOutputs[`T0TYAB] = 1'b1;
        end

        if(fullReg ==? 16'b100010XX_1X_000001)
        begin
            allOutputs[`T0TXAB] = 1'b1;
        end

        if(fullReg ==? 16'bX11XXXXX_X1_000010)
        begin
            allOutputs[`T1ADCSBCA] = 1'b1;
        end

        if(fullReg ==? 16'b0XXXXXXX_X1_000010)
        begin
            allOutputs[`NAME7] = 1'b1;
            /*T1_AND_EOR_OR_ADC*/
        end

        if(fullReg ==? 16'b0XX010XX_1X_000010)
        begin
            allOutputs[`NAME4] = 1'b1;
            /*T1_ASLA_ROLA_LSRA*/
        end

        if(fullReg ==? 16'b011010XX_00_000001)
        begin
            allOutputs[`T0PULA] = 1'b1;
        end

        if(fullReg ==? 16'bXXX11XXX_XX_010000)
        begin
            allOutputs[`T4ABSXYA] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_X1_100000)
        begin
            allOutputs[`T5INDY] = 1'b1;
        end

        if(fullReg ==? 16'b101XXXXX_X1_000001)
        begin
            allOutputs[`T0LDA] = 1'b1;
        end

        if(fullReg ==? 16'bXXXXXXXX_X1_000001)
        begin
            allOutputs[`T0G1] = 1'b1;
        end

        if(fullReg ==? 16'b001XXXXX_X1_000001)
        begin
            allOutputs[`T0AND] = 1'b1;
        end

        if(fullReg ==? 16'b0010X1XX_00_000001)
        begin
            allOutputs[`T0BITA] = 1'b1;
        end

        if(fullReg ==? 16'b0XX010XX_1X_000001)
        begin
            allOutputs[`NAME6] = 1'b1;
            /*T0_ASLA_ROLA_LSRA*/
        end

        if(fullReg ==? 16'b101010XX_1X_000001)
        begin
            allOutputs[`T0TAX] = 1'b1;
        end

        if(fullReg ==? 16'b101010XX_00_000001)
        begin
            allOutputs[`T0TAY] = 1'b1;
        end

        if(fullReg ==? 16'b01X010XX_1X_000001)
        begin
            allOutputs[`T0LSRA] = 1'b1;
        end

        if(fullReg ==? 16'b01XXXXXX_1X_XXXXXX)
        begin
            allOutputs[`LSRLSRA] = 1'b1;
        end

        if(fullReg ==? 16'b001000XX_00_100000)
        begin
            allOutputs[`T5JSRA] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_00_000100)
        begin
            allOutputs[`T2BR] = 1'b1;
        end

        if(fullReg ==? 16'b000000XX_00_000100)
        begin
            allOutputs[`T2INT] = 1'b1;
        end

        if(fullReg ==? 16'b001000XX_00_001000)
        begin
            allOutputs[`T3JSR] = 1'b1;
        end

        if(fullReg ==? 16'bXXXX01XX_XX_000100)
        begin
            allOutputs[`T2ANYZP] = 1'b1;
        end

        if(fullReg ==? 16'bXXXX00XX_X1_000100)
        begin
            allOutputs[`T2ANYIND] = 1'b1;
        end

        if(fullReg ==? 16'bXXXXXXXX_XX_010000)
        begin
            allOutputs[`T4] = 1'b1;
        end

        if(fullReg ==? 16'bXXXXXXXX_XX_001000)
        begin
            allOutputs[`T3] = 1'b1;
        end

        if(fullReg ==? 16'b0X0000XX_00_000001)
        begin
            allOutputs[`T0RTIINT] = 1'b1;
        end

        if(fullReg ==? 16'b01X011XX_00_000001)
        begin
            allOutputs[`T0JMP] = 1'b1;
        end

        if(fullReg ==? 16'b0XX0X0XX_00_000100)
        begin
            allOutputs[`NAME3] = 1'b1;
            /*T2_RTI_RTS_JSR_INT_PULA_PUPLP_PSHA_PSHP*/
        end

        if(fullReg ==? 16'b011000XX_00_100000)
        begin
            allOutputs[`T5RTS] = 1'b1;
        end

        if(fullReg ==? 16'bXXXX1XXX_XX_000100)
        begin
            allOutputs[`T2ANYABS] = 1'b1;
        end

        if(fullReg ==? 16'b100XXXXX_X1_XXXXXX)
        begin
            allOutputs[`STA] = 1'b1;
        end

        if(fullReg ==? 16'b010010XX_00_000100)
        begin
            allOutputs[`T2PSHA] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_00_000001)
        begin
            allOutputs[`T0BR] = 1'b1;
        end

        if(fullReg ==? 16'b0XX010XX_00_XXXXXX)
        begin
            allOutputs[`PSHPULA] = 1'b1;
        end

        if(fullReg ==? 16'bXXX000XX_X1_100000)
        begin
            allOutputs[`T5XIND] = 1'b1;
        end

        if(fullReg ==? 16'bXXXX1XXX_XX_001000)
        begin
            allOutputs[`T3ANYABS] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_X1_010000)
        begin
            allOutputs[`T4INDYB] = 1'b1;
        end

        if(fullReg ==? 16'bXXX11XXX_XX_001000)
        begin
            allOutputs[`T3ABSXYB] = 1'b1;
        end

        if(fullReg ==? 16'b0X0000XX_00_XXXXXX)
        begin
            allOutputs[`RTIINT] = 1'b1;
        end

        if(fullReg ==? 16'b001000XX_00_XXXXXX)
        begin
            allOutputs[`JSR] = 1'b1;
        end

        if(fullReg ==? 16'b01X011XX_00_XXXXXX)
        begin
            allOutputs[`JMPB] = 1'b1;
        end

        if(fullReg ==? 16'b11X00XXX_00_000010)
        begin
            allOutputs[`T1CPX2CY2] = 1'b1;
        end

        if(fullReg ==? 16'b00X010XX_1X_000010)
        begin
            allOutputs[`T1ASLARLA] = 1'b1;
        end

        if(fullReg ==? 16'b11X011XX_00_000010)
        begin
            allOutputs[`T1CPX1CY1] = 1'b1;
        end

        if(fullReg ==? 16'b110XXXXX_X1_000010)
        begin
            allOutputs[`T1CMP] = 1'b1;
        end

        if(fullReg ==? 16'bX11XXXXX_X1_000010)
        begin
            allOutputs[`T1ADCSBCB] = 1'b1;
        end

        if(fullReg ==? 16'b00XXXXXX_1X_XXXXXX)
        begin
            allOutputs[`NAME5] = 1'b1;
            /*ROL_ROLA_ASL_ASLA*/
        end

        if(fullReg ==? 16'bX1XXXXXX_1X_XXXXXX)
        begin
            allOutputs[`LSRRADCIC] = 1'b1;
        end

        if(fullReg ==? 16'b0010X1XX_00_000010)
        begin
            allOutputs[`T1BIT] = 1'b1;
        end

        if(fullReg ==? 16'b000010XX_00_000100)
        begin
            allOutputs[`T2PSHP] = 1'b1;
        end

        if(fullReg ==? 16'b000000XX_00_010000)
        begin
            allOutputs[`T4INT] = 1'b1;
        end

        if(fullReg ==? 16'b100XXXXX_XX_XXXXXX)
        begin
            allOutputs[`STASTYSTX] = 1'b1;
        end

        if(fullReg ==? 16'bXXX11XXX_XX_010000)
        begin
            allOutputs[`T4ABSXYB] = 1'b1;
        end

        if(fullReg ==? 16'bXXXX00XX_X1_100000)
        begin
            allOutputs[`T5ANYIND] = 1'b1;
        end

        if(fullReg ==? 16'bXXX001XX_XX_000100)
        begin
            allOutputs[`T2ZP] = 1'b1;
        end

        if(fullReg ==? 16'bXXX011XX_XX_001000)
        begin
            allOutputs[`T3ABS] = 1'b1;
        end

        if(fullReg ==? 16'bXXX101XX_XX_001000)
        begin
            allOutputs[`T3ZPX] = 1'b1;
        end

        if(fullReg ==? 16'b0X0010XX_00_000100)
        begin
            allOutputs[`T2PSHASHP] = 1'b1;
        end

        if(fullReg ==? 16'b01X000XX_00_100000)
        begin
            allOutputs[`T5RTIRTS] = 1'b1;
        end

        if(fullReg ==? 16'b001000XX_00_100000)
        begin
            allOutputs[`T5JSRB] = 1'b1;
        end

        if(fullReg ==? 16'b01X011XX_00_100000)
        begin
            allOutputs[`T4JMP] = 1'b1;
        end

        if(fullReg ==? 16'b010011XX_00_000100)
        begin
            allOutputs[`T2JMPABS] = 1'b1;
        end

        if(fullReg ==? 16'b0X1010XX_00_001000)
        begin
            allOutputs[`T3PLAPLPB] = 1'b1;
        end

        if(fullReg ==? 16'bXXX100XX_00_001000)
        begin
            allOutputs[`T3BR] = 1'b1;
        end

        if(fullReg ==? 16'b0010X1XX_00_000001)
        begin
            allOutputs[`T0BITB] = 1'b1;
        end

        if(fullReg ==? 16'b010000XX_00_010000)
        begin
            allOutputs[`T4RTIB] = 1'b1;
        end

        if(fullReg ==? 16'b001010XX_00_000001)
        begin
            allOutputs[`T0PULP] = 1'b1;
        end

        if(fullReg ==? 16'b0XX010XX_00_XXXXXX)
        begin
            allOutputs[`PSHPULB] = 1'b1;
        end

        if(fullReg ==? 16'b101110XX_00_XXXXXX)
        begin
            allOutputs[`CLV] = 1'b1;
        end

        if(fullReg ==? 16'b00X110XX_00_000001)
        begin
            allOutputs[`T0CLCSEC] = 1'b1;
        end

        if(fullReg ==? 16'b01X110XX_00_000001)
        begin
            allOutputs[`T0CLISEI] = 1'b1;
        end

        if(fullReg ==? 16'b11X110XX_00_000001)
        begin
            allOutputs[`T0CLDSED] = 1'b1;
        end

        if(fullReg ==? 16'b0XXXXXXX_XX_XXXXXX)
        begin
            allOutputs[`NI7P] = 1'b1;
        end

        if(fullReg ==? 16'bX0XXXXXX_XX_XXXXXX)
        begin
            allOutputs[`NI6P] = 1'b1;
        end
    end
endmodule