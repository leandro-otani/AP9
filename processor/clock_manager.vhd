library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY clock_manager IS

	PORT
	(  clock_50Mhz_input		: IN	STD_LOGIC;		
		clock_50Mhz				: OUT	STD_LOGIC;
		clock_25Mhz				: OUT	STD_LOGIC;
		clock_1MHz				: OUT	STD_LOGIC;
		clock_1KHz				: OUT	STD_LOGIC
	);
	
END clock_manager;

ARCHITECTURE a OF clock_manager IS

	COMPONENT lpm_dff1
		PORT(	clock							:	 IN STD_LOGIC;
				q								:	 OUT STD_LOGIC
		);
	END COMPONENT;		
	
	SIGNAL count_1Mhz: STD_LOGIC_VECTOR(4 DOWNTO 0); 
	SIGNAL count_100Khz, count_10Khz, count_1Khz : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL count_100hz, count_10hz, count_1hz : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL clock_1Mhz_int, clock_100Khz_int, clock_10Khz_int, clock_1Khz_int: STD_LOGIC; 
	SIGNAL clock_100hz_int, clock_10Hz_int, clock_1Hz_int, clock_25Mhz_int, clock_12Mhz_int, clock_6Mhz_int, clock_3Mhz_int : STD_LOGIC;

BEGIN

	clock_50Mhz <= clock_50Mhz_input;
	U1: lpm_dff1 PORT MAP (clock_50Mhz_input, clock_25Mhz);

	PROCESS -- 50 divide by 2
	BEGIN
		WAIT UNTIL clock_50Mhz_input'EVENT and clock_50Mhz_input = '1';
			clock_25Mhz_int <= not clock_25Mhz_int;
	END PROCESS;	
		
	PROCESS -- 25 divide by 2
	BEGIN
		WAIT UNTIL clock_25Mhz_int'EVENT and clock_25Mhz_int = '1';
			clock_12Mhz_int <= not clock_12Mhz_int;
	END PROCESS;	

	PROCESS -- 12 divide by 2
	BEGIN
		WAIT UNTIL clock_12Mhz_int'EVENT and clock_12Mhz_int = '1';
			clock_6Mhz_int <= not clock_6Mhz_int;
	END PROCESS;	

	PROCESS -- 6 divide by 2
	BEGIN
		WAIT UNTIL clock_6Mhz_int'EVENT and clock_6Mhz_int = '1';
			clock_3Mhz_int <= not clock_3Mhz_int;
	END PROCESS;	
	
	PROCESS 
	BEGIN
	-- Divide by 25
		WAIT UNTIL clock_25Mhz_int'EVENT and clock_25Mhz_int = '1';
			IF count_1Mhz < 24 THEN
				count_1Mhz <= count_1Mhz + 1;
			ELSE
				count_1Mhz <= "00000";
			END IF;
			IF count_1Mhz < 12 THEN
				clock_1Mhz_int <= '0';
			ELSE
				clock_1Mhz_int <= '1';
			END IF;	

-- Ripple clocks are used in this code to save prescalar hardware
-- Sync all clock prescalar outputs back to master clock signal         			
			--clock_12Mhz <= clock_12Mhz_int;
			--clock_3Mhz <= clock_3Mhz_int;
			clock_1Mhz <= clock_1Mhz_int;
			--clock_100Khz <= clock_100Khz_int;
			--clock_10Khz <= clock_10Khz_int;
			clock_1Khz <= clock_1Khz_int;
			--clock_100hz <= clock_100hz_int;
			--clock_10hz <= clock_10hz_int;
			--clock_6Mhz <= clock_6Mhz_int;
			--clock_1hz <= clock_1hz_int;
	END PROCESS;	

-- Divide by 10
	PROCESS 
	BEGIN
		WAIT UNTIL clock_1Mhz_int'EVENT and clock_1Mhz_int = '1';
			IF count_100Khz /= 4 THEN
				count_100Khz <= count_100Khz + 1;
			ELSE
				count_100khz <= "000";
				clock_100Khz_int <= NOT clock_100Khz_int;
			END IF;
	END PROCESS;	

-- Divide by 10
	PROCESS
	BEGIN
		WAIT UNTIL clock_100Khz_int'EVENT and clock_100Khz_int = '1';
			IF count_10Khz /= 4 THEN
				count_10Khz <= count_10Khz + 1;
			ELSE
				count_10khz <= "000";
				clock_10Khz_int <= NOT clock_10Khz_int;
			END IF;
	END PROCESS;	

-- Divide by 10
	PROCESS 
	BEGIN
		WAIT UNTIL clock_10Khz_int'EVENT and clock_10Khz_int = '1';
			IF count_1Khz /= 4 THEN
				count_1Khz <= count_1Khz + 1;
			ELSE
				count_1khz <= "000";
				clock_1Khz_int <= NOT clock_1Khz_int;
			END IF;
	END PROCESS;	

-- Divide by 10
	PROCESS 
	BEGIN
		WAIT UNTIL clock_1Khz_int'EVENT and clock_1Khz_int = '1';
			IF count_100hz /= 4 THEN
				count_100hz <= count_100hz + 1;
			ELSE
				count_100hz <= "000";
				clock_100hz_int <= NOT clock_100hz_int;
			END IF;
	END PROCESS;	

-- Divide by 10
	PROCESS 
	BEGIN
		WAIT UNTIL clock_100hz_int'EVENT and clock_100hz_int = '1';
			IF count_10hz /= 4 THEN
				count_10hz <= count_10hz + 1;
			ELSE
				count_10hz <= "000";
				clock_10hz_int <= NOT clock_10hz_int;
			END IF;
	END PROCESS;	

-- Divide by 10
	PROCESS
	BEGIN
		WAIT UNTIL clock_10hz_int'EVENT and clock_10hz_int = '1';
			IF count_1hz /= 4 THEN
				count_1hz <= count_1hz + 1;
			ELSE
				count_1hz <= "000";
				clock_1hz_int <= NOT clock_1hz_int;
			END IF;
	END PROCESS;	

END a;
