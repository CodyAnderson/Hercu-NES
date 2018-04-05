module VramController(
    input logic clock, // nes / 3
    input logic clock_EN,
    input logic cpuDataRW_SEL,
    input logic ramData_EN,  //7
    input logic [14:0]vRamAddress_REG,
    input logic [7:0]data_IN,
    output wire [7:0]data_OUT,
    output logic increment,
    input logic backgroundFetch_EN,
    input logic spriteFetch_EN,
    input logic dummyFetch_EN,
    input logic idle,
    input logic backgroundPatternTableAddress,
    input logic [11:0]spriteAddress_IN,
    output logic[1:0] tileAttribute_REG,
    output logic [7:0] tileLowByte,
    output logic [7:0] tileHighByte,
    output logic[7:0] dataRender_OUT,

    //To the memory bus
    inout wire [13:0]addressData_IN_OUT,
    output logic addressLatch_EN,
    output logic read_EN,
    output logic write_EN
    );


logic memRW;
assign memRW = cpuDataRW_SEL | backgroundFetch_EN | dummyFetch_EN; //Locks to reading memory if any tiles are being loaded.
logic renderMode;
assign renderMode = backgroundFetch_EN | spriteFetch_EN | dummyFetch_EN;


logic[7:0] tileAddress_REG;


logic [3:0]combinedStages = 0;
logic [1:0]readingStage;
assign readingStage = combinedStages[3:2];
logic [1:0]accessStage;
assign accessStage = combinedStages[1:0];

always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(idle)
            combinedStages <= 0;
        else
            combinedStages <= combinedStages + 1;
        if(dummyFetch_EN)
            combinedStages[3:2] <= 0;
    end
end


logic [14:0]memoryAddress;
always_comb
begin
    if(renderMode || idle)
    begin
        case(readingStage)
            0: begin
                if(spriteFetch_EN)
                    memoryAddress = {2'h0, spriteAddress_IN[11:3], 1'b0, spriteAddress_IN[2:0]};
                else
                    memoryAddress = {3'h2, vRamAddress_REG[11:0]};
            end
            1: begin
                if(spriteFetch_EN)
                    memoryAddress = {2'h0, spriteAddress_IN[11:3], 1'b1, spriteAddress_IN[2:0]};
                else
                    memoryAddress = {3'h2, vRamAddress_REG[11:10], 4'hF, vRamAddress_REG[9:7], vRamAddress_REG[4:2]};
                end
            2: begin
                if(spriteFetch_EN)
                    memoryAddress = {2'h0, spriteAddress_IN[11:3], 1'b0, spriteAddress_IN[2:0]};
                else
                    memoryAddress = {2'h0, backgroundPatternTableAddress, tileAddress_REG, 1'b0, vRamAddress_REG[14:12]};
            end
            3: begin
                if(spriteFetch_EN)
                    memoryAddress = {2'h0, spriteAddress_IN[11:3], 1'b1, spriteAddress_IN[2:0]};
                else
                    memoryAddress = {2'h0, backgroundPatternTableAddress, tileAddress_REG, 1'b1, vRamAddress_REG[14:12]};
            end
        endcase // readingStage
    end
    else
        memoryAddress = vRamAddress_REG;
end

always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(renderMode && accessStage == 3) //If the memory values have been read
        begin
            case(readingStage)
                0: tileAddress_REG <= dataRender_OUT;
                1: tileAttribute_REG <= dataRender_OUT >> {vRamAddress_REG[6], vRamAddress_REG[1], 1'b0};
                2: tileLowByte <= dataRender_OUT;
                3: tileHighByte <= dataRender_OUT;
            endcase
            /*if(dummyFetch_EN)
                readingStage <= 0;
            else
                readingStage <= readingStage + 1;*/
        end
    end
end

VRAMSetterGetter MemTouchyTouchy(
    clock,
    clock_EN,
    memRW,
    ramData_EN,
    renderMode,
    accessStage,
    increment,
    memoryAddress,
    data_IN,
    data_OUT,
    dataRender_OUT,

    //To the memory bus
    addressData_IN_OUT,
    addressLatch_EN,
    read_EN,
    write_EN
    );

endmodule // VramController