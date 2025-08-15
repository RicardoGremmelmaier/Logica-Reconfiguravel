Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont4_tb is
end entity;

architecture func of cont4_tb is

	component cont4 is
		PORT(
			RST: in std_logic;
			CLK: in std_logic;
			EN: in std_logic;
			CLR: in std_logic;
			Q: out unsigned(3 downto 0)
		);
	end component;
		
-- Sinais de simulação padrão
	signal finished : std_logic := '0';
	constant period_time : time := 20 ns;

-- Sinais de simulação específicos
	signal RST_s, CLK_s, EN_s, CLR_s: std_logic := '0';
	signal Q_s: unsigned (3 downto 0) := "0000";

	begin
		UUT: cont4 port map(
			RST => RST_s,
			CLK => CLK_s,
			EN => EN_s,
			CLR => CLR_s,
			Q => Q_s
		);

-- Reset global
		reset_global: process
		begin
			RST_s <= '1';
			wait for 15 ns;
			RST_s <= '0';
			wait;
		end process reset_global;
		
-- Tempo de simulação
		sim_time_process: process
		begin
			wait for 10 us;
			finished <= '1';
			wait;
		end process sim_time_process;
		
-- Clock
		clk_proc: process
		begin
			while finished /= '1' loop
				CLK_s <= '0';
				wait for period_time/2;
				CLK_s <= '1';
				wait for period_time/2;
			end loop;
			wait;
		end process clk_proc;

-- Testbench
		process
		begin
			EN_s <= '1';
			
			wait for 75 ns;
			CLR_s <= '1';
			
			wait for 20 ns;
			CLR_s <= '0';
			
			wait for 30 ns;
			CLR_s <= '1';
			
			wait for 20 ns; 
			CLR_s <= '0';
			
			wait for 40 ns;
			EN_s <= '0';
			
			wait;
		end process;
end architecture;