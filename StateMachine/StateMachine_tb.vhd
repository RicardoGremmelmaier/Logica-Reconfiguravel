library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StateMachine_tb is
end;

architecture func of StateMachine_tb is
    component StateMachine is 
    port (
        clk      : in std_logic;                        -- Clock
        RST      : in std_logic;                        -- Reset assíncrono
        Clr_btn  : in std_logic;                        -- Botão CLR
        Pause_btn: in std_logic;                        -- Botão PAUSE/RESUME
        State    : out std_logic_vector(1 downto 0)     -- Estado atual
    );
end component StateMachine;

signal Clr_btn_s, Pause_btn_s, RST, clk : std_logic := '1';
signal State_s: std_logic_vector(1 downto 0) := "00";
constant period_time : time := 100 ns;
signal finished : std_logic := '0';

begin 
    UUT: StateMachine port map(
        clk => clk,
        Clr_btn => Clr_btn_s,
        Pause_btn => Pause_btn_s,
        RST => RST,
        State => State_s
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

    reset_global: process
    begin   
        RST <= '1';
        wait for period_time*2;
        RST <= '0';
        wait;
    end process;

    process
    begin
        wait for 400 ns;
        wait for 150 ns;
        Clr_btn_s <= '0';
        wait for 150 ns;
        Clr_btn_s <= '1';
        wait for 300 ns;
        Pause_btn_s <= '0';
        wait for 150 ns;
        Pause_btn_s <= '1';
        wait for 600 ns;
        Clr_btn_s <= '0';
        wait for 150 ns;
        Clr_btn_s <= '1';
        wait for 300 ns;
        Pause_btn_s <= '0';
        wait for 150 ns;
        Pause_btn_s <= '1';
        wait for 300 ns;
        Pause_btn_s <= '0';
        wait for 150 ns;
        Pause_btn_s <= '1';
        wait for 300 ns;
        Pause_btn_s <= '0';
        wait for 150 ns;
        Pause_btn_s <= '1';
        wait for 300 ns;
        Clr_btn_s <= '0';
        wait for 150 ns;
        Clr_btn_s <= '1';
        wait for 500 ns;

        wait;
    end process;
end func;