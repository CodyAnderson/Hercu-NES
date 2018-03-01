
module CpuCommunicator(
  input logic[2:0] addr,

  input logic[7:0] ppuDataIn, //Data external input
  output logic[7:0] ppuDataOut, //Data external output

  input logic rw,
  input logic cs,

  input logic[7:0] dataIn, //Data internal input
  output logic[7:0] dataOut, //Data internal output
  

  
  output logic ppuRW,
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

always_comb
begin
  if(cs == 0)
    cableSelectBundle = 1 << addr;
  else
    cableSelectBundle = 0;

  if(cs == 0 && rw == 0)
    dataOut = ppuDataIn;
  else
    dataOut = 'bZ;

  if(cs == 0 && rw == 1)
    ppuDataOut = dataIn;
  else
    ppuDataOut = 'bZ;

  {ramData_EN, ramAddr_EN, scroll_EN, oamData_EN, oamAddr_EN, status_EN, mask_EN, control_EN} = cableSelectBundle;

end

endmodule // CpuCommunicator
