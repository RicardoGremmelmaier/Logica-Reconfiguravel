library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StateMachine_tb is
end;

architecture func of StateMachine_tb is
    component StateMachine is 
    port (
        CLK, RST: in std_logic;
        State: out std_logic_vector(1 downto 0)
    );
end component StateMachine;

signal CLK, RST : std_logic := '0';
signal State_s: std_logic_vector(1 downto 0) := "00";
constant period_time : time := 100 ns;
signal finished : std_logic := '0';

begin 
    UUT: StateMachine port map(
        CLK => CLK,
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


        sim_time_process: process
        begin
            wait for 10 us;
            finished <= '1';
            wait;
        end process sim_time_process;

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

        process
        begin
    
        wait;
    end process;
end func;