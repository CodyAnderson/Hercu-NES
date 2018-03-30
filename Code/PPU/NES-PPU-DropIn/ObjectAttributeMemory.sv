module ObjectAttributeMemory(
    input logic clock,
    input logic clock_EN,
    input logic write,
    input logic [7:0] address,
    input logic [7:0] dataIn,
    output logic [7:0] dataOut
);

reg [7:0] memoryBlock[256];

reg [35:0][7:0] insertionBlock = {  8'h18,8'hff,8'h23,8'h58,
                                8'hb0,8'hfc,8'h00,8'h28,
                                8'hb0,8'hfc,8'h00,8'h30,
                                8'hb8,8'hfc,8'h00,8'h28,
                                8'hb8,8'hfc,8'h00,8'h30,
                                8'hc0,8'h3a,8'h00,8'h28,
                                8'hc0,8'h37,8'h00,8'h30,
                                8'hc8,8'h4f,8'h00,8'h28,
                                8'hc8,8'h4f,8'h40,8'h30};
initial
begin
    for(integer i = 0; i < 256; i=i+1)
    begin
        if(i < 9*4)
            memoryBlock[i] = insertionBlock[35-i];
        else
        begin
            if(i % 4 == 0)
                memoryBlock[i] = 'hF8;
            else
                memoryBlock[i] = 'h00;
        end
    end
end
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

endmodule