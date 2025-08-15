Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cont4 is 
	PORT(
		RST: in std_logic;
		CLK: in std_logic;
		EN: in std_logic;
		CLR: in std_logic;
		Q: out unsigned(3 downto 0)
	);
end entity;
	
Architecture arch of cont4 is

signal count: unsigned (3 downto 0);

begin
	process (CLK, RST)
	begin
		if (RST = '1') then
			count <= "0000";
		elsif (CLK'event and CLK = '1') then
			if (CLR = '1') then
				count <= "0000";
			else
				count <= count + 1;
			end if;
		end if;
	end process;
	Q <= count;
end arch;
				