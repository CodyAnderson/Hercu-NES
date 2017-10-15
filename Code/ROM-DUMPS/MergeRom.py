with open('OursHeader.nes', 'wb') as outfile1: #Our ROM
    with open('Ours.nes', 'wb') as outfile2: #Our ROM no header
      with open('MarioHeader.bin', 'rb') as infile: 
          for each in range(16): #Hardcoded header size
              symbol = infile.read(1)
              outfile1.write(symbol)
      with open('MarioProg.bin', 'rb') as infile: 
          for each in range(32768): #Hardcoded PROG ROM size
              symbol = infile.read(1)
              outfile1.write(symbol)
              outfile2.write(symbol)
      with open('MarioChar.bin', 'rb') as infile: 
          for each in range(8192): #Hardcoded CHAR ROM size
              symbol = infile.read(1)
              outfile1.write(symbol)
              outfile2.write(symbol)
            