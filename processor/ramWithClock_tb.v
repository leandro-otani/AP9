module ramWithClock_tb;
   //wire clocks =======================================================
   wire clock__50Mhz;
   wire wire_clock_50Mhz;
   wire wire_clock_25Mhz;
   wire wire_clock_1MHz;
   wire wire_clock_1KHz;
   //end================================================================

   //wire to ram========================================================
   wire [15:0] bus_RAM_ADDRESS;
   wire [15:0] bus_RAM_DATA_OUT;
   wire        wire_RW;
   wire [15:0] bus_RAM_DATA_IN;   
   //end================================================================
   

  
   //cpu data out=======================================================
   wire [15:0] data_debug;   
   //end================================================================
	
   wire [15:0] bus_vga_pos;
   wire [15:0] bus_vga_char;
   wire wire_videoflag;

   wire [15:0] leds;
   kit_v kit_v_mux(clock__50Mhz, wire_clock_50Mhz, wire_clock_25Mhz, wire_clock_1MHz, wire_clock_1KHz,bus_RAM_ADDRESS,bus_RAM_DATA_OUT, wire_RW,bus_RAM_DATA_IN,wire_videoflag, bus_vga_pos, bus_vga_char,data_debug,leds);
	
   
   
   initial
     begin
        
        $display("clock = %x, data_out = %x",wire_clock_1MHz,data_debug);#90000000
	    $stop;
     end
   
endmodule
