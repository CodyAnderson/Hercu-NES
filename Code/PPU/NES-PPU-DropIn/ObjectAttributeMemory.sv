module ObjectAttributeMemory(
    input logic clock,
    input logic clock_EN,
    input logic write,
    input logic [7:0] address,
    input logic [7:0] dataIn,
    output logic [7:0] dataOut
);

reg [7:0] memoryBlock[256];

assign dataOut = memoryBlock[address];

always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(write)
            memoryBlock[address] <= dataIn;
        //else
            //dataOut <= memoryBlock[address];
    end
end

endmodule

module ObjectAttributeMemorySecondary(
    input logic clock,
    input logic clock_EN,
    input logic write,
    input logic [4:0] address,
    input logic [7:0] dataIn,
    output logic [7:0] dataOut
);

reg [7:0] memoryBlock[32];

assign dataOut = memoryBlock[address];

always_ff@(posedge clock)
begin
    if(clock_EN)
    begin
        if(write)
            memoryBlock[address] <= dataIn;
        //else
            //dataOut <= memoryBlock[address];
    end
end