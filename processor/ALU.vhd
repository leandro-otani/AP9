LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY alu IS
	PORT( X 					: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Y 					: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			OP 				: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
			FR 				: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			auxFR 			: INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			RESULT 			: INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			RESET 			: IN STD_LOGIC
		);
END alu;

ARCHITECTURE Behavior OF alu IS
	
	CONSTANT ARITH			: STD_LOGIC_VECTOR(1 downto 0) := "10";
	CONSTANT ADD 			: STD_LOGIC_VECTOR(3 downto 0) := "0000";			-- ADD RX RY RZ / ADDC RX RY RZ  	-- RX <- RY + RZ / RX <- RY + RZ + C  	-- b0=CarRY	  			Format: < inst(6) | RX(3) | RY(3) | RZ(3)| C >	
	CONSTANT SUB 			: STD_LOGIC_VECTOR(3 downto 0) := "0001";			-- SUB RX RY RZ / SUBC RX RY RZ  	-- RX <- RY - RZ / RX <- RY - RZ + C  	-- b0=CarRY	  			Format: < inst(6) | RX(3) | RY(3) | RZ(3)| C >
	CONSTANT MULT 			: STD_LOGIC_VECTOR(3 downto 0) := "0010";			-- MUL RX RY RZ  / MUL RX RY RZ		-- RX <- RY * RZ / RX <- RY * RZ + C  	-- b0=CarRY				Format: < inst(6) | RX(3) | RY(3) | RZ(3)| C >
	CONSTANT DIV 			: STD_LOGIC_VECTOR(3 downto 0) := "0011";			-- DIV RX RY RZ 							-- RX <- RY / RZ / RX <- RY / RZ + C  	-- b0=CarRY				Format: < inst(6) | RX(3) | RY(3) | RZ(3)| C >
	CONSTANT INC 			: STD_LOGIC_VECTOR(3 downto 0) := "0100";			-- INC RX / DEC RX						-- RX <- RX + 1 / RX <- RX - 1  			-- b6= INC/DEC : 0/1	Format: < inst(6) | RX(3) | b6 | xxxxxx >
	CONSTANT LMOD 			: STD_LOGIC_VECTOR(3 downto 0) := "0101";			-- MOD RX RY RZ 							-- RX <- RY MOD RZ														Format: < inst(6) | RX(3) | RY(3) | RZ(3)| x >	

	CONSTANT LOGIC			: STD_LOGIC_VECTOR(1 downto 0) := "01";
	-- LOGIC Instructions (All should begin wiht "01"):	
	CONSTANT LAND			: STD_LOGIC_VECTOR(3 downto 0) := "0010"; 	-- AND RX RY RZ  	-- RZ <- RX AND RY	Format: < inst(6) | RX(3) | RY(3) | RZ(3)| x >
	CONSTANT LOR			: STD_LOGIC_VECTOR(3 downto 0) := "0011";		-- OR RX RY RZ   	-- RZ <- RX OR RY		Format: < inst(6) | RX(3) | RY(3) | RZ(3)| x >
	CONSTANT LXOR			: STD_LOGIC_VECTOR(3 downto 0) := "0100"; 	-- XOR RX RY RZ  	-- RZ <- RX XOR RY	Format: < inst(6) | RX(3) | RY(3) | RZ(3)| x >
	CONSTANT LNOT			: STD_LOGIC_VECTOR(3 downto 0) := "0101";		-- NOT RX RY       	-- RX <- NOT(RY)		Format: < inst(6) | RX(3) | RY(3) | xxxx >
	CONSTANT SHIFT			: STD_LOGIC_VECTOR(3 downto 0) := "0000";		-- SHIFTL0 RX,n / SHIFTL1 RX,n / SHIFTR0 RX,n / SHIFTR1 RX,n / ROTL RX,n / ROTR RX,n
																							-- SHIFT/Rotate RX	-- b6=shif/rotate: 0/1  b5=left/right: 0/1; b4=fill; 	
																							-- Format: < inst(6) | RX(3) |  b6 b5 b4 | nnnn >
												
	CONSTANT CMP 			: STD_LOGIC_VECTOR(3 downto 0) := "0110";		-- CMP RX RY  		-- Compare RX and RY and set FR :   Format: < inst(6) | RX(3) | RY(3) | xxxx >   Flag Register: <...DIVbyZero|StackUnderflow|StackOverflow|DIVByZero|ARITHmeticOverflow|carRY|zero|equal|lesser|greater>
																								
BEGIN

--************************************************************************
-- ULA --->  3456  (3042)
--************************************************************************
PROCESS (OP, X, Y, FR, auxFR, RESULT, reset)

	VARIABLE AUX		: STD_LOGIC_VECTOR(15 downto 0);
	VARIABLE RESULT32 : STD_LOGIC_VECTOR(31 downto 0);	

	
BEGIN

	IF (reset = '1') THEN
		auxFR <= x"0000";		
		RESULT <= x"0000";
	else
		auxFR <= FR;

--========================================================================
-- ARITH 
--========================================================================
		IF (OP (5 downto 4) = ARITH) THEN
			CASE OP (3 downto 0) IS
				WHEN ADD =>
					IF (OP(6) = '1') THEN --Soma com CARRY
						AUX := X + Y + FR(4);
						RESULT32 := (x"00000000" + X + Y + FR(4));
					ELSE  --Soma sem CARRY
						AUX := X + Y;
						RESULT32 := (x"00000000" + X + Y);					
					end if;	
					if(RESULT32 > "01111111111111111") THEN -- CARRY
						auxFR(4) <= '1';
					ELSE
						auxFR(4) <= '0';
					end if;
					
				WHEN SUB =>
					AUX := X - Y;
					
				WHEN MULT =>
					RESULT32 := X * Y;
					AUX := RESULT32(15 downto 0);
					if(RESULT32 > x"0000FFFF") THEN -- ARITHmetic Overflow
						auxFR(5) <= '1';
					ELSE
						auxFR(5) <= '0';
					end if;

				WHEN DIV =>
					IF(Y = x"0000") THEN
						AUX := x"0000";
						auxFR(6) <= '1'; -- DIV by Zero
					ELSE
						AUX := CONV_STD_LOGIC_VECTOR(CONV_INTEGER(X)/CONV_INTEGER(Y), 16);		
						auxFR(6) <= '0';
					END IF;
				WHEN LMOD =>
					IF(Y = x"0000") THEN
						AUX := x"0000";
						auxFR(6) <= '1'; -- DIV by Zero
					ELSE
						AUX := CONV_STD_LOGIC_VECTOR(CONV_INTEGER(X) mod CONV_INTEGER(Y), 16);		
						auxFR(6) <= '0';
					END IF;			
				WHEN others =>   -- invalid operation, defaults to nothing
					AUX := X;
			END CASE;
			if(AUX = x"0000") THEN
				auxFR(3) <= '1';  -- FR = <...|zero|equal|lesser|greater>
			ELSE
				auxFR(3) <= '0';  -- FR = <...|zero|equal|lesser|greater>
			end if;
			if(AUX < x"0000") THEN   -- NEGATIVO
				auxFR(9) <= '1';  
			ELSE
				auxFR(9) <= '0';  
			end if;	
			RESULT <= AUX;
			
		ELSIF (OP (5 downto 4) = LOGIC) THEN
			IF (OP (3 downto 0) = CMP) THEN
				result <= x;
				IF (x > y) THEN
					auxFR(2 downto 0) <= "001"; -- FR = <...|zero|equal|lesser|greater>
				ELSIF (x < y) THEN
					auxFR(2 downto 0) <= "010"; -- FR = <...|zero|equal|lesser|greater>
				ELSIF (x = y) THEN
					auxFR(2 downto 0) <= "100"; -- FR = <...|zero|equal|lesser|greater>
				END IF;
			ELSE
				CASE OP (3 downto 0) IS
					WHEN LAND => result <= x and y;

					WHEN LXOR => result <= x xor y;

					WHEN LOR =>	 result <= x or y;

					WHEN LNOT => result <= not x;

					WHEN others =>   -- invalid operation, defaults to nothing
						RESULT <= X;
				END CASE;
				if(result = x"0000") THEN
					auxFR(3) <= '1';  -- FR = <...|zero|equal|lesser|greater>
				ELSE
					auxFR(3) <= '0';  -- FR = <...|zero|equal|lesser|greater>
				end if;	
			END IF;
		END IF;
	END IF; -- Reset
END PROCESS;


END Behavior;