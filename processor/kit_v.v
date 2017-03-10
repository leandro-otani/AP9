module kit_v(clock__50Mhz, wire_clock_50Mhz, wire_clock_25Mhz, wire_clock_1Mhz, wire_clock_1KHz,bus_RAM_ADDRESS,bus_RAM_DATA_OUT, wire_RW,bus_RAM_DATA_IN,wire_videoflag, bus_vga_pos, bus_vga_char, data_debug);
   //wire clocks =======================================================
   output wire clock__50Mhz;
   output wire wire_clock_50Mhz;
   output wire wire_clock_25Mhz;
   output wire wire_clock_1Mhz;
   output wire wire_clock_1KHz;
   //end================================================================

   //wire to ram========================================================
   output wire [15:0] bus_RAM_ADDRESS;
   output wire [15:0] bus_RAM_DATA_OUT;
   output wire        wire_RW;
   output wire [15:0] bus_RAM_DATA_IN;   
   //end================================================================

	//extra wire=========================================================
	output wire wire_videoflag;
	output wire [15:0]  bus_vga_pos;
	output wire [15:0] bus_vga_char;
   output wire [15:0] data_debug;
   //extra wire=========================================================
   
   wire              clock_50Mhz_priv;
   wire              wire_clock_50Mhz_priv;
   wire              wire_clock_25Mhz_priv;
   wire              wire_clock_1MHz_priv;   
   wire              wire_clock_1KHz_priv;


   wire [15:0]       bus_RAM_ADDRESS_priv;  
   wire [15:0]       bus_RAM_DATA_OUT_priv;
   wire [15:0]       bus_RAM_DATA_IN_priv;      
   wire              wire_RW_priv;
   wire [15:0]       data_debug_priv;
   wire              reset;
   wire [7:0]       bus_keyboard;  
   
	
   wire [15:0]  bus_vga_pos_priv;
	wire [15:0] bus_vga_char_priv;
   wire wire_videoflag_priv;
	
	wire VGA_VS;
	wire VGA_HS;
	wire VGA_BLANK_N;
	wire VGA_CLK;
   wire  [9:0] VGA_R;
 	wire  [9:0] VGA_G;
	wire  [9:0] VGA_B;
   
   //clock init========================================================
   clock_gen clock_gen_dut(clock_50Mhz_priv);
   clock_divider  clock_manager_dut(clock_50Mhz_priv,wire_clock_50Mhz_priv,wire_clock_25Mhz_priv,wire_clock_1MHz_priv,wire_clock_1KHz_priv);
   
   //end================================================================


   ram ram_dut(bus_RAM_ADDRESS_priv, wire_clock_50Mhz_priv,bus_RAM_DATA_IN_priv ,wire_RW_priv, bus_RAM_DATA_OUT_priv);
   cpu_v cpu_v_dut(wire_clock_1MHz_priv,reset,bus_RAM_DATA_OUT_priv,bus_RAM_DATA_IN,bus_RAM_ADDRESS_priv,wire_RW_priv, bus_keyboard, wire_videoflag_priv, bus_vga_pos_priv, bus_vga_char_priv,data_debug_priv);
	//cpu cpu_v_dut(wire_clock_1MHz_priv,reset, bus_RAM_DATA_IN_priv,bus_RAM_DATA_OUT_priv,bus_RAM_ADDRESS_priv,wire_RW_priv, bus_keyboard, wire_videoflag_priv, bus_vga_pos_priv, bus_vga_char_priv);
	vga vga1(wire_clock_50Mhz, wire_clock_25Mhz, reset, wire_videoflag_priv, bus_vga_pos_priv, bus_vga_char_priv, VGA_BLANK_N, VGA_CLK, VGA_VS, VGA_HS, VGA_R, VGA_G, VGA_B);    
	assign wire_videoflag=wire_videoflag_priv;
	assign bus_vga_char=bus_vga_char_priv;
	assign bus_vga_pos=bus_vga_pos_priv;
	
	
   assign  bus_RAM_ADDRESS=bus_RAM_ADDRESS_priv;	
   assign  wire_clock_50Mhz=wire_clock_50Mhz_priv;
   assign  wire_clock_25Mhz=wire_clock_25Mhz_priv;
   assign  wire_clock_1Mhz=wire_clock_1MHz_priv;
   assign  wire_clock_1KHz=wire_clock_1KHz_priv;	
   assign  bus_RAM_DATA_OUT=bus_RAM_DATA_OUT_priv;
   assign  wire_RW=wire_RW_priv;
   assign  bus_RAM_DATA_IN_priv=bus_RAM_DATA_IN;
   assign  bus_RAM_ADDRESS=bus_RAM_ADDRESS_priv;
   assign  data_debug = data_debug_priv ;
   assign  clock__50Mhz=clock_50Mhz_priv;
   
   
endmodule

   
