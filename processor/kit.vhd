LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY kit IS
   PORT ( CLOCK_50                           : IN  STD_LOGIC;
          PS2_DAT, PS2_CLK                   : IN  STD_LOGIC;
          KEY                                : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);          			 
          VGA_VS,VGA_HS,VGA_BLANK_N,VGA_CLK  : OUT STD_LOGIC;
          VGA_R, VGA_G, VGA_B                : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			 LEDR										   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
        );
END kit;

ARCHITECTURE Behavior OF kit IS
   COMPONENT clock_manager
      PORT( clock_50Mhz_input               : IN    STD_LOGIC;  
            clock_50Mhz			    		: OUT   STD_LOGIC;    
            clock_25Mhz		                : OUT   STD_LOGIC;								
            clock_1MHz                      : OUT	STD_LOGIC;				
            clock_1KHz                      : OUT	STD_LOGIC				
          );
   END COMPONENT;
		
	COMPONENT clock_divider
      PORT( clock               : IN    STD_LOGIC;  
            clock50Mhz			    		: OUT   STD_LOGIC;    
            clock25Mhz		                : OUT   STD_LOGIC;								
            clock1Mhz                      : OUT	STD_LOGIC;				
            clock1Khz                      : OUT	STD_LOGIC;				
				clock25hz                      : OUT	STD_LOGIC				
          );
   END COMPONENT;

   COMPONENT cpu
      PORT( clk                             : IN    STD_LOGIC;
            reset                           : IN    STD_LOGIC;
            RAM_DATA_IN						: IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
            RAM_DATA_OUT                    : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
            RAM_ADDRESS                     : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
            RW                              : OUT   STD_LOGIC;
            keyboard                        : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            videoflag						: OUT   STD_LOGIC;
            vga_pos                         : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
            vga_char                        : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0)				
          );
   END COMPONENT;
      COMPONENT cpu_v32_5
      PORT( wire_clock	                            : IN    STD_LOGIC;
            wire_reset                           : IN    STD_LOGIC;
            bus_RAM_DATA_IN						: IN	STD_LOGIC_VECTOR(15 DOWNTO 0);
            bus_RAM_DATA_OUT					: OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
            bus_RAM_ADDRESS                     : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
            wire_RW                              : OUT   STD_LOGIC;
            bus_keyboard                        : IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
            videoflag                       : OUT   STD_LOGIC;
            bus_vga_pos                         : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
            bus_vga_char                        : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
            data_debug                      : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);
				led  									: OUT    STD_LOGIC_VECTOR(15 DOWNTO 0)
          );
   END COMPONENT;
    
    COMPONENT RAM
        PORT( address                        : IN   STD_LOGIC_VECTOR (15 DOWNTO 0);
              clock                          : IN   STD_LOGIC;
              data                           : IN   STD_LOGIC_VECTOR (15 DOWNTO 0);
              wren                           : IN   STD_LOGIC;
              q                              : OUT  STD_LOGIC_VECTOR (15 DOWNTO 0)
            );
    END COMPONENT;    

   COMPONENT ps2_keyboard
      PORT( ps2_clk_1khz                    : IN   std_LOGIC;
                ps2_reset                   : IN   std_LOGIC;
                ps2_keyboard_dat            : IN   std_LOGIC;
                ps2_keyboard_clk            : IN   std_LOGIC;
                ps2_keyboard_data_out       : OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
            );
   END COMPONENT;    
    
   COMPONENT vga
      PORT( mem_clk_in_50mhz                : IN   STD_LOGIC;
            vga_clk_in_25mhz                : in   STD_LOGIC;
            vga_reset                       : IN   STD_LOGIC;
            videoflag                       : IN   STD_LOGIC;
            vga_pos                         : IN   STD_LOGIC_VECTOR(15 DOWNTO 0);
            vga_char                        : IN   STD_LOGIC_VECTOR(15 DOWNTO 0);            
            vga_blank_n,vga_clk_out         : OUT  STD_LOGIC;
            vga_vs, vga_hs                  : OUT  STD_LOGIC;
            vga_r, vga_g, vga_b             : OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)    
          );
   END COMPONENT;    

   SIGNAL wire_reset                        : STD_LOGIC;    
   SIGNAL wire_clock_50Mhz                  : STD_LOGIC;
   SIGNAL wire_clock_25Mhz                  : STD_LOGIC;
   SIGNAL wire_clock_1MHz                   : STD_LOGIC;
   SIGNAL wire_clock_1KHz                   : STD_LOGIC;
	SIGNAL wire_clock_25hz                   : STD_LOGIC;
   SIGNAL bus_RAM_DATA_IN                   : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL bus_RAM_DATA_OUT                  : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL bus_RAM_ADDRESS                   : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL wire_RW                           : STD_LOGIC;
   SIGNAL bus_keyboard                      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL wire_videoflag                    : STD_LOGIC;
   SIGNAL bus_vga_pos                       : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL bus_vga_char                      : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL data_debug                        : STD_LOGIC_VECTOR(15 DOWNTO 0); 
   

BEGIN
   wire_reset <= NOT(KEY(0));              
    U1: cpu_v32_5 PORT MAP (wire_clock_1MHz, wire_reset, bus_RAM_DATA_IN, bus_RAM_DATA_OUT, bus_RAM_ADDRESS, wire_RW, bus_keyboard, wire_videoflag, bus_vga_pos, bus_vga_char,data_debug, LEDR);    	 
    U2: RAM PORT MAP (bus_RAM_ADDRESS, wire_clock_50Mhz, bus_RAM_DATA_OUT, wire_RW, bus_RAM_DATA_IN);
    U3: ps2_keyboard PORT MAP (wire_clock_1KHz, wire_reset, PS2_DAT, PS2_CLK, bus_keyboard);
    U4: vga PORT MAP (wire_clock_50Mhz, wire_clock_25Mhz, wire_reset, wire_videoflag, bus_vga_pos, bus_vga_char, VGA_BLANK_N, VGA_CLK, VGA_VS, VGA_HS, VGA_R, VGA_G, VGA_B);    
	 U5: clock_divider PORT MAP (CLOCK_50, wire_clock_50Mhz, wire_clock_25Mhz, wire_clock_1MHz, wire_clock_1KHz,wire_clock_25hz);    
 
END Behavior;
