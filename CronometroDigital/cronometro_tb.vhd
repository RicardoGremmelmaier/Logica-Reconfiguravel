Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cronometro_tb is
end entity;
architecture arch of cronometro_tb is

	component cronometro is
		PORT(   CLK: in std_logic;   
                RST: in std_logic;
                START_STOP_BTN: in std_logic;
                CLR_BTN: in std_logic;
		        HEX_0: out std_logic_vector(7 downto 0);
		        HEX_1: out std_logic_vector(7 downto 0);
		        HEX_2: out std_logic_vector(7 downto 0);
		        HEX_3: out std_logic_vector(7 downto 0)
			);
	end component;  

-- Sinais de simulacao
	signal CLK : std_logic;
	signal RST : std_logic;
	signal hex0_s   : std_logic_vector(7 downto 0);
	signal hex1_s   : std_logic_vector(7 downto 0);
	signal hex2_s   : std_logic_vector(7 downto 0);
	signal hex3_s   : std_logic_vector(7 downto 0);
	signal StartStop_btn_s : std_logic := '1';
	signal Clr_btn_s : std_logic := '1';

-- Constantes
	constant period_time : time := 20 ns;
	signal finished : std_logic := '0';
	
begin
     UUT: cronometro port map(
            CLK => CLK,
            RST => RST,
			START_STOP_BTN => StartStop_btn_s,
			CLR_BTN => Clr_btn_s,
			HEX_0 => hex0_s,
			HEX_1 => hex1_s,
			HEX_2 => hex2_s,
			HEX_3 => hex3_s
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
	begin 
		  
		wait for 250 ns;
		StartStop_btn_s <= '0';
		
		wait for period_time;
        StartStop_btn_s <= '1';
		
		wait for 450 ns;
        Clr_btn_s <= '0';

		wait for period_time;
        StartStop_btn_s <= '0';
        Clr_btn_s <= '1';

		wait for period_time;
        StartStop_btn_s <= '1';

		wait for period_time;
        Clr_btn_s <= '0';

        wait for period_time;
        Clr_btn_s <= '1';

        wait for 2000 ns;

		wait;
	end process;

end architecture;
