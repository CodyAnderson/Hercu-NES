module MB74LS139(
      input[1:0]  enable, //(ACTIVE LOW) enables output
      //PINS 1,15
      input[1:0]  b,      //lsb selection bit
      //PINS 2,14
      input[1:0]  a,      //msb selection bit
      //PINS 3,13
      output[3:0] y1,     //first output unit
      //PINS 4,5,6,7
      output[3:0] y2      //second output unit
      //PINS 12,11,10,9
      );


assign  y1 = ~(!enable[0] << {b[0],a[0]});
assign  y2 = ~(!enable[1] << {b[1],a[1]});

endmodule // MB74LS139