Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cont99_tb is
end entity;
architecture arch of cont99_tb is

	component cont99 is
		PORT(RST: in std_logic;
		CLK: in std_logic;
		Q: out std_logic_vector(7 downto 0);
		EN: in std_logic;
		CLR: in std_logic;
		LD:  in std_logic;
		LOAD: in std_logic_vector (7 downto 0));
	end component;  

-- Sinais de simulacao
	signal CLK : std_logic;
	signal RST : std_logic;
	signal Q   : std_logic_vector(7 downto 0);
	signal EN  : std_logic;
	signal CLR : std_logic;
	signal LD  : std_logic;
	signal LOAD: std_logic_vector (7 downto 0);

-- Constantes
	constant period_time : time := 20 ns;
	signal finished : std_logic := '0';
	
begin
     UUT: cont99
	port map
	     (RST => RST,
	      CLK => clk,
			Q   => Q,
			EN  => EN,
			CLR => clr,
			LD  => ld,
			LOAD=> load);
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
	begin 
        EN  <= '1';
        CLR <= '0';
        LD  <= '0';
        LOAD <= (others => '0');
		  
		wait for 450 ns;
		
		CLR <= '1';
		
		wait for period_time;
		
		CLR <= '0';

		wait for 450 ns;

		wait for 400 ns;
		EN <= '0';

		wait for 400 ns;
		EN <= '1';

		wait for 1000 ns;

		wait;
	end process;

end architecture;
