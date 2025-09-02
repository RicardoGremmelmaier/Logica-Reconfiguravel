Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont57 is
	port(RST: in std_logic;
	     CLK: in std_logic;
		  Q: out std_logic_vector(7 downto 0);
		  EN: in std_logic;
		  CLR: in std_logic;
		  LD:  in std_logic;
		  LOAD: in std_logic_vector (7 downto 0));
	
end entity;
  
architecture arch of cont57 is
	component cont4_LD is
		PORT(RST: in std_logic;
			CLK: in std_logic;
			Q: out std_logic_vector(3 downto 0);
			EN: in std_logic;
			CLR: in std_logic;
			LD:  in std_logic;
			LOAD: in std_logic_vector (3 downto 0));
	end component;  
	
signal CONT_s : std_logic_vector (7 downto 0);
signal CONT_1_s, CONT_2_s : std_logic_vector (3 downto 0);
signal LOAD_s: std_logic_vector (7 downto 0);
signal LD_s: std_logic;
signal EN_C2: std_logic;

constant LD_CTE: std_logic_vector(7 downto 0) := "00001100";

begin
	C1: cont4_LD
		PORT MAP (
			RST => RST,
			CLK => CLK,
			Q   => CONT_1_s,
			EN  => EN,
			CLR => CLR,
			LD  => LD_s,
			LOAD=> LOAD_s(3 downto 0)
		);
	C2: cont4_LD
		PORT MAP (
			RST => RST,
			CLK => CLK,
			Q   => CONT_2_s,
			EN  => EN_C2,
			CLR => CLR,
			LD  => LD_s,
			LOAD=> LOAD_s(7 downto 4)
		);

	CONT_s <= (CONT_2_s(3 downto 0) & CONT_1_s(3 downto 0));

	Q <= CONT_s;
	
	EN_C2 <= '1' WHEN (CONT_1_s = "1111" AND EN = '1')
				 OR   (LD_s = '1') 		
			ELSE '0';
	
	LD_s <= '1' WHEN (unsigned(CONT_s) < 12)
				OR   (unsigned(CONT_s) >= 68)
				OR   CLR = '1'
				OR   RST = '1' 
			ELSE LD;  
			
	LOAD_s <= LD_CTE WHEN LD = '0'		
			ELSE LOAD;
	
end architecture;
