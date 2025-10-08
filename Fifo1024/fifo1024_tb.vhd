Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity fifo1024_tb is
end entity;
architecture arch of fifo1024_tb is

	component fifo1024 is
		PORT(
			aclr		: IN STD_LOGIC ;
			clock		: IN STD_LOGIC ;
			data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			rdreq		: IN STD_LOGIC ;
			wrreq		: IN STD_LOGIC ;
			almost_empty		: OUT STD_LOGIC ;
			almost_full		: OUT STD_LOGIC ;
			empty		: OUT STD_LOGIC ;
			full		: OUT STD_LOGIC ;
			q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			usedw		: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
		);
	end component;  

-- Sinais de simulacao
	signal CLK : std_logic;
	signal RST : std_logic;

	signal data_s, q_s : std_logic_vector(15 downto 0) := (others => '0');
	signal usedw_s: std_logic_vector(9 downto 0) := (others => '0');
	signal rdreq_s, wrreq_s, almost_empty_s, almost_full_s, empty_s, full_s : std_logic := '0';

-- Constantes
	constant period_time : time := 20 ns;
	signal finished : std_logic := '0';
	
begin
     UUT: fifo1024 port map(
			aclr => RST,
			clock => CLK,
			data => data_s,
			rdreq => rdreq_s,
			wrreq => wrreq_s,
			almost_empty => almost_empty_s,
			almost_full => almost_full_s,
			empty => empty_s,
			full => full_s,
			q => q_s,
			usedw => usedw_s
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

-- Reset global
	reset_global: process
	begin
		rst <= '1';
		wait for 15 ns;
		rst <= '0';
		wait;
	end process reset_global;	

-- Testbench
	process
		variable i : integer := 0;
	begin 
		-- Espera o reset
		wait for 15 ns;

		-- Escreve 1024 palavras
		wrreq_s <= '1';
		rdreq_s <= '0';
		for i in 0 to 1023 loop
			data_s <= std_logic_vector(to_unsigned(i, data_s'length));
			wait for period_time;
		end loop;

		-- Testa se escreve com fifo cheia
		data_s <= "1111111111111111";
		wait for period_time;
		wrreq_s <= '0';

		-- Le 1024 palavras
		wrreq_s <= '0';
		rdreq_s <= '1';
		for i in 0 to 1023 loop
			wait for period_time;
		end loop;
			
		-- Testa se le com fifo vazia
		rdreq_s <= '1';
		wait for period_time;
		
		-- Finaliza a simulacao
		rdreq_s <= '0';
		wrreq_s <= '0';
		wait; 
		
	end process;

end architecture;
