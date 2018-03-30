module VRAMSetterGetter(
    input logic clock_IN,
    input logic clock_EN,
    input logic cpuDataRW_SEL,
    input logic activationTrigger,
    input logic renderMode,
    input logic [1:0]memStager,
    output logic operationDone,
    input logic [14:0]address_IN,
    input logic [7:0]data_IN,
    output wire [7:0]data_OUT,
    output wire [7:0]dataRender_OUT,

    //To the memory bus
    inout logic [13:0]addressData_IN_OUT,
    output logic addressLatch_EN,
    output logic read_EN,
    output logic write_EN

    );

//logic [1:0]memStager = 0;
logic addressPosSelector = 0;
logic [7:0]memDataBuffer = 0;
logic almostReadTime = 0;
logic memGetEnable = 0;
logic queueMemGet = 0;
logic memRW = 1;
logic activationTrigger_PREV = 0;

logic operationAcivate;
assign operationAcivate = (memGetEnable | renderMode) && address_IN < 'h3f00;

assign (strong0, weak1) data_OUT = cpuDataRW_SEL ? memDataBuffer : 'bz;
assign addressLatch_EN = (memStager == 0) & operationAcivate;
assign write_EN = !(memStager == 2) | memRW | !operationAcivate; //Active LOW
assign read_EN = !(memStager >= 2) | !memRW | !operationAcivate; //Active LOW
assign (strong0, weak1) addressData_IN_OUT[13:8] = address_IN[13:8];
assign (strong0, weak1) addressData_IN_OUT[7:0] = (memStager >= 2 & operationAcivate) ? (memRW ? 'bZ : memDataBuffer) : address_IN[7:0];
assign operationDone = memStager > 1 & memGetEnable;
assign dataRender_OUT = (memStager == 3) ? addressData_IN_OUT[7:0] : 8'bX;

always_ff@(posedge clock_IN)
begin
    if(activationTrigger == 0 && activationTrigger_PREV == 1) //Trigger lots as to not miss any data.
    begin
        queueMemGet <= 1;
        memDataBuffer <= data_IN;
    end

    if(activationTrigger == 1 && activationTrigger_PREV == 0)
    begin
        memRW <= cpuDataRW_SEL;
    end
    activationTrigger_PREV <= activationTrigger;
    if(clock_EN)
    begin
        if(memStager == 3)
        begin
            if(queueMemGet)
            begin
                memGetEnable <= 1;
                queueMemGet <= 0;
            end
            else
            begin
                if(memGetEnable)
                begin
                    memRW <= 1;
                    memGetEnable <= 0;
                end
            end
            
        end

        if (memStager == 3 && memRW == 1 && memGetEnable)
            memDataBuffer <= addressData_IN_OUT[7:0];
        
    end
end

endmodule // VRAMSetterGetter