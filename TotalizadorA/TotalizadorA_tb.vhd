Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity TotalizadorA_tb is
end entity;
architecture arch of TotalizadorA_tb is

	component TotalizadorA is
		port(
			CLK: 		in std_logic;
			DataIn: 	in std_logic_vector(3 downto 0);
			DataOut: out std_logic_vector(2 downto 0)
		);
	end component;  
		
-- Sinais de simulacao
	signal CLK : std_logic;
	signal DataIn_s: std_logic_vector(3 downto 0) := (others => '0');
	signal DataOut_s: std_logic_vector(2 downto 0) := (others => '0');

	constant period_time : time := 20 ns;
	signal finished : std_logic := '0';
	
begin
     UUT: TotalizadorA
	port map
	     (CLK => CLK,
			DataIn => DataIn_s,
			DataOut => DataOut_s
		);
-- Clock
	clk_proc: process
	begin
		while finished /= '1' loop
			CLK <= '0';
			wait for period_time/2;
			CLK <= '1';
			wait for period_time/2;
		end loop;
		wait;
	end process clk_proc;	

-- Testbench
	process
	begin 
	
		DataIn_s <= "0000";
		wait for period_time * 5;
		DataIn_s <= "1111";
		wait for period_time * 5;
		DataIn_s <= "1001";
		wait for period_time * 5;
		DataIn_s <= "1101";
		wait for period_time * 5;
		DataIn_s <= "0110";
		wait for period_time * 5;
		DataIn_s <= "1000";
		wait for period_time * 5;
		DataIn_s <= "0001";
		wait for period_time * 5;
		DataIn_s <= "0010";
		wait for period_time * 5;
		DataIn_s <= "1011";
		
		wait;
	end process;

end architecture;
