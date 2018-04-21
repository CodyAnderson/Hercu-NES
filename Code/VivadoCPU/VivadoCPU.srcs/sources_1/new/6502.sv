`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2018 08:04:50 AM
// Design Name: 
// Module Name: 6502
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


module m6502(
    
    //Clocks
    input logic phi1,
    input logic phi2,
    
    //Busses
    input logic [7:0] systemBus_IN,
    input logic [7:0] dataBus_IN,
    input logic [7:0] addressLow_IN,
    input logic [7:0] addressHigh_IN,
    
    input logic [7:0] systemBus_OUT,
    input logic [7:0] dataBus_OUT,
    input logic [7:0] addressLow_OUT,
    input logic [7:0] addressHigh_OUT,
    
    //Register busses
    input logic [7:0] tb_hold_REG,
    input logic [7:0] tb_a_REG,
    input logic [7:0] tb_b_REG,
    
    //A register control lines
    input logic a_systemBus_EN,
    input logic a_zero_EN,
    
    //B register control lines
    input logic b_dataBus_EN,
    input logic b_dataBusInvert_EN,
    input logic b_addressLow_EN,
    
    //ALU control lines
    input logic alu_shiftRight_EN,
    input logic alu_eor_EN,
    input logic alu_sum_EN,
    input logic alu_or_EN,
    input logic alu_and_EN,
    
    //ALU flag inputs
    input logic carry_FLAG_IN,
    
    //ALU flag outputs
    input logic zero_FLAG_OUT,
    input logic negative_FLAG_OUT,
    input logic overflow_FLAG_OUT,
    input logic carry_FLAG_OUT,
    
    //ADD register control lines
    input logic add_adl_EN,
    input logic add_sb06_EN,
    input logic add_sb7_EN,
    
    //Bus Control Lines
    input logic SBtoADH,
    input logic SBtoADL,
    input logic ADH0Drain,
    input logic ADH1to7Drain,
    input logic ADL0Drain,
    input logic ADL1Drain,
    input logic ADL2Drain,
    
    //Testbench values
    input logic [32:0] step,
    
    //Testbench busses
    input logic [7:0] tb_systemBus,
    input logic [7:0] tb_dataBus,
    input logic [7:0] tb_addressLow
    );
    
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
    DATA_BUS DATABUS(
        .data_IN(dataBus_IN),
        .dataBus_OUT(dataBus_OUT));
    
    //System Bus
    SYSTEM_BUS SYSTEMBUS(
        .data_IN(systemBus_IN),
        .addressHighPass_EN(SBtoADH),
        .addressLowPass_EN(SBtoADL),
        .systemBus_OUT(systemBus_OUT),
        .addressHigh_OUT(addressHigh_IN),
        .addressLow_OUT(addressLow_IN));
endmodule
