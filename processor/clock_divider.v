module clock_divider(clock,clock50Mhz,clock25Mhz,clock1Mhz,clock1Khz,clock25hz);
   input  wire clock;
   output wire clock50Mhz;
   output wire clock25Mhz;
   output wire clock1Mhz;
   output wire clock1Khz;
   output wire clock25hz;
   reg  reg25Mhz=1'b1;
   reg  reg1Mhz=1'b1;
   reg  reg1Khz=1'b1;
	reg  reg25hz=1'b1;
   
   

   reg [8:0] counter1Mhz=8'h00;
   reg [16:0] counter1Khz=16'h0000;
	reg [16:0] counter25hz=16'h0000;
   assign clock50Mhz=clock;
   assign clock25Mhz=reg25Mhz;
   assign clock1Mhz=reg1Mhz;
	assign clock1Khz=reg1Khz;
   assign clock25hz=reg25hz;
   
   
   always @ (posedge clock) begin     
      reg25Mhz=~reg25Mhz;               
      if(counter1Mhz == 8'h19) begin
         reg1Mhz=~reg1Mhz;
         counter1Mhz=8'h00;         
         if(counter1Khz==16'h01f4) begin
            reg1Khz=~reg1Khz;
            counter1Khz=16'h0000;       
				if(counter25hz==16'h01f4) begin
				   counter25hz=16'h0000;
					reg25hz=~reg25hz;
				end
				counter25hz=counter25hz+16'h0001;
         end
         counter1Khz=counter1Khz+16'h01;
      end      
      counter1Mhz=counter1Mhz+8'h01;
      
   end

endmodule
