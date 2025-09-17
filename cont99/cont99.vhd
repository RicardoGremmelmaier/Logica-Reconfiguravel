Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont99 is
	port(RST: in std_logic;
	     CLK: in std_logic;
		  Q: out std_logic_vector(7 downto 0);
		  EN: in std_logic;
		  CLR: in std_logic;
		  LD:  in std_logic;
		  LOAD: in std_logic_vector (7 downto 0));
	
end entity;
  
architecture arch of cont99 is
	component cont4_BCD is
		PORT(RST: in std_logic;
			CLK: in std_logic;
			Q: out std_logic_vector(3 downto 0);
			EN: in std_logic;
			CLR: in std_logic;
			LD:  in std_logic;
			LOAD: in std_logic_vector (3 downto 0));
	end component;  
	
signal CONT_1_s, CONT_2_s : std_logic_vector (3 downto 0);
signal LOAD_s: std_logic_vector (7 downto 0);
signal CLR_s: std_logic;
signal EN_C2: std_logic;

begin
	C1: cont4_BCD
		PORT MAP (
			RST => RST,
			CLK => CLK,
			Q   => CONT_1_s,
			EN  => EN,
			CLR => CLR_s,
			LD  => LD,
			LOAD=> LOAD_s(3 downto 0)
		);
	C2: cont4_BCD
		PORT MAP (
			RST => RST,
			CLK => CLK,
			Q   => CONT_2_s,
			EN  => EN_C2,
			CLR => CLR_s,
			LD  => LD,
			LOAD=> LOAD_s(7 downto 4)
		);
	
	Q <= CONT_2_s & CONT_1_s;

	EN_C2 <= '1' WHEN (CONT_1_s = "1001" AND EN = '1')		
			ELSE '0';
	
	CLR_s <= '1' WHEN (CONT_2_s = "1001" AND CONT_1_s = "1001" AND EN = '1')
				   OR (CLR = '1')
			ELSE '0';

	LOAD_s <= LOAD;
	
end architecture;
