`timescale 1ns / 1ps     
//////////////////////////////////////////////////////////////////////////////////
// Company: Team HercuNES
// Engineer: Ryan Price
// 
// Create Date: 02/09/2018 01:45:25 PM
// Design Name: testbench
// Module Name: testbench
// Project Name: HercuNES
// Target Devices: 
// Tool Versions: 
// Description: Testbench for various modules
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
                         
module testbench;

    //Clocks
    logic phi1;
    logic phi2;
    
    //Busses
    logic [7:0] systemBus_IN;
    logic [7:0] dataBus_IN;
    logic [7:0] addressLow_IN;
    logic [7:0] addressHigh_IN;
    
    logic [7:0] systemBus_OUT;
    logic [7:0] dataBus_OUT;
    logic [7:0] addressLow_OUT;
    logic [7:0] addressHigh_OUT;
    
    //Register busses
    logic [7:0] tb_hold_REG;
    logic [7:0] tb_a_REG;
    logic [7:0] tb_b_REG;
    
    //A register control lines
    logic a_systemBus_EN;
    logic a_zero_EN;
    
    //B register control lines
    logic b_dataBus_EN;
    logic b_dataBusInvert_EN;
    logic b_addressLow_EN;
    
    //ALU control lines
    logic alu_shiftRight_EN;
    logic alu_eor_EN;
    logic alu_sum_EN;
    logic alu_or_EN;
    logic alu_and_EN;
    
    //ALU flag inputs
    logic carry_FLAG_IN;
    
    //ALU flag outputs
    logic zero_FLAG_OUT;
    logic negative_FLAG_OUT;
    logic overflow_FLAG_OUT;
    logic carry_FLAG_OUT;
    
    //ADD register control lines
    logic add_adl_EN;
    logic add_sb06_EN;
    logic add_sb7_EN;
    
    //Bus Control Lines
    logic SBtoADH = 0;
    logic SBtoADL = 0;
    logic ADH0Drain = 0;
    logic ADH1to7Drain = 0;
    logic ADL0Drain = 0;
    logic ADL1Drain = 0;
    logic ADL2Drain = 0;
    
    //Testbench values
    logic [32:0] step;
    
    //Testbench busses
    logic [7:0] tb_systemBus;
    logic [7:0] tb_dataBus;
    logic [7:0] tb_addressLow;
    
    //A Register
    A_INPUT_REGISTER A_REG(
        .systemBus_IN(systemBus_OUT),
        .systemBus_EN(a_systemBus_EN),
        .zero_EN(a_zero_EN), 
        .a_REG_OUT(tb_a_REG));
    //B Register                        
    B_INPUT_REGISTER B_REG(
        .dataBus_IN(dataBus_OUT),
        .addressLow_IN(addressLow_OUT),
        .dataBus_EN(b_dataBus_EN),
        .dataBusInvert_EN(b_dataBusInvert_EN),
        .addressLow_EN(b_addressLow_EN),
        .b_REG_OUT(tb_b_REG));
    //ALU                        
    ALU ALUI(
        .a_REG_IN(tb_a_REG), 
        .b_REG_IN(tb_b_REG), 
        .shiftRight_EN(alu_shiftRight_EN), 
        .eor_EN(alu_eor_EN), 
        .and_EN(alu_and_EN), 
        .sum_EN(alu_sum_EN), 
        .or_EN(alu_or_EN), 
        .carry_FLAG_IN(carry_FLAG_IN),
        .hold_REG_OUT(tb_hold_REG), 
        .overflow_FLAG_OUT(overflow_FLAG_OUT), 
        .carry_FLAG_OUT(carry_FLAG_OUT), 
        .negative_FLAG_OUT(negative_FLAG_OUT), 
        .zero_FLAG_OUT(zero_FLAG_OUT));
         
    //ADD Hold Register        
    //ADD_REG ADD(hold_REG, add_adl_EN, add_sb06_EN, add_sb7_EN, phi2, addressLow_IN, systemBus_IN);
            
    //Data Latch
    
    //Program Counter High Select Register
    
    //Program Counter High Increment
    
    //Progarm Counter High Register
    
    //Program Counter Low Select Register
    
    //Program Counter Low Increment
    
    //Progarm Counter Low Register
    
    //Stack Pointer Register
    
    //Address Bus Low Register
    
    //Address Bus High Register
    
    //X Index Register
    
    //Y Index Register
    
    //Accumulator
    
    //Pre-Decode Register
    
    //Address Bus Low
    //ADDRESSLOW_BUS(addressLow_IN, ADL0Drain, ADL1Drain, ADL2Drain, addressLow_OUT);
    
    //Address Bus High
    //ADDRESSHIGH_BUS(addressHigh_IN, ADH0Drain, ADH1to7Drain, addressHigh_OUT);
    
    //Data Bus
    DATA_BUS(
        .data_IN(dataBus_IN),
        .dataBus_OUT(dataBus_OUT));
    
    //System Bus
    SYSTEM_BUS(
        .data_IN(systemBus_IN),
        .addressHighPass_EN(SBtoADH),
        .addressLowPass_EN(SBtoADL),
        .systemBus_OUT(systemBus_OUT),
        .addressHigh_OUT(addressHigh_IN),
        .addressLow_OUT(addressLow_IN));
            
            
     //A/B/ALU Testbench
    always
    begin
        #20 step = step + 1;
        $display(b_REG);
        $display(a_REG);
        
        if(step == 1)
        begin
            systemBus_IN = 30;
            a_systemBus_EN = 1;
            a_zero_EN = 0;
        end
        else if(step == 2)
        begin
            dataBus_IN = 40;
            b_dataBus_EN = 1;
            b_dataBusInvert_EN = 0;
        end
        else if(step == 3)
        begin
            b_dataBus_EN = 0;
            a_systemBus_EN = 0;
        end
        else if(step == 4)
        begin
            dataBus_IN = 41;
            systemBus_IN = 31;
        end
        else if(step == 5)
        begin
            b_dataBus_EN = 1;
            a_systemBus_EN = 1;
        end
        else if(step == 6)
        begin
            b_dataBus_EN = 0;
            b_dataBusInvert_EN = 1;
        end
        else if(step == 7)
        begin
            b_dataBusInvert_EN = 0;
            addressLow_IN = 10;
            b_addressLow_EN = 1;
        end
        else if(step == 8)
        begin
            a_zero_EN = 1;
            a_systemBus_EN = 0;
        end
        else if(step == 9)
        begin
            b_dataBus_EN = 1;
            b_dataBusInvert_EN = 0;
            b_addressLow_EN = 0;
            
            a_systemBus_EN = 1;
            a_zero_EN = 0;
            
            dataBus_IN = 8'b11010000;
            systemBus_IN = 8'b01010000;
        end
        else if(step == 10)
        begin
            alu_sum_EN = 1;
        end
        else if(step == 11)
        begin
            systemBus_IN = 8'b00000001;
        end
        else if(step == 12)
        begin
            alu_sum_EN = 0;
            alu_and_EN = 1;
        end
        else if(step == 13)
        begin
            alu_and_EN = 0;
            alu_or_EN = 1;
        end
        else if(step == 14)
        begin
            alu_or_EN = 0;
            alu_eor_EN = 1;
        end
        else if(step == 15)
        begin
            alu_eor_EN = 0;
            alu_shiftRight_EN = 1;
        end
    end

endmodule