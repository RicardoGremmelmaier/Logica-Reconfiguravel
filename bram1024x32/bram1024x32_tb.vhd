
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity bram1024x32_tb is
end entity;
architecture arch of bram1024x32_tb is

	component bram1024x32 is
		PORT(
			address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			clock		: IN STD_LOGIC  := '1';
			data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			wren		: IN STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;  

-- Sinais de simulacao
	signal CLK : std_logic;

	signal data_s, q_s : std_logic_vector(31 downto 0) := (others => '0');
	signal address_s: std_logic_vector(9 downto 0) := (others => '0');
	signal wren_s : std_logic := '0';
-- Constantes
	constant period_time : time := 20 ns;
	signal finished : std_logic := '0';
	
begin
     UUT: bram1024x32 port map(
			address => address_s,
			clock => CLK,
			data => data_s,
			wren => wren_s,
			q => q_s
		);
-- Clock
	clk_proc: process
	begin
		while finished /= '1' loop
			clk <= '0';
			wait for period_time/2;
			clk <= '1';
			wait for period_time/2;
		end loop;
		wait;
	end process clk_proc;

-- Testbench
	process
		variable i : integer := 0;
	begin 

		-- Carrega a BRAM
		wren_s <= '1';
		for i in 0 to 1023 loop
			address_s <= std_logic_vector(to_unsigned(i, 10));
			data_s <= std_logic_vector(to_unsigned(i, 32));
			wait for period_time;
		end loop;

		-- Verifica todos os valores
		wren_s <= '0';
		for i in 0 to 1023 loop
			address_s <= std_logic_vector(to_unsigned(i, 10));
			wait for period_time;
		end loop;
		
		-- Finaliza a simulacao

		wait; 
		
	end process;

end architecture;
