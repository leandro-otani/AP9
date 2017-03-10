libraRY ieee;
use ieee.std_LOGIC_1164.all;
use ieee.std_LOGIC_ARITH.all;
use ieee.std_LOGIC_unsigned.all;

entity ps2_keyboard is
	port( ps2_clk_1khz				: IN	std_LOGIC;
			ps2_reset					: IN	std_LOGIC;
			ps2_keyboard_dat			: IN	std_LOGIC;
			ps2_keyboard_clk			: IN	std_LOGIC;
			ps2_keyboard_data_out	: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0)			
		);
end ps2_keyboard;

ARCHITECTURE Behavior of ps2_keyboard is
   COMPONENT keyboard
      PORT( keyboard_clk 			: IN	STD_LOGIC; 
				keyboard_data			: IN	STD_LOGIC;
				reset						: IN	STD_LOGIC;
				read						: IN	STD_LOGIC;
				scan_code				: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				scan_ready				: OUT	STD_LOGIC		
			);
   END COMPONENT;
	
   COMPONENT dec_keyboard
      PORT( hex_bus				: IN	STD_LOGIC_VECTOR(7 downto 0);
				scan_rd 				: IN 	STD_LOGIC;
				clk	 				: IN 	STD_LOGIC;		
				bin_digit    		: OUT STD_LOGIC_VECTOR(7 downto 0)
			);
   END COMPONENT;	

	SIGNAL wire_read 				: STD_LOGIC;
	SIGNAL wire_code 				: STD_LOGIC_VECTOR(7 downto 0);
		
 
BEGIN  
   U1: keyboard PORT MAP (ps2_keyboard_clk, ps2_keyboard_dat, ps2_reset, wire_read, wire_code, wire_read);	
	U2: dec_keyboard PORT MAP (wire_code, wire_read, ps2_clk_1khz, ps2_keyboard_data_out);
 
END Behavior;