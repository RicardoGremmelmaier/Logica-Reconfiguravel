Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cont4_LD_tb is
end entity;
architecture arch of cont4_LD_tb is

	component cont4_LD is
		PORT(RST: in std_logic;
		CLK: in std_logic;
		Q: out std_logic_vector(3 downto 0);
		EN: in std_logic;
		CLR: in std_logic;
		LD:  in std_logic;
		LOAD: in std_logic_vector (3 downto 0));
	end component;  
		
-- Sinais de simulacao
	signal CLK : std_logic;
	signal RST : std_logic;
	signal Q   : std_logic_vector(3 downto 0);
	signal EN  : std_logic;
	signal CLR : std_logic;
	signal LD  : std_logic;
	signal LOAD: std_logic_vector (3 downto 0);

	constant period_time : time := 20 ns;
	signal finished : std_logic := '0';
	
begin
     UUT: cont4_LD
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
		EN   <= '1';   
		CLR  <= '0';   
		LD   <= '0';   
		LOAD <= (others => '1');   

		wait for 50 ns;

		EN   <= '1';
		CLR  <= '0';
		LD   <= '1';
		LOAD <= "1111";

		wait for 20 ns;

		LD <= '0';

		wait for 20 ns;

		CLR <= '1';

		wait for 20 ns;

		CLR <= '0';
		wait;
	end process;

end architecture;
