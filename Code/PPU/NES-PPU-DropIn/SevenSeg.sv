module SevenSeg(
    input logic[3:0] numIn,
    output logic[6:0] hexOut
    );

always_comb
    case(numIn)
       0:  hexOut  =  'b1000000; //0
       1:  hexOut  =  'b1111001; //1
       2:  hexOut  =  'b0100100; //2
       3:  hexOut  =  'b0110000; //3
       4:  hexOut  =  'b0011001; //4
       5:  hexOut  =  'b0010010; //5
       6:  hexOut  =  'b0000010; //6
       7:  hexOut  =  'b1111000; //7
       8:  hexOut  =  'b0000000; //8 
       9:  hexOut  =  'b0010000; //9
      10:  hexOut  =  'b0001000; //A
      11:  hexOut  =  'b0000011; //b
      12:  hexOut  =  'b1000110; //c
      13:  hexOut  =  'b0100001; //d
      14:  hexOut  =  'b0000110; //e
      15:  hexOut  =  'b0001110; //f
    endcase

endmodule // SevenSeg