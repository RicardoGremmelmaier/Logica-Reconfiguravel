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
signal CLR_s: std_logic := '0';

constant LD_c1: std_logic_vector(3 downto 0) := "0110";
constant LD_c2: std_logic_vector(3 downto 0) := "0000";

begin
	C1: cont4_LD
		PORT MAP (
			RST => RST,
			CLK => CLK,
			Q   => CONT_1_s(3 downto 0),
			EN  => EN,
			CLR => CLR_s,
			LD  => LD,
			LOAD=> LOAD_s(3 downto 0)
		);
	C2: cont4_LD
		PORT MAP (
			RST => RST,
			CLK => CLK_C2,
			Q   => CONT_2_s(3 downto 0),
			EN  => EN,
			CLR => CLR_s,
			LD  => LD,
			LOAD=> LOAD_s(7 downto 4)
		);

	process (CLK, RST)
	begin
		if RST = '1' then
			CONT_2_s <= LD_c2;
			CONT_1_s <= LD_c1;
		elsif CLK'event and CLK = '1' then
			if CLR = '1' then
				CONT_2_s <= LD_c2;
				CONT_1_s <= LD_c1;
			else
				if CONT_s > "01000100" then
					CONT_2_s <= LD_c2;
					CONT_1_s <= LD_c1;
				end if;
			end if;
		end if;
	end process;
	CONT_s <= CONT_2_s(3 downto 0) & CONT_1_s(3 downto 0);
	CLK_C2 <= not CONT_1_s(3);
	Q <= CONT_s;

end architecture;
