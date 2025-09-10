library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StateMachine_tb is
end;

architecture func of StateMachine_tb is
    component StateMachine is 
    port (
        Clr_btn, Pause_btn, RST: in std_logic;
        State: out std_logic_vector(1 downto 0)
    );
end component StateMachine;

signal Clr_btn_s, Pause_btn_s, RST : std_logic := '1';
signal State_s: std_logic_vector(1 downto 0) := "00";
constant period_time : time := 100 ns;

begin 
    UUT: StateMachine port map(
        Clr_btn => Clr_btn_s,
        Pause_btn => Pause_btn_s,
        RST => RST,
        State => State_s
    );
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