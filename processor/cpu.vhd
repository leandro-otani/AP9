libraRY ieee;
use ieee.std_LOGIC_1164.all;
use ieee.std_LOGIC_ARITH.all;
use ieee.std_LOGIC_unsigned.all;

entity cpu is
	port( clk					: in	STD_LOGIC;
			reset					: in	STD_LOGIC;
			RAM_DATA_IN			: in	STD_LOGIC_VECTOR(15 downto 0);
			RAM_DATA_OUT		: out STD_LOGIC_VECTOR(15 downto 0);
			RAM_ADDRESS			: out STD_LOGIC_VECTOR(15 downto 0);
			RW						: out STD_LOGIC;			
			keyboard				: in	STD_LOGIC_VECTOR(7 downto 0);			
			videoflag			: out STD_LOGIC;
			vga_pos				: out STD_LOGIC_VECTOR(15 downto 0);
			vga_char				: out STD_LOGIC_VECTOR(15 downto 0)			
		);
end cpu;

ARCHITECTURE Behavior of cpu is
   COMPONENT control
      PORT( clk					: in	STD_LOGIC;
				reset					: in	STD_LOGIC;		
				RAM_DATA_IN			: in	STD_LOGIC_VECTOR(15 downto 0);
				RAM_DATA_OUT		: out STD_LOGIC_VECTOR(15 downto 0);
				RAM_ADDRESS			: out STD_LOGIC_VECTOR(15 downto 0);				
				RW						: out STD_LOGIC;			
				FR 					: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				auxFR 				: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				OP 					: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				X						: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				Y						: OUT STD_LOGIC_VECTOR(15 downto 0);				
				RESULT 				: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				keyboard				: in	STD_LOGIC_VECTOR(7 downto 0);			
				videoflag			: out STD_LOGIC;
				vga_pos				: out STD_LOGIC_VECTOR(15 downto 0);
				vga_char				: out STD_LOGIC_VECTOR(15 downto 0)					
			);
   END COMPONENT;
	
	COMPONENT ALU
		PORT( X 					: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				Y 					: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				OP 				: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
				FR 				: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				auxFR 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				RESULT 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				RESET 			: IN STD_LOGIC
			);
	END COMPONENT;	
	
	SIGNAL bus_FR					: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL bus_auxFR				: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL bus_OP					: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bus_X					: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL bus_Y					: STD_LOGIC_VECTOR(15 DOWNTO 0);			
	SIGNAL bus_RESULT 			: STD_LOGIC_VECTOR(15 DOWNTO 0);
	

BEGIN

	U1: control PORT MAP (clk, reset, RAM_DATA_IN, RAM_DATA_OUT, RAM_ADDRESS, RW, bus_FR, bus_auxFR, bus_OP, bus_X, bus_Y, bus_RESULT, keyboard, videoflag, vga_pos, vga_char);	
	U2: alu PORT MAP (bus_X, bus_Y, bus_OP, bus_FR, bus_auxFR, bus_RESULT, reset);

END Behavior;
