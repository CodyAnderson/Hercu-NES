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
    logic [7:0] systemBus;
    logic [7:0] dataBus;
    logic [7:0] addressLow;
    
    //Register busses
    logic [7:0] hold_REG;
    logic [7:0] a_REG;
    logic [7:0] b_REG;
    
    //A register control lines
    logic a_systemBus_EN = 0;
    logic a_zero_EN = 0;
    
    //B register control lines
    logic b_dataBus_EN = 0;
    logic b_dataBusInvert_EN = 0;
    logic b_addressLow_EN = 0;
    
    //ALU control lines
    logic alu_shiftRight_EN = 0;
    logic alu_eor_EN = 0;
    logic alu_sum_EN = 0;
    logic alu_or_EN = 0;
    logic alu_and_EN = 0;
    
    //ALU flag inputs
    logic carry_FLAG_IN = 0;
    
    //ALU flag outputs
    logic zero_FLAG_OUT;
    logic negative_FLAG_OUT;
    logic overflow_FLAG_OUT;
    logic carry_FLAG_OUT;
    
    //ADD register control lines
    logic add_adl_EN;
    logic add_sb06_EN;
    logic add_sb7_EN;
    
    //Testbench values
    logic [32:0] step = 0;
    
    //Testbench busses
    logic [7:0] tb_systemBus;
    logic [7:0] tb_dataBus;
    logic [7:0] tb_addressLow;
    
    //A Register
    A_INPUT_REGISTER A_REG(systemBus, a_systemBus_EN, a_zero_EN, 
                            a_REG);
    //B Register                        
    B_INPUT_REGISTER B_REG(dataBus, addressLow, b_dataBus_EN, b_dataBusInvert_EN, b_addressLow_EN,
                            b_REG);
    //ALU                        
    ALU ALUI(a_REG, b_REG, alu_shiftRight_EN, alu_eor_EN, alu_and_EN, alu_sum_EN, alu_or_EN, carry_FLAG_IN,
            hold_REG, overflow_FLAG_OUT, carry_FLAG_OUT, negative_FLAG_OUT, zero_FLAG_OUT);
         
    //ADD Hold Register        
    ADD_REG ADD(hold_REG, add_adl_EN, add_sb06_EN, add_sb7_EN, phi2, addressLow, systemBus);
            
            
            
            
    /* A/B/ALU Testbench
    always
    begin
        #20 step = step + 1;
        
        if(step == 1)
        begin
            tb_systemBus = 30;
            a_systemBus_EN = 1;
            a_zero_EN = 0;
        end
        else if(step == 2)
        begin
            tb_dataBus = 40;
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
            tb_dataBus = 41;
            tb_systemBus = 31;
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
            tb_addressLow = 10;
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
            
            tb_dataBus = 8'b11010000;
            tb_systemBus = 8'b01010000;
        end
        else if(step == 10)
        begin
            alu_sum_EN = 1;
        end
        else if(step == 11)
        begin
            tb_systemBus = 8'b00000001;
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
    end*/

endmodule