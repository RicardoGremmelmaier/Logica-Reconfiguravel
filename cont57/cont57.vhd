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
signal CLK_C2: std_logic;

constant reset_c1: std_logic_vector(3 downto 0) := "0110";
constant reset_c2: std_logic_vector(3 downto 0) := "0000";

begin
	C1: cont4_LD
		PORT MAP (
			RST => RST,
			CLK => CLK,
			Q   => CONT_1_s(3 downto 0),
			EN  => EN,
			CLR => CLR,
			LD  => LD,
			LOAD=> LOAD_s(3 downto 0)
		);
	C2: cont4_LD
		PORT MAP (
			RST => RST,
			CLK => CLK_C2,
			Q   => CONT_2_s(3 downto 0),
			EN  => EN,
			CLR => CLR,
			LD  => LD,
			LOAD=> LOAD_s(7 downto 4)
		);

	process (RST)
	begin

	end process;
	CONT_s <= CONT_2_s(3 downto 0) & CONT_1_s(3 downto 0);
	CLK_C2 <= not CONT_1_s(3);

end architecture;
