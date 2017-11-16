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
	output [9:0]LEDR,
	output CON1_D1
	
	);
	
<<<<<<< HEAD
	assign PPU_RD = 0;
	assign ROMSEL = 0;
	assign LEDG = PPU_D;
	assign PPU_WR = 1;
	
	logic [14:0]address = 0;
	assign PPU_A = address;//address;
	logic newData = 0;
	logic [7:0]data = 0;
	logic done;
=======
	//assign PPU_RD = 0;
	//assign ROMSEL = 0;
	
	
	logic [15:0] addressOut = 0;
	//assign CPU_A = {5'b0,SW};//address;
	//logic newData = 0;
	logic [7:0] data;
	//logic done;
	
	
	logic [26:0]clockDivider = 0;
	logic clock = 1;
	
	assign LEDG = data;
	
	assign LEDR[9] = clock;
	assign LEDR[8:3] = 6'b000000;
	assign LEDR[2:0] = addressOut[2:0];
	
	//UartTransmit uart(CLOCK_50, newData, data, CON1_D1, done);
	NesCpu(clock, {1'b0}, IRQ, {1'b0}, data, addressOut, , , , , , );
>>>>>>> refs/remotes/origin/Cody
	
	always_ff@(posedge CLOCK_50)
	begin
<<<<<<< HEAD
		if(done && SW[0] && !address[14] && !newData)
		begin
			newData <= 1;
			data <= PPU_D;
			address <= address + 1;
=======
		clockDivider <= clockDivider + 1;
		clock <= clockDivider[26];
	end
	
	always_ff@(negedge clock)
	begin
		if(addressOut[2:0] == 0)
		begin
			data <= 8'hF0;
		end
		else if (addressOut[2:0] == 1)
		begin
			data <= 8'h03;
		end
		else if (addressOut[2:0] == 2)
		begin
			data <= 8'h00;
		end
		else if (addressOut[2:0] == 3)
		begin
			data <= 8'hF0;
		end
		else if(addressOut[2:0] == 4)
		begin
			data <= 8'h00;
		end
		else if (addressOut[2:0] == 5)
		begin
			data <= 8'h00;
>>>>>>> refs/remotes/origin/Cody
		end
		else if (addressOut[2:0] == 6)
		begin
			data <= 8'hFF;
		end
		else if (addressOut[2:0] == 7)
		begin
			data <= 8'hFF;
		end
	end
	
endmodule