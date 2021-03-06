`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2017 03:53:17 PM
// Design Name: 
// Module Name: testbench
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

module Legacy_testbench; 
  logic [7:0] count;
  
  /////////////
  // CPU Inputs
  /////////////
  logic clk12x;             //21.47727MHz clock input, this needs to be divided by 12
  logic reset;              //(ACTIVE LOW) resets the cpu, reset vector address is 0xFFFC
  logic irq;                //(ACTIVE LOW) Interrupt pin.
  logic nmi;                //(ACTIVE LOW) NonMaskable Interrupt pin, connected to interrupt pin on PPU
  logic [7:0] dataIn;       //CPU data input NOTE: on NES this is combined with dataOut
  
  //////////////
  // CPU Outputs
  //////////////
  logic [15:0] addressOut; //Used for addressing ROM, RAM, PPU, and ALU(audio)
  logic [7:0] dataOut;     // CPU data output NOTE: data in and out are same pins on NES
  logic RW;                //Read/Write of the CPU, read is HIGH, write is LOW.
  logic [1:0] OE;          //(ACTIVE LOW) output enable for the two controllers.
  logic [2:0] Out;         //output pins for the controllers
  logic [7:0] Aux1;        //audio output channel 1 (size may not be ideal)
  logic [7:0] Aux2;        //audio output channel 2 (size may not be ideal)
  
  
  /////////////
  // ROM Inputs
  /////////////
//>>//input logic [15:0] addressIn;   //Used for addressing ROM, RAM, PPU, and ALU(audio)
  
  //////////////
  // ROM Outputs
  //////////////
//>>//output logic [7:0] dataOut;    //Used for addressing ROM, RAM, PPU, and ALU(audio)
  
  
  NesCpu theTestBoi(clk12x, reset, irq, nmi, dataIn, addressOut, dataOut, RW, OE, Out, Aux1, Aux2);
  NesProgRom theMemBoi(clk12x, reset, /*This boi thinks this is an input*/addressOut, /*This boi thinks this is an output*/dataIn);
    
    
  initial
    begin 
      clk12x = 0;
    end
  
  always
    begin
      #5 clk12x =  ! clk12x;
    end 
  
  always_ff @(posedge clk12x)
    begin
      if(count < 256)
        begin
          count <= count +1;
          if(count == 0 )
            begin
              reset <= 1;
            end
          if(count > 0)
            begin
              reset <= 0;
            end
        end
      else
        begin
          count <= 0;
        end
       
    end

endmodule 

 
module NesCpu(clk12x, reset, irq, nmi, dataIn, addressOut, dataOut, RW, OE, Out, Aux1, Aux2);

  parameter CPU_RESET_ADDRESS = 16'h03FE;
  parameter SMALL_COUNT = 12;
  parameter SMALLER_COUNT = 6;
  
  /////////////
  // CPU Inputs
  /////////////
  input logic clk12x;             //21.47727MHz clock input, this needs to be divided by 12
  input logic reset;              //(ACTIVE LOW) resets the cpu, reset vector address is 0xFFFC
  input logic irq;                //(ACTIVE LOW) Interrupt pin.
  input logic nmi;                //(ACTIVE LOW) NonMaskable Interrupt pin, connected to interrupt pin on PPU
  input logic [7:0] dataIn;       //CPU data input NOTE: on NES this is combined with dataOut
  
  //////////////
  // CPU Outputs
  //////////////
  output logic [15:0] addressOut; //Used for addressing ROM, RAM, PPU, and ALU(audio)
  output logic [7:0] dataOut;     // CPU data output NOTE: data in and out are same pins on NES
  output logic RW;                //Read/Write of the CPU, read is HIGH, write is LOW.
  output logic [1:0] OE;          //(ACTIVE LOW) output enable for the two controllers.
  output logic [2:0] Out;         //output pins for the controllers
  output logic [7:0] Aux1;        //audio output channel 1 (size may not be ideal)
  output logic [7:0] Aux2;        //audio output channel 2 (size may not be ideal)
  
  //Some administrative stuff
  logic clkNE;             //Negative edge of 21.47727MHz divided by 12 (?)
  logic clkPE;             //Positive edge of 21.47727MHz divided by 12 (?)
  logic [7:0] count;       //Count of how many 12x clocks have happened
  
  //Okay, now for some other bizzness
  logic [7:0]  data;
  logic [7:0]  oldData;
  logic [7:0]  olderData;
  logic [7:0]  stage;
  logic [7:0]  instruction;
  
  //Internal registers of import
  logic [15:0] programCounterPC;
  logic [7:0]  accumulatorAC;
  logic [7:0]  Xregister;
  logic [7:0]  Yregister;
  logic [7:0]  statusRegisterSR;
  logic [7:0]  stackPointerSP;
  
  //Status register flags
  logic negativeN;
  logic overflowV;
  logic ignored;
  logic breakB;
  logic decimalD;
  logic interruptI;
  logic zeroZ;
  logic carryC;
  
  assign statusRegisterSR[7:0] = {negativeN,overflowV,ignored,breakB,decimalD,interruptI,zeroZ,carryC};
  //
  //
  //
  //
  //
  //
  //
  //
  
  logic negativeN_ANDY;
  logic zeroZ_ANDY;
  logic [7:0]  stage_ANDY;
  logic [15:0] programCounterPC_ANDY;
  logic [15:0] addressOut_ANDY;
  logic [7:0] accumulatorAC_ANDY;
  
  ANDY HeWasNumberOne(stage,accumulatorAC,programCounterPC,addressOut, dataIn,
  negativeN_ANDY,zeroZ_ANDY,stage_ANDY, programCounterPC_ANDY, addressOut_ANDY, accumulatorAC_ANDY);
  //
  //
  //
  //
  //
  //
  //
  always_ff @(posedge clk12x)
    begin
      if(reset) //If the reset pin is low, default values
        begin
          clkPE <= 1;
          clkNE <= 0;
          count <= 1;
        end
        
      else //If the reset pin is not high, operate
        begin
          if(count % 6 == 0)
            begin
              clkPE <= !clkPE;
              clkNE <= !clkNE;
              //if(count >= SMALL_COUNT)
              //  begin
              //    count <= count-5;
              //  end
              //else
              //  begin
                  count <= count + 1;
              //  end
            end
          else
            begin
              count <= count + 1;
            end
        end
    end
    
    
  //Do negedge stuff
  always_ff @(posedge clkNE)
    begin
      //Load the data from the address we put out on posedge
      data <= dataIn;
      oldData <= data;
      olderData <= oldData;
      if(stage == 0)
        begin
          instruction <= dataIn;
        end
      //Accumulator flag updates
//>>//THESE NEED TO ONLY BE DONE WITHIN INSTRUCTIONS WHICH ALTER THE ACCUMULATOR
//>>//CHANGE LATER WHEN LESS LAZY
      //negativeN <= accumulatorAC[7];
      if(accumulatorAC == 0)
        begin
          //zeroZ <= 1;
        end
      else
        begin
          //zeroZ <= 0;
        end
    end
  
  //Do posedge stuff
  always_ff @(posedge clkPE)
    begin
      //Operate on the data that we just got and put the address out for the new data
      //Initial behavior to prime the pumps
      if(count < 2)//< SMALLER_COUNT)
        begin
          instruction <= 8'h4C;
          addressOut <= CPU_RESET_ADDRESS;
          stage <= 2;
          programCounterPC <= CPU_RESET_ADDRESS;
          accumulatorAC <= 8'hff;
          Xregister <= 0;
          Yregister <= 0;
          stackPointerSP <= 0;
          //negativeN <= 0;
          overflowV <= 0;
          ignored <= 0;
          breakB <= 0;
          decimalD <= 0;
          interruptI <= 0;
          //zeroZ <= 0;
          carryC <= 0;
        end
      //And now for more regular stuff
      else
        begin
          //Instruction structure:
            //Update stage
              //(stage will be zero if the instruction was loaded in)
              //(stage MUST be set to zero to load the next instruction)
        //>>//DO MORE STUFF
          
          
          
          case(instruction)
            //BRK
            8'h00  :
              begin
                //Update the Program Counter
                programCounterPC <= programCounterPC + 1;
                addressOut <= programCounterPC + 1;
              end
              
            //AND
            8'h29 :
              begin
                /*
                //Update the Program Counter
                programCounterPC <= programCounterPC + 1;
                addressOut <= programCounterPC + 1;
                if(stage == 0)
                  begin
                    stage <= 1;
                  end
                else if(stage == 1)
                  begin
                    accumulatorAC <= accumulatorAC & data;
                    stage <= 0;
                  end
                  */
                    negativeN <= negativeN_ANDY;
                    zeroZ <= zeroZ_ANDY;
                    stage <= stage_ANDY;
                    programCounterPC <= programCounterPC_ANDY;
                    addressOut <= addressOut_ANDY;
                    accumulatorAC <= accumulatorAC_ANDY;
                /*ANDYT( .stage_in(stage), .accumulatorAC_in(accumulatorAC), .programCounterPC_In(programCounterPC), .address_In(addressOut) .data_In(dataIn),
                   .negativeN_Out(negativeN), .zeroZ_Out(zeroZ), .programCounterPC_Out(programCounterPC), .address_Out(address_Out), .stage_Out(stage), 
                   .accumulatorAC_Out(accumulatorAC));*/
              /*ANDYT( stage,accumulatorAC, programCounterPC, addressOut,dataIn,
                    negativeN, zeroZ);*/
              end
            //SEI
            8'h78 :
              begin
                //Update the Program Counter
                programCounterPC <= programCounterPC + 1;
                addressOut <= programCounterPC + 1;
                if(stage == 0)
                  begin
                    stage <= 1;
                    interruptI <= 1;
                  end
                else if(stage == 1)
                  begin
                    stage <= 0;
                  end
              end
            //JMP
            8'h4C :
              begin
                
              end
            //LDX
            8'hA2 :
              begin
                //Update the Program Counter
                programCounterPC <= programCounterPC + 1;
                addressOut <= programCounterPC + 1;
                if(stage == 0)
                  begin
                    stage <= 1;
                  end
                else if(stage == 1)
                  begin
                    Xregister <= data;
                    stage <= 0;
                  end
              end
            //LDA
            8'hA9 :
              begin
                //Update the Program Counter
                programCounterPC <= programCounterPC + 1;
                addressOut <= programCounterPC + 1;
                if(stage == 0)
                  begin
                    stage <= 1;
                  end
                else if(stage == 1)
                  begin
                    accumulatorAC <= data;
                    stage <= 0;
                  end
              end
            //CLD
            8'h78 :
              begin
                //Update the Program Counter
                programCounterPC <= programCounterPC + 1;
                addressOut <= programCounterPC + 1;
                if(stage == 0)
                  begin
                    stage <= 1;
                    decimalD <= 0;
                  end
                else if(stage == 1)
                  begin
                    stage <= 0;
                  end
              end
            //NOP
            8'hEA :
              begin
                //Update the Program Counter
                programCounterPC <= programCounterPC + 1;
                addressOut <= programCounterPC + 1;
              end
            //BEQ
            8'hF0 :
              begin
                if(stage == 0)
                  begin
                    //Update the Program Counter
                    programCounterPC <= programCounterPC + 1;
                    addressOut <= programCounterPC + 1;
                    //Kick it
                    stage <= 1;
                  end
                else if(stage == 1)
                  begin
                    if(zeroZ == 1)
                      begin
                        //Update the Program Counter
                        if(data[7:7] == 1)
                          begin
                            programCounterPC <= programCounterPC + {8'hFF,data} + 1;
                            addressOut <= addressOut + {8'hFF,data} + 1;
                          end
                        else
                          begin
                            programCounterPC <= programCounterPC + data + 1;
                            addressOut <= programCounterPC + data + 1;
                          end
                      end
                    else
                      begin
                        //Update the Program Counter
                        programCounterPC <= programCounterPC + 1;
                        addressOut <= programCounterPC + 1;
                      end
                    stage <= 0;
                  end
              end
            //DEFAULT  
            default :
              begin
                
              end
          endcase
          
        end
        
    end 
  
endmodule

module NesProgRom(clk12x, reset, addressIn, dataOut);

  input logic clk12x;              //21.47727MHz clock input, this "needs" to be divided by 12
  input logic reset;              //(ACTIVE LOW) resets the cpu, reset vector address is 0xFFFC
  input logic [15:0] addressIn;   //Used for addressing ROM, RAM, PPU, and ALU(audio)
  output logic [7:0] dataOut;    //Used for addressing ROM, RAM, PPU, and ALU(audio)
  
  logic [7:0]ROM[1024];
  initial $readmemh("../../../../../FAKEROM.hex", ROM);
  
  always_ff @(posedge clk12x)
    begin
      if(reset)
        begin
          dataOut <= 8'h00;
        end
      else
        begin
          dataOut <= ROM[addressIn[9:0]];
          /*if(addressIn[2:0] == 0)
            begin
              dataOut <= 8'h02;
            end
          else if (addressIn[2:0] == 1)
            begin
              dataOut <= 8'h00;
            end
          else if (addressIn[2:0] == 2)
            begin
              dataOut <= 8'hA9;
            end
          else if (addressIn[2:0] == 3)
            begin
              dataOut <= 8'h00;
            end
          else if (addressIn[2:0] == 4)
            begin
              dataOut <= 8'hF0;
            end
          else if (addressIn[2:0] == 5)
            begin
              dataOut <= 8'h00;
            end
          else if (addressIn[2:0] == 6)
            begin
              dataOut <= 8'hF0;
            end
          else if (addressIn[2:0] == 7)
            begin
              dataOut <= 8'hFA;
            end
          else
            begin
              dataOut <= 8'hDB;
            end*/
      end
    end
endmodule

module ANDY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In,
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out);
            
  input logic [7:0] stage_In;
  input logic [7:0] accumulatorAC_In;
  input logic [15:0] programCounterPC_In;
  input logic [15:0] address_In;
  input logic [7:0] data_In;
  output logic negativeN_Out;
  output logic zeroZ_Out;
  output logic [15:0] programCounterPC_Out;
  output logic [15:0] address_Out;
  output logic [7:0] stage_Out;
  output logic [7:0] accumulatorAC_Out;
  
  always_comb
    begin
      //Update the Program Counter
      programCounterPC_Out = programCounterPC_In + 1;
      address_Out = programCounterPC_In + 1;
      
      if(stage_In == 0)
        begin
          stage_Out = 1;
        end
      else if(stage_In == 1)
        begin
          accumulatorAC_Out = accumulatorAC_In & data_In;
          stage_Out = 0;
        end
    end
endmodule

module JMPY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In,
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out);
  input logic [7:0] stage_In;
  input logic [7:0] accumulatorAC_In;
  input logic [15:0] programCounterPC_In;
  input logic [15:0] address_In;
  input logic [7:0] data_In;
  output logic negativeN_Out;
  output logic zeroZ_Out;
  output logic [15:0] programCounterPC_Out;
  output logic [15:0] address_Out;
  output logic [7:0] stage_Out;
  output logic [7:0] accumulatorAC_Out;
  output logic [7:0] oldData_In;
  
  always_comb
    begin
      //Update the Program Counter
      programCounterPC_Out = programCounterPC_In + 1;
      address_Out = programCounterPC_In + 1;
      
      if(stage_In == 0)
        begin
          //Update the Program Counter
          programCounterPC_Out <= programCounterPC_In + 1;
          address_Out <= programCounterPC_In + 1;
          stage_Out <= 2;
        end
      else if(stage_In == 2)
        begin
          //Update the Program Counter
          programCounterPC_Out <= programCounterPC_In + 1;
          address_Out <= programCounterPC_In + 1;
          //Load low byte
          stage_Out <= 1;
        end
      else if(stage_In == 1)
        begin
          //Update the Program Counter
          programCounterPC_Out <= {data_In,oldData_In};
          address_Out <= {data_In,oldData_In};
          //Load high byte
          stage_Out <= 0;
        end
    end
endmodule

module LDAY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In,           
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out);//Update the Program Counter
  
    input logic [7:0] stage_In;
    input logic [7:0] accumulatorAC_In;
    input logic [15:0] programCounterPC_In;
    input logic [15:0] address_In;
    input logic [7:0] data_In;
    output logic negativeN_Out;
    output logic zeroZ_Out;
    output logic [15:0] programCounterPC_Out;
    output logic [15:0] address_Out;
    output logic [7:0] stage_Out;
    output logic [7:0] accumulatorAC_Out;
    output logic [7:0] oldData_In;
    
    always_comb
       begin
        programCounterPC_Out <= programCounterPC_In + 1;
        address_Out <= programCounterPC_In + 1;
        if(stage_In == 0)
          begin
            stage_Out <= 1;
          end
        else if(stage_In == 1)
          begin
            accumulatorAC_Out <= data_In;
            stage_Out <= 0;
          end
      end
endmodule

module NOPY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In,           
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out);
    input logic [7:0] stage_In;
    input logic [7:0] accumulatorAC_In;
    input logic [15:0] programCounterPC_In;
    input logic [15:0] address_In;
    input logic [7:0] data_In;
    output logic negativeN_Out;
    output logic zeroZ_Out;
    output logic [15:0] programCounterPC_Out;
    output logic [15:0] address_Out;
    output logic [7:0] stage_Out;
    output logic [7:0] accumulatorAC_Out;
    output logic [7:0] oldData_In;
    
    always_comb
    begin
        //Update the Program Counter
        programCounterPC_Out <= programCounterPC_In + 1;
        address_Out <= programCounterPC_In + 1;
    end
endmodule

module BEQY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In,           
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out);
    input logic [7:0] stage_In;
    input logic [7:0] accumulatorAC_In;
    input logic [15:0] programCounterPC_In;
    input logic [15:0] address_In;
    input logic [7:0] data_In;
    output logic negativeN_Out;
    output logic zeroZ_Out;
    output logic [15:0] programCounterPC_Out;
    output logic [15:0] address_Out;
    output logic [7:0] stage_Out;
    output logic [7:0] accumulatorAC_Out;
    output logic [7:0] oldData_In;
    
    always_comb
    begin
        if(stage_In == 0)
          begin
            //Update the Program Counter
            programCounterPC_Out <= programCounterPC_In + 1;
            address_Out <= programCounterPC_In + 1;
            //Kick it
            stage_Out <= 1;
          end
        else if(stage_In == 1)
          begin
            if(zeroZ_Out == 1)
              begin
                //Update the Program Counter
                if(data_In[7:7] == 1)
                  begin
                    programCounterPC_Out <= programCounterPC_In + {8'hFF,data_In} + 1;
                    address_Out <= address_Out + {8'hFF,data_In} + 1;
                  end
                else
                  begin
                    programCounterPC_Out <= programCounterPC_In + data_In + 1;
                    address_Out <= programCounterPC_In + data_In + 1;
                  end
              end
            else
              begin
                //Update the Program Counter
                programCounterPC_Out <= programCounterPC_In + 1;
                address_Out <= programCounterPC_In + 1;
              end
            stage_Out <= 0;
          end
    end
endmodule

module CLDY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In, decimalD_In,           
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out, decimalD_Out);
            
    input logic [7:0] stage_In;
    input logic [7:0] accumulatorAC_In;
    input logic [15:0] programCounterPC_In;
    input logic [15:0] address_In;
    input logic [7:0] data_In;
    output logic negativeN_Out;
    output logic zeroZ_Out;
    output logic [15:0] programCounterPC_Out;
    output logic [15:0] address_Out;
    output logic [7:0] stage_Out;
    output logic [7:0] accumulatorAC_Out;
    output logic [7:0] oldData_In;
    input logic decimalD_In;
    output logic decimalD_Out;
    
    always_comb
    begin
        //Update the Program Counter
        programCounterPC_Out <= programCounterPC_In + 1;
        address_Out <= programCounterPC_In + 1;
        if(stage_In == 0)
          begin
            stage_Out <= 1;
            decimalD_Out <= 0;
          end
        else if(stage_In == 1)
          begin
            stage_Out <= 0;
          end
    end
endmodule

module LDXY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In, decimalD_In,           
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out, decimalD_Out, Xregister_Out);
            
    input logic [7:0] stage_In;
    input logic [7:0] accumulatorAC_In;
    input logic [15:0] programCounterPC_In;
    input logic [15:0] address_In;
    input logic [7:0] data_In;
    output logic negativeN_Out;
    output logic zeroZ_Out;
    output logic [15:0] programCounterPC_Out;
    output logic [15:0] address_Out;
    output logic [7:0] stage_Out;
    output logic [7:0] accumulatorAC_Out;
    output logic [7:0] oldData_In;
    input logic decimalD_In;
    output logic decimalD_Out;
    output logic [7:0]Xregister_Out;
    
    always_comb
    begin
        //Update the Program Counter
        programCounterPC_Out <= programCounterPC_In + 1;
        address_Out <= programCounterPC_In + 1;
        if(stage_In == 0)
          begin
            stage_Out <= 1;
          end
        else if(stage_In == 1)
          begin
            Xregister_Out <= data_In;
            stage_Out <= 0;
          end
    end
endmodule

module BRKY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In,           
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out);
    input logic [7:0] stage_In;
    input logic [7:0] accumulatorAC_In;
    input logic [15:0] programCounterPC_In;
    input logic [15:0] address_In;
    input logic [7:0] data_In;
    output logic negativeN_Out;
    output logic zeroZ_Out;
    output logic [15:0] programCounterPC_Out;
    output logic [15:0] address_Out;
    output logic [7:0] stage_Out;
    output logic [7:0] accumulatorAC_Out;
    output logic [7:0] oldData_In;
    
    always_comb
    begin
        //Update the Program Counter
        programCounterPC_Out <= programCounterPC_In + 1;
        address_Out <= programCounterPC_In + 1;
    end
endmodule

module SEIY(stage_In,accumulatorAC_In,programCounterPC_In,address_In, data_In, oldData_In,           
            negativeN_Out,zeroZ_Out,stage_Out, programCounterPC_Out, address_Out, accumulatorAC_Out, interruptI_Out);
    input logic [7:0] stage_In;
    input logic [7:0] accumulatorAC_In;
    input logic [15:0] programCounterPC_In;
    input logic [15:0] address_In;
    input logic [7:0] data_In;
    output logic negativeN_Out;
    output logic zeroZ_Out;
    output logic [15:0] programCounterPC_Out;
    output logic [15:0] address_Out;
    output logic [7:0] stage_Out;
    output logic [7:0] accumulatorAC_Out;
    output logic [7:0] oldData_In;
    output logic interruptI_Out;
    
    always_comb
    begin
        //Update the Program Counter
        programCounterPC_Out <= programCounterPC_In + 1;
        address_Out <= programCounterPC_In + 1;
        if(stage_In == 0)
          begin
            stage_Out <= 1;
            interruptI_Out <= 1;
          end
        else if(stage_In == 1)
          begin
            stage_Out <= 0;
          end
    end
endmodule
/*task ANDYT;
   inout logic [7:0] stage_Inout;
   inout logic [7:0] accumulatorAC_Inout;
   inout logic [15:0] programCounterPC_Inout;
   inout logic [15:0] address_Inout;
   input logic [7:0] data_In;
   output logic negativeN_Out;
   output logic zeroZ_Out;
   
   //Update the Program Counter
   programCounterPC_Inout <= programCounterPC_Inout + 1;
   address_Inout <= programCounterPC_Inout + 1;
   
   if(stage_Inout == 0)
     begin
       stage_Inout <= 1;
     end
   else if(stage_Inout == 1)
     begin
       accumulatorAC_Inout <= accumulatorAC_Inout & data_In;
       stage_Inout <= 0;
     end

 endtask*/