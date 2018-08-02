`timescale 1ns / 1ps
         //////////////////////////////////////////////////////////////////////////////////
        // Company: Da Peen
       // Engineer: Ben Nollan
      //  
     // Create Date: 08/01/2018
    // Module Name: DataBusses
   // Project Name: Hercu-NES
  // Description: Takes CPU data busses and combines them in a friendly way.
 //
//////////////////////////////////////////////////////////////////////////////////

module DataBusses (
    input O_ADH0,
    input O_ADH1_7,

    input O_ADL0,
    input O_ADL1,
    input O_ADL2,

    input SB_ADH,
    input SB_DB,



    input  [7:0]DB_fromModules,
    input  [7:0]SB_fromModules,
    input  [7:0]ADL_fromModules,
    input  [7:0]ADH_fromModules,

    output [7:0]DB_toModules,
    output [7:0]SB_toModules,
    output [7:0]ADH_toModules,
    output [7:0]ADL_toModules
);


  //////////////
 // ADL Handler
//////////////

logic [7:0] O_ADL;
assign O_ADL = {5'b11111, O_ADL2, O_ADL1, O_ADL0};
assign ADL_toModules = ADL_fromModules & O_ADL;

  //////////////
 // ADH Handler
//////////////

logic [7:0] O_ADH;
assign O_ADH = {O_ADH1_7, O_ADH1_7, O_ADH1_7, O_ADH1_7, O_ADH1_7, O_ADH1_7, O_ADH1_7, O_ADH0};
logic [7:0] ADH_INT;
assign ADH_INT = ADH_fromModules & O_ADH;
always_comb
begin
    if(SB_ADH)
    begin
        if(SB_DB)
        begin
            ADH_toModules = ADH_INT & SB_fromModules & DB_fromModules;
        end
        else
        begin
            ADH_toModules = ADH_INT & SB_fromModules;
        end
    end
    else
    begin
        ADH_toModules = ADH_INT;
    end
end

  /////////////
 // SB Handler
/////////////
always_comb
begin
    if(SB_DB)
    begin
        if(SB_ADH)
        begin
            SB_toModules = SB_fromModules & DB_fromModules & ADH_INT;
        end
        else
        begin
            SB_toModules = SB_fromModules & DB_fromModules;
        end
    end
    else
    begin
        if(SB_ADH)
        begin
            SB_toModules = SB_fromModules & ADH_INT;
        end
        else
        begin 
            SB_toModules = SB_fromModules;
        end
    end
end


  //////////////
 //  DB Handler
//////////////

always_comb
begin
    if(SB_DB)
    begin
        if(SB_ADH)
        begin
            DB_toModules = SB_fromModules & DB_fromModules & ADH_INT;
        end
        else
        begin
            DB_toModules = SB_fromModules & DB_fromModules;
        end
    end
    else
    begin
        DB_toModules = DB_fromModules;
    end
end

endmodule