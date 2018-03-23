module BackgroundPixelGen(
    input logic clock,
    input logic clock_EN,
    input logic enable,
    input logic loadIn,
    input logic [1:0]tileAttr,
    input logic [7:0]tileHighByte,
    input logic [7:0]tileLowByte,
    input logic [2:0]fineScroll,
    output logic [4:0]pixelIndex
    );

logic oldLoad = 0;
logic [15:0] shiftyHigh, shiftyLow;
logic [9:0] shiftyAttrHigh, shiftyAttrLow;

always_ff@(posedge clock)
begin
  if(clock_EN)
  begin
      if(enable)
      begin
          shiftyHigh <= shiftyHigh << 1;
          shiftyLow <= shiftyLow << 1;
          shiftyAttrHigh <= {tileAttr[1],shiftyAttrHigh[9:1]};
          shiftyAttrLow <= {tileAttr[0],shiftyAttrLow[9:1]};
      end

      if(oldLoad)
      begin
          shiftyHigh[7:0] <= tileHighByte;
          shiftyLow[7:0] <= tileLowByte;
      end
      oldLoad <= loadIn;
  end
end

logic [4:0]currentPixel;
assign currentPixel = {1'b0, shiftyAttrHigh[fineScroll], shiftyAttrLow[fineScroll], shiftyHigh[15-fineScroll], shiftyLow[15-fineScroll]};
assign pixelIndex = enable ? currentPixel : 0;

endmodule // BackgroundPixelGen