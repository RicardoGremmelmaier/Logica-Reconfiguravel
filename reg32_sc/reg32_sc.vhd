LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg32_sc is
	PORT(
		CLK			: in  std_logic;
		RST_n		   : in  std_logic;
		WR_EN		   : in  std_logic;
		SC			   : in  std_logic;
		DataIn		: in  std_logic_vector(31 downto 0);
		DataOut  	: out std_logic_vector(31 downto 0)
	);
end entity;

architecture arch of reg32_sc is
	signal DataOut_s  : std_logic_vector(31 downto 0) := (others => '0');
	signal sc_pending : std_logic 					     := '0';  
begin
	process (CLK, RST_n)
	begin
		if RST_n = '0' then
			DataOut_s  <= (others => '0');
			sc_pending <= '0';
		elsif rising_edge(CLK) then
			if WR_EN = '1' then
				DataOut_s <= DataIn;
				if SC = '1' then
					sc_pending <= '1';
				end if;
			end if;

			if sc_pending = '1' then
				DataOut_s  <= (others => '0');
				sc_pending <= '0';
			end if;
		end if;
	end process;

	DataOut <= DataOut_s;
end architecture;
