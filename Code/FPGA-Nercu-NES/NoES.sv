module NoES(
	input CLOCK_50, 
	input CIRAM_A10,
	input CIRAM_CE,
	input IRQ,
	
	inout [7:0] CPU_D,
	inout [7:0] PPU_D,
	
	
	
	output CPU_RW,
	output PPU_RD,
	output SYSTEM_CLK,
	output M2,
	output ROMSEL,
	output PPU_WR,
	output PPU_A13, //(Inverse of A13) 
	output [14:0]CPU_A, 
	output [13:0]PPU_A,
	
	input [9:0]SW,
	output [7:0]LEDG,
	output CON1_D1
	
	);
	
	assign PPU_RD = 0;
	assign ROMSEL = 0;
	assign LEDG = PPU_D;
	assign PPU_WR = 1;
	
	logic [14:0]address = 0;
	assign PPU_A = address;//address;
	logic newData = 0;
	logic [7:0]data = 0;
	logic done;
	
	UartTransmit uart(CLOCK_50, newData, data, CON1_D1, done);
	always_ff@(posedge CLOCK_50)
	begin
		if(done && SW[0] && !address[14] && !newData)
		begin
			newData <= 1;
			data <= PPU_D;
			address <= address + 1;
		end
		else
		begin
			newData <= 0;
		end
		if(!SW[0])
		begin
			address <= 0;
		end
		
	end
	
endmodule