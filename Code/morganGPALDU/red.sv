<<<<<<< HEAD
module red(input logic [9:0]SW, input logic [1:0]CLOCK_24, output logic[9:0]LEDR, output logic [7:0]LEDG, output logic [3:0]VGA_B, output logic [3:0]VGA_G, output logic[3:0]VGA_R, output logic VGA_HS, output logic VGA_VS);

	logic div = 0;
	logic clk = 0;
	assign LEDR = SW;
	logic [11:0]Pixel; // ?
	logic shareCount;
	pixelGenerator gen(shareCount, clk, Pixel);
	vga hello(shareCount, Pixel[11:0], CLOCK_24[0], LEDG[7:0], VGA_B[3:0], VGA_R[3:0], VGA_G[3:0], VGA_HS, VGA_VS);
	
	
	always_ff @(posedge CLOCK_24[0]) begin
		shareCount <= shareCount + 1;
		if(div == 0)
			clk <= 1;
		else
			clk <= 0;

		div <= div + 1;
	end

endmodule

module vga(input logic shareCount, input logic [11:0]Pixel, input logic CLOCK_24, output logic [7:0]LEDG, output logic [3:0]VGA_B, output logic [3:0]VGA_R, output logic [3:0]VGA_G, output logic VGA_HS, output logic VGA_VS);
   logic [11:0]lines = 0;
   logic [11:0]pixels = 0;
	logic [11:0]RGB = 0;
   logic VSNC = 0;
   logic HSNC = 0;
	logic [11:0]buffer1[640];
	logic [11:0]buffer2[640];
	logic waitForClock = 0;
	logic [1:0]waitForBuffer;
	logic [1:0]getPixel;
	logic [10:0]i = 0;
	logic [11:0]pixIn;
	logic [11:0]scan = 0;
	logic [1:0]counter;
	
	assign counter = shareCount;
	
	assign VGA_R = RGB[11:8];
   assign VGA_G = RGB[7:4];
	assign VGA_B = RGB[3:0];
   assign VGA_VS = VSNC;
   assign VGA_HS = HSNC;
	assign waitForBuffer = lines[2:1];
	assign getPixel = pixels[2:1];
	assign pixIn = Pixel;
	
	parameter totalPixels = 640;
   parameter totalLines = 480;
   parameter hsw = 96;
   parameter hfp = 16;
   parameter hbp = 48;
   parameter vsw = 2;
   parameter vfp = 10;
   parameter vbp = 33;
	
	logic [11:0]colorful = 0;
	logic [1:0]row = 0;
	
	initial begin
	buffer1[0] = 12'b000;
		for(i = 1; i < 640; ++i) begin
			buffer1[i] = 12'hf00;
			buffer2[i] = 12'h0f0;
		end
	
	end

   always_ff @(posedge CLOCK_24) 
	begin 
		
		
		// Drawing color inside of 640only
		if(pixels >= 0 && pixels <= 640 && lines <= 480) 
		begin
				
				if(pixels % 2 == 0) begin
					if((lines % 2) == 0) begin
						buffer2[pixels] <= pixIn;
					end
					else begin
						buffer1[pixels] <= pixIn;
					end
		   	end
		
				if((lines % 2) == 0) begin
					RGB <= buffer1[pixels/2]; 
				end
				else begin
					RGB <= buffer2[pixels/2];
				end
		

		end
		else begin
			RGB <= 0;
		end


		// Set HSNC (after fp and before bp)
		if((pixels >= totalPixels + hfp) && (pixels < (totalPixels + hfp + hsw)) ) 
			HSNC = 1;
		else 
			HSNC <= 0;
			
		// Set VSNC (after fp and before bp)
		if( (lines >= (totalLines + vfp)) && (lines < (totalLines + vfp + vsw))) 
			VSNC <= 1;
		else 
			VSNC <= 0;
			
		// Reached the end display capacity, restart
		if(lines == totalLines + vfp + vsw + vbp) 
			lines <= 0; 
		
		// One more pixel drawn
		pixels <= pixels + 1;
		scan <= scan + 1;
		
		if(scan == totalPixels*2) begin
			scan <= 0;
		end
		
		// Next horizontal scan line
		if(pixels == totalPixels + hfp + hsw + hbp) 
		begin 
			pixels <= 0; 
			lines <= lines + 1; 
		end
			  
	end
    
endmodule

module pixelGenerator(input logic shareCount, input logic CLOCK_24, output logic [11:0]Pixel);

const logic[11:0]pallete[0:63] = '{12'h555, 12'h027, 12'h019, 12'h308, 12'h406, 12'h603, 12'h500, 12'h410, 12'h220, 12'h020, 12'h130, 12'h040, 12'h034, 12'h000, 12'h000, 12'h000,
													12'h999, 12'h15C, 12'h33F, 12'h62E, 12'h91B, 12'hA16, 12'h822, 12'h740, 12'h550, 12'h270, 12'h180, 12'h072, 12'h067, 12'h000, 12'h000, 12'h000,
														12'hCCC, 12'h5AF, 12'h78F, 12'hB6F, 12'hE5F, 12'hF5B, 12'hF66, 12'hD82, 12'hAA0, 12'h7C0, 12'h4D2, 12'h3D6, 12'h3BD, 12'h333, 12'h000, 12'h000,
															12'hFFF, 12'hADF, 12'hCCF, 12'hDBF, 12'hFBF, 12'hFBD, 12'hFBB, 12'hEC9, 12'hDD7, 12'hBE8, 12'hBE9, 12'hAEB, 12'hADE, 12'hAAA, 12'h000, 12'h000};
																												
	parameter hEnd = 800;
	parameter vEnd = 525;
   parameter totalLines = 480;
	logic [11:0]lines = 0;
   logic [11:0]pixels = 0;

	logic [1:0]row = 0;
	logic [11:0]p[4] = '{ 12'h68F, 12'hC40, 12'hECC, 12'h000};  // 12'h7c0 h270
	

	//assign LEDG = ROM[SW];
	logic [11:0]newpixels;
	logic [11:0]newlines;
	assign newpixels = pixels - 64;
	assign newlines = lines - 5;
	logic[2:0]tileRow;
	logic[3:0]tileX;
	logic[3:0]tileY;
	logic tableSelect = 1;
	logic order;
	logic [7:0]nametableROM[4096];
	logic [7:0]nametableByte;
	
	assign nametableByte = nametableROM[{newlines[8],newpixels[8],newlines[7:3], newpixels[7:3]}];
	assign tileRow = newlines[2:0];
	assign order = newpixels[0];
	assign tileX = nametableByte[3:0]; //newpixels[6:3];
	assign tileY = nametableByte[7:4]; //newlines[7:3];
	
	logic[7:0] rombyte;
	assign rombyte = ((newpixels < 512) && (newlines < 240)) ? ROM[{tableSelect, tileY, tileX, order, tileRow}]: 8'b0; 

	logic [15:0]rowOut = 0;
	logic [7:0]rowLow = 0;
	logic [7:0]ROM[8192];
	logic [4:0]line2[256];
	logic [4:0]line1[256];				
	logic [1:0]div = 0;
															
	initial begin
		$readmemh("chrHexed.txt", ROM);
		$readmemh("NameTable.txt", nametableROM);
	end														
															
	always_ff @(posedge CLOCK_24) 
	begin 
		//if(div == 0) begin
		// Drawing color inside of 512 horizontal only
		if(pixels >= 0 && pixels < 640 && lines <= 480) 
		begin
			// Drawing the white box outline
			if((pixels >= 0 && pixels <= 64) || (pixels >= 576 && pixels < 640))
			begin
				Pixel <= 16'hfff;
			end
			else
			
			// Drawing inside the box
			begin
				logic [7:0]rowHigh;
				if((newpixels+2)%8 == 0)
					rowLow <= rombyte;
				if((newpixels+1)%8 == 0)
				begin
					rowHigh = rombyte;
					
					for(integer i = 0;i < 8; i=i+1)
					begin
						rowOut[14-2*i] <= rowHigh[i];
						rowOut[15-2*i] <= rowLow[i];
					end
				end
					//if(lines % 2)
					//	Pixel <= 12'hf00;
				   //else
					//	Pixel <= 12'h00F;
					Pixel <= p[rowOut >> (((newpixels)%8)*2)];
								
			end

		end
		
		// Outside of 512 black is drawn
		//else
		//begin
		//	Pixel = 0;
		//end

		// Reached the end display capacity, restart
		if(lines == vEnd) 
			lines <= 0; 
		
		// One more pixel drawn
		pixels <= pixels + 1;
		
		// Next horizontal scan line
		if(pixels == hEnd) 
		begin 
			pixels <= 0; 
			lines <= lines + 1; 
		end
		
	//end
	//div <= div + 1;
	end
=======
module red(input logic [9:0]SW, input logic [1:0]CLOCK_24, input logic [3:0]KEY, output logic[9:0]LEDR, output logic [7:0]LEDG, output logic [3:0]VGA_B, output logic [3:0]VGA_G, output logic[3:0]VGA_R, output logic VGA_HS, output logic VGA_VS);

	logic [20:0]div = 0;
	logic clk = 0;
	assign LEDR = SW;
	
	//counter poop(clk, KEY[0], LEDG[7:0]);
	vga hello(SW[9:0], KEY[0], CLOCK_24[0], LEDG[7:0], VGA_B[3:0], VGA_R[3:0], VGA_G[3:0], VGA_HS, VGA_VS);
	
	always_ff @(posedge CLOCK_24[0]) begin
		if(div == 0)
			clk <= 1;
		else
			clk <= 0;
			
		div <= div + 1;
	end
	
endmodule


module counter(input logic clk, input logic KEY, output logic [7:0]thatLOUD);

	logic [7:0]counter = 0;
	assign thatLOUD = counter;
	
	always_ff @(posedge clk) begin
		if(KEY == 0)
			counter <= 0;
		else
			counter <= counter + 1;
	end

endmodule


module vga(input logic [9:0]SW, input logic KEY, input logic CLOCK_24, output logic [7:0]LEDG, output logic [3:0]VGA_B, output logic [3:0]VGA_R, output logic [3:0]VGA_G, output logic VGA_HS, output logic VGA_VS);
   logic [11:0]lines = 0;
   logic [11:0]pixels = 0;
	logic [11:0]RGB = 0;
   logic VSNC = 0;
   logic HSNC = 0;
	logic even = 1;
	logic [15:0]tileLine = 0;
	logic [7:0]tileLineTemp = 0;
	const logic[11:0]pallete[0:63] = '{12'h555, 12'h027, 12'h019, 12'h308, 12'h406, 12'h603, 12'h500, 12'h410, 12'h220, 12'h020, 12'h130, 12'h040, 12'h034, 12'h000, 12'h000, 12'h000,
													12'h999, 12'h15C, 12'h33F, 12'h62E, 12'h91B, 12'hA16, 12'h922, 12'h740, 12'h550, 12'h270, 12'h180, 12'h072, 12'h067, 12'h000, 12'h000, 12'h000,
														12'hCCC, 12'h5AF, 12'h78F, 12'hB6F, 12'hE5F, 12'hF5B, 12'hF66, 12'hD82, 12'hAA0, 12'h7C0, 12'h4D2, 12'h3D6, 12'h3BD, 12'h333, 12'h000, 12'h000,
															12'hFFF, 12'hADF, 12'hCCF, 12'hDBF, 12'hFBF, 12'hFBD, 12'hFBB, 12'hEC9, 12'hDD7, 12'hBE8, 12'hBE9, 12'hAEB, 12'hADE, 12'hAAA, 12'h000, 12'h000};
   
	assign VGA_R = RGB[11:8];
   assign VGA_G = RGB[7:4];
	assign VGA_B = RGB[3:0];
   assign VGA_VS = VSNC;
   assign VGA_HS = HSNC;
	
	parameter totalPixels = 640;
   parameter totalLines = 480;
   parameter hsw = 96;
   parameter hfp = 16;
   parameter hbp = 48;
   parameter vsw = 2;
   parameter vfp = 10;
   parameter vbp = 33;
	
	logic [1:0]row = 0;
	logic [11:0]p[4] = '{ 12'h78F, 12'h7C0, 12'h270, 12'h000};  //12'h78F

	
	
	logic [7:0]ROM[8192]; 
	
	initial begin
		$readmemh("chrHexed.txt", ROM);
	end
	
	//assign LEDG = ROM[SW];
	logic[7:0] rombyte;
	logic pluseight;
	assign pluseight = pixels%8 == 1;
	assign rombyte = ROM[(pixels/8)*16+8*pluseight + lines];  //ROM[(pixels/8)*16+8*pluseight + lines];
	assign LEDG = tileLine;
	
	
    
   always_ff @(posedge CLOCK_24) 
	begin 
		
		// Drawing color inside of 512 horizontal only
		if(KEY && pixels >= 0 && pixels < 640 && lines <= 480) 
		begin
			// Drawing the white box outline
			if((pixels >= 0 && pixels <= 64) || (pixels >= 576 && pixels < 640) || (lines < 5) || (lines > 475))
			begin
				RGB = 16'hFFF;
			end
			else
			
			// Drawing inside the box
			begin
				logic [7:0]tileLineTemp2;
				if(pixels%8 == 0)
					tileLineTemp <= rombyte;
				if(pixels%8 == 1)
				begin
					tileLineTemp2 = rombyte;
					
					for(integer i = 0;i < 16; i=i+1)
					begin
					if(i%2)
						tileLine[i] <= tileLineTemp[i/2];
					else
						tileLine[i] <= tileLineTemp2[i/2];
					end
				end
					
					RGB <= p[tileLine >> (((pixels-2)%8)*2)];
				
				
			
			/*
				if(lines <= 120)
					RGB <= pallete[(pixels - 60) / 33 ];
				else 
				if(lines <= 240)
					RGB <= pallete[(pixels - 60) / 33 + 16];
				else
				if(lines <= 360)
					RGB <= pallete[(pixels - 60) / 33 + 32];
				else
					RGB <= pallete[(pixels - 60) / 33 + 48];
					
			*/
			end

		end
		
		// Outside of 512 black is drawn
		else
		begin
			RGB = 0;
		end

		// Set HSNC (after fp and before bp)
		if((pixels >= totalPixels + hfp) && (pixels < (totalPixels + hfp + hsw)) ) 
			HSNC = 1;
		else 
			HSNC <= 0;
			
		// Set VSNC (after fp and before bp)
		if( (lines >= (totalLines + vfp)) && (lines < (totalLines + vfp + vsw))) 
			VSNC <= 1;
		else 
			VSNC <= 0;
			
		// Reached the end display capacity, restart
		if(lines == totalLines + vfp + vsw + vbp) 
			lines <= 0; 
		
		// One more pixel drawn
		pixels <= pixels + 1;
		
		// Next horizontal scan line
		if(pixels == totalPixels + hfp + hsw + hbp) 
		begin 
			pixels <= 0; 
			lines <= lines + 1; 
		end
			  
	end
    
>>>>>>> Ben
endmodule