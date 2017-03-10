libraRY ieee;
use ieee.std_LOGIC_1164.all;
use ieee.std_LOGIC_ARITH.all;
use ieee.std_LOGIC_unsigned.all;

entity vga is
	port( mem_clk_in_50mhz			: IN STD_LOGIC;
			vga_clk_in_25mhz			: IN STD_LOGIC;
			vga_reset					: IN STD_LOGIC;
			videoflag					: IN STD_LOGIC;					
			vga_pos						: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			vga_char						: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			vga_blank_n,vga_clk_out : OUT STD_LOGIC;
			vga_vs, vga_hs				: OUT STD_LOGIC;
			vga_r, vga_g, vga_b		: OUT	STD_LOGIC_VECTOR(9 DOWNTO 0)			
		);
end vga;

ARCHITECTURE Behavior of vga is
   COMPONENT ASCII_CONV
      PORT( ASCII : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				CMAP : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
			);
   END COMPONENT;
	
   COMPONENT POS_CONV
      PORT( LPOS : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				SIZE : IN STD_LOGIC;
				XPOS : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
				YPOS : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
			);
   END COMPONENT;	
	
   COMPONENT TEXT_DRAWER
      PORT( CLK : IN STD_LOGIC;
				RST : IN STD_LOGIC;
				DRAW : IN STD_LOGIC;
				CHAR : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
				XPOS : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
				YPOS : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				COLOR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				SIZE : IN STD_LOGIC;
				CHARLINEDATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				CHARADDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
				DATA : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
				DATA_QUEUE : OUT STD_LOGIC
			);
   END COMPONENT;	
	
	COMPONENT VGA_MOD
		PORT
		(
			MEM_CLK		:	 IN STD_LOGIC;
			VGA_CLK		:	 IN STD_LOGIC;
			RST			:	 IN STD_LOGIC;
			VGA_QUEUE	:	 IN STD_LOGIC;
			DATA			:	 IN STD_LOGIC_VECTOR(20 DOWNTO 0);
			HSYNC			:	 OUT STD_LOGIC;
			VSYNC			:	 OUT STD_LOGIC;
			RED			:	 OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			GREEN			:	 OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			BLUE			:	 OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			BLANK			:	 OUT STD_LOGIC;
			CLOCK			:	 OUT STD_LOGIC
		);
	END COMPONENT;	
	
	component lpm_rom0
		PORT
		(	address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock			: IN STD_LOGIC;
			q				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);	
	END COMPONENT;			

	SIGNAL wire_ASCII 			: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL wire_CMAP  			: STD_LOGIC_VECTOR(6 DOWNTO 0);
	
	SIGNAL wire_DRAW				: STD_LOGIC;
	SIGNAL wire_CHAR				: STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL wire_XPOS				: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL wire_YPOS				: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL wire_COLOR				: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL wire_SIZE				: STD_LOGIC;	
	SIGNAL wire_CHARLINEDATA	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL wire_CHARADDR			: STD_LOGIC_VECTOR(9 DOWNTO 0);
		
	SIGNAL wire_VGA_QUEUE 		: STD_LOGIC;
	SIGNAL wire_DATA 				: STD_LOGIC_VECTOR(20 DOWNTO 0);
 
BEGIN  
	wire_ASCII <= vga_char(7 DOWNTO 0);
	wire_COLOR <=  vga_char(11 DOWNTO 8);
	wire_SIZE <= vga_char(12);
		
   U1: ASCII_CONV PORT MAP (wire_ASCII, wire_CMAP);	
	U2: POS_CONV PORT MAP (vga_pos, wire_SIZE, wire_XPOS, wire_YPOS);
	U3: TEXT_DRAWER PORT MAP (vga_clk_in_25mhz, vga_reset, videoflag, wire_CMAP, wire_XPOS, wire_YPOS, wire_COLOR, wire_SIZE, wire_CHARLINEDATA, wire_CHARADDR, wire_DATA, wire_VGA_QUEUE);	
	U4: VGA_MOD PORT MAP (mem_clk_in_50mhz, vga_clk_in_25mhz, vga_reset, wire_VGA_QUEUE, wire_DATA, vga_hs, vga_vs, vga_r, vga_g, vga_b, vga_blank_n, vga_clk_out);
	U5: lpm_rom0 PORT MAP (wire_CHARADDR, mem_clk_in_50mhz, wire_CHARLINEDATA);
 
END Behavior;