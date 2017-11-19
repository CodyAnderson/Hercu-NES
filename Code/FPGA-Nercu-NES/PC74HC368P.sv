module PC74HC368P(
        input[1:0] outputEnable,
        //PINS 1,15
        input[5:0] dataIn,
        //PINS 2,4,6,10,12,14
        output[5:0] dataOut);
        //PINS 3,5,7,9,11,13
assign dataOut[3:0] = outputEnable ? 'hZ : ~dataIn[3:0];
assign dataOut[5:4] = outputEnable ? 'hZ : ~dataIn[5:4];

endmodule // PC74HC368P
  