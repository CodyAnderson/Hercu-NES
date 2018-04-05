`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2018 03:06:36 PM
// Design Name: 
// Module Name: DecodeRom_TestBench
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


module DecodeRom_TestBench( );
    
    
    
    logic O_STY;
    logic O_T3INDYA;
    logic O_T2ABSY;
    logic O_T0CPYINY;
    logic O_T0TYAA;
    logic O_T0DEYINY;
    logic O_T5INT;
    logic O_LDXSDX;
    logic O_T2ANYX;
    logic O_T2XIND;
    logic O_T0TXAA;
    logic O_T0DEX;
    logic O_T0CPXINX;
    logic O_T0TXS;
    logic O_SDX;
    logic O_T0TALDTSX;
    logic O_T1DEX;
    logic O_T1INX;
    logic O_T0TSX;
    logic O_T1DEYINY;
    logic O_T0LDY1;
    logic O_T0LDY2TAY;
    logic O_CCC;
    logic O_T0JSR;
    logic O_T0PSHASHP;
    logic O_T4RTS;
    logic O_T3PLAPLPA;
    logic O_T5RTI;
    logic O_RORRORA;
    logic O_T2JSR;
    logic O_JMPA;
    logic O_T2;
    logic O_T2EXT;
    logic O_RTIRTS;
    logic O_T4XIND;
    logic O_T0A;
    logic O_T2NANYABS;
    logic O_T4RTIA;
    logic O_T4JSRINT;
    logic O_NAME1/*T3_RTI_RTS_JSR_JMP_INT_PULA_PUPL*/;
    logic O_T3INDYB;
    logic O_T3XIND;
    logic O_T4INDYA;
    logic O_T2INDY;
    logic O_T3ABSXYA;
    logic O_PULAPULP;
    logic O_INC;
    logic O_T0EOR;
    logic O_T0CMP;
    logic O_NAME2/*T0_CPX_CPY_INX_INY*/;
    logic O_T0ADCSBC;
    logic O_T0SBC;
    logic O_ROLROLA;
    logic O_T3JMP;
    logic O_T0ORA;
    logic O_NAME8/*ROL_ROLA_ASL_ASLA*/;
    logic O_T0TYAB;
    logic O_T0TXAB;
    logic O_T1ADCSBCA;
    logic O_NAME7/*T1_AND_EOR_OR_ADC*/;
    logic O_NAME4/*T1_ASLA_ROLA_LSRA*/;
    logic O_T0PULA;
    logic O_T4ABSXYA;
    logic O_T5INDY;
    logic O_T0LDA;
    logic O_T0G1;
    logic O_T0AND;
    logic O_T0BITA;
    logic O_NAME6/*T0_ASLA_ROLA_LSRA*/;
    logic O_T0TAX;
    logic O_T0TAY;
    logic O_T0LSRA;
    logic O_LSRLSRA;
    logic O_T5JSRA;
    logic O_T2BR;
    logic O_T2INT;
    logic O_T3JSR;
    logic O_T2ANYZP;
    logic O_T2ANYIND;
    logic O_T4;
    logic O_T3;
    logic O_T0RTIINT;
    logic O_T0JMP;
    logic O_NAME3/*T2_RTI_RTS_JSR_INT_PULA_PUPLP_PSHA_PSHP*/;
    logic O_T5RTS;
    logic O_T2ANYABS;
    logic O_STA;
    logic O_T2PSHA;
    logic O_T0BR;
    logic O_PSHPULA;
    logic O_T5XIND;
    logic O_T3ANYABS;
    logic O_T4INDYB;
    logic O_T3ABSXYB;
    logic O_RTIINT;
    logic O_JSR;
    logic O_JMPB;
    logic O_T1CPX2CY2;
    logic O_T1ASLARLA;
    logic O_T1CPX1CY1;
    logic O_T1CMP;
    logic O_T1ADCSBCB;
    logic O_NAME5/*ROL_ROLA_ASL_ASLA*/;
    logic O_LSRRADCIC;
    logic O_T1BIT;
    logic O_T2PSHP;
    logic O_T4INT;
    logic O_STASTYSTX;
    logic O_T4ABSXYB;
    logic O_T5ANYIND;
    logic O_T2ZP;
    logic O_T3ABS;
    logic O_T3ZPX;
    logic O_T2PSHASHP;
    logic O_T5RTIRTS;
    logic O_T5JSRB;
    logic O_T4JMP;
    logic O_T2JMPABS;
    logic O_T3PLAPLPB;
    logic O_T3BR;
    logic O_T0BITB;
    logic O_T4RTIB;
    logic O_T0PULP;
    logic O_PSHPULB;
    logic O_CLV;
    logic O_T0CLCSEC;
    logic O_T0CLISEI;
    logic O_T0CLDSED;
    logic O_NI7P;
    logic O_NI6P;

    
    
    logic [7:0] opCode;
    logic [6:0] notOpCode;
    logic [5:0] timingIn;
    
    logic started;
    
    logic clk;
    initial clk = 0;
    initial started = 0;
    always #1 clk = ~clk;
    always #2 started = 1;
    
    
    assign notOpCode[6:0] = opCode[6:0];
    

    
    always_ff@(posedge clk)
    begin
        if(started == 1)
        begin
            if(timingIn == 6'b100000)
            begin
                if(opCode == 255)
                begin
                    opCode <= 0;
                end
                
                else
                begin
                    opCode <= opCode + 1;
                end
                
                timingIn <= 6'b000001;
            end
            
            else
            begin
                timingIn <= timingIn * 2;
            end
        end
        
        else
        begin
            timingIn <= 1;
            opCode <= 132;
        end
    end

    DecodeRom Phil(opCode , notOpCode , timingIn ,
    {
        O_NI6P,
        O_NI7P,
        O_T0CLDSED,
        O_T0CLISEI,
        O_T0CLCSEC,
        O_CLV,
        O_PSHPULB,
        O_T0PULP,
        O_T4RTIB,
        O_T0BITB,
        O_T3BR,
        O_T3PLAPLPB,
        O_T2JMPABS,
        O_T4JMP,
        O_T5JSRB,
        O_T5RTIRTS,
        O_T2PSHASHP,
        O_T3ZPX,
        O_T3ABS,
        O_T2ZP,
        O_T5ANYIND,
        O_T4ABSXYB,
        O_STASTYSTX,
        O_T4INT,
        O_T2PSHP,
        O_T1BIT,
        O_LSRRADCIC,
        O_NAME5/*ROL_ROLA_ASL_ASLA*/,
        O_T1ADCSBCB,
        O_T1CMP,
        O_T1CPX1CY1,
        O_T1ASLARLA,
        O_T1CPX2CY2,
        O_JMPB,
        O_JSR,
        O_RTIINT,
        O_T3ABSXYB,
        O_T4INDYB,
        O_T3ANYABS,
        O_T5XIND,
        O_PSHPULA,
        O_T0BR,
        O_T2PSHA,
        O_STA,
        O_T2ANYABS,
        O_T5RTS,
        O_NAME3/*T2_RTI_RTS_JSR_INT_PULA_PUPLP_PSHA_PSHP*/,
        O_T0JMP,
        O_T0RTIINT,
        O_T3,
        O_T4,
        O_T2ANYIND,
        O_T2ANYZP,
        O_T3JSR,
        O_T2INT,
        O_T2BR,
        O_T5JSRA,
        O_LSRLSRA,
        O_T0LSRA,
        O_T0TAY,
        O_T0TAX,
        O_NAME6/*T0_ASLA_ROLA_LSRA*/,
        O_T0BITA,
        O_T0AND,
        O_T0G1,
        O_T0LDA,
        O_T5INDY,
        O_T4ABSXYA,
        O_T0PULA,
        O_NAME4/*T1_ASLA_ROLA_LSRA*/,
        O_NAME7/*T1_AND_EOR_OR_ADC*/,
        O_T1ADCSBCA,
        O_T0TXAB,
        O_T0TYAB,
        O_NAME8/*ROL_ROLA_ASL_ASLA*/,
        O_T0ORA,
        O_T3JMP,
        O_ROLROLA,
        O_T0SBC,
        O_T0ADCSBC,
        O_NAME2/*T0_CPX_CPY_INX_INY*/,
        O_T0CMP,
        O_T0EOR,
        O_INC,
        O_PULAPULP,
        O_T3ABSXYA,
        O_T2INDY,
        O_T4INDYA,
        O_T3XIND,
        O_T3INDYB,
        O_NAME1/*T3_RTI_RTS_JSR_JMP_INT_PULA_PUPL*/,
        O_T4JSRINT,
        O_T4RTIA,
        O_T2NANYABS,
        O_T0A,
        O_T4XIND,
        O_RTIRTS,
        O_T2EXT,
        O_T2,
        O_JMPA,
        O_T2JSR,
        O_RORRORA,
        O_T5RTI,
        O_T3PLAPLPA,
        O_T4RTS,
        O_T0PSHASHP,
        O_T0JSR,
        O_CCC,
        O_T0LDY2TAY,
        O_T0LDY1,
        O_T1DEYINY,
        O_T0TSX,
        O_T1INX,
        O_T1DEX,
        O_T0TALDTSX,
        O_SDX,
        O_T0TXS,
        O_T0CPXINX,
        O_T0DEX,
        O_T0TXAA,
        O_T2XIND,
        O_T2ANYX,
        O_LDXSDX,
        O_T5INT,
        O_T0DEYINY,
        O_T0TYAA,
        O_T0CPYINY,
        O_T2ABSY,
        O_T3INDYA,
        O_STY
    });

endmodule
