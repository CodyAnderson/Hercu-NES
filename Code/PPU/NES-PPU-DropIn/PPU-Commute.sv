
module CpuCommunicator(
  input logic clock,
  input logic[2:0] addr,

  inout logic[7:0] ppuData_IN_OUT, //Data external inoutput

  input logic rw,
  output logic rwBuffered,
  input logic cs,

  input logic[7:0] dataIn, //Data internal input
  output logic[7:0] dataOut, //Data internal output
  
  output logic control_EN, //0
  output logic mask_EN,    //1
  output logic status_EN,  //2
  output logic oamAddr_EN, //3
  output logic oamData_EN, //4
  output logic scroll_EN,  //5
  output logic ramAddr_EN, //6
  output logic ramData_EN  //7
  
);

logic [7:0]cableSelectBundle;

logic[7:0] ppuDataIn; //Data external input
logic[7:0] ppuDataOut; //Data external output
logic[2:0] addrBuffered = 0;
logic selected = 0;
logic prevCS = 1;
always_ff @(posedge clock)
begin
  prevCS <= cs;
  if(prevCS == 1 && cs == 0) //negedge of cs with at least a width of two clock cycles
  begin                          //address and rw is valid at the negative edge
    selected <= 1;
    rwBuffered <= rw;
    addrBuffered <= addr;
  end
  if(prevCS == 0 && cs == 1) //posedge
  begin
    selected <= 0;
  end
end

assign ppuDataIn = ppuData_IN_OUT;
assign ppuData_IN_OUT = (rwBuffered & selected & !cs) ? ppuDataOut : 8'HZZ;

always_comb
begin
  if(selected)
    cableSelectBundle = 1 << addrBuffered;
  else
    cableSelectBundle = 0;

  if(selected && rwBuffered == 0)
    dataOut = ppuDataIn;
  else
    dataOut = 'bZ;

  if(selected && rwBuffered == 1)
    ppuDataOut = dataIn;
  else
    ppuDataOut = 'bZ;

  {ramData_EN, ramAddr_EN, scroll_EN, oamData_EN, oamAddr_EN, status_EN, mask_EN, control_EN} = cableSelectBundle;

end

endmodule // CpuCommunicator
