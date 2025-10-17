Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg32_sc_tb is
end entity;

architecture func of reg32_sc_tb is

	component reg32_sc is
		PORT(
			RST_n: in std_logic;
			CLK: in std_logic;
			WR_EN: in std_logic;
			SC: in std_logic;
			DataIn: in std_logic_vector(31 downto 0);
			DataOut: out std_logic_vector(31 downto 0)
		);
	end component;
		
-- Sinais de simulação padrão
	signal finished : std_logic := '0';
	constant period_time : time := 20 ns;

-- Sinais de simulação especí­ficos
	signal RST_n_s, CLK_s, WR_EN_s, SC_s: std_logic := '0';
	signal DataIn_s: std_logic_vector(31 downto 0) := (others => '0');
	signal DataOut_s: std_logic_vector(31 downto 0) := (others => '0');

	begin
		UUT: reg32_sc port map(
			RST_n => RST_n_s,
			CLK => CLK_s,
			WR_EN => WR_EN_s,
			SC => SC_s,
			DataIn => DataIn_s,
			DataOut => DataOut_s
		);

-- Reset global
		reset_global: process
		begin
			RST_n_s <= '0';
			wait for 15 ns;
			RST_n_s <= '1';
			wait;
		end process reset_global;
		
-- Tempo de simulaÃ§Ã£o
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
			SC_s <= '0';
			wait for 20 ns;
			DataIn_s <= x"AAAAAAAA";
			WR_EN_s <= '1';
			
			wait for 20 ns;
			DataIn_s <= x"55555555";
			
			wait for 20 ns;
			WR_EN_s <= '0';
			
			wait for 20 ns;
			SC_s <= '1'; 
			
			wait for 20 ns;
			DataIn_s <= x"FFFFFFFF";
			WR_EN_s <= '1';

			wait for 20 ns;
			
			wait for 20 ns;
			
			wait;
		end process;
end architecture;