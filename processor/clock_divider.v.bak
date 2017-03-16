module clock_divider(clock,clock50Mhz,clock25Mhz,clock1Mhz,clock1Khz);
   input  wire clock;
   output wire clock50Mhz;
   output wire clock25Mhz;
   output wire clock1Mhz;
   output wire clock1Khz;

   reg  reg25Mhz;
   reg  reg1Mhz;
   reg  reg1Khz;
   
   

   reg [8:0] counter1Mhz;
   reg [16:0] counter1Khz;
   assign clock50Mhz=clock;
   assign clock25Mhz=reg25Mhz;
   assign clock1Mhz=reg1Mhz;
   assign clock1Khz=reg1Khz;
   
   initial begin
      counter1Mhz=8'h00;
      counter1Khz=16'h0000;     
      reg25Mhz=1'b1;
      reg1Mhz=1'b1;
      reg1Khz=1'b1;
   end
   always @ (posedge clock) begin     
      reg25Mhz=~reg25Mhz;               
      if(counter1Mhz == 8'h19) begin
         reg1Mhz=~reg1Mhz;
         counter1Mhz=8'h00;         
         if(counter1Khz==16'h01f4) begin
            reg1Khz=~reg1Khz;
            counter1Khz=16'h0000;            
         end
         counter1Khz=counter1Khz+16'h01;
      end      
      counter1Mhz=counter1Mhz+8'h01;
      
   end

endmodule
