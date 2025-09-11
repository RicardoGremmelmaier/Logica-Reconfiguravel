library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StateMachine is
    port (
        Clr_btn, Pause_btn, RST: in std_logic;
        State: out std_logic_vector(1 downto 0)
    );
end entity StateMachine;

architecture func of StateMachine is

    signal State_s: std_logic_vector(1 downto 0) := "00";
    -- 00 - Reseted
    -- 01 - Running
    -- 10 - Paused

    begin

        process(RST, Clr_btn, Pause_btn)
        begin
            if RST = '1' THEN
                State_s <= "00";
            end if;
            if Clr_btn = '0' AND State_s = "10" THEN
                State_s <= "00";
            end if;
            if Pause_btn = '0' AND State_s = "01" THEN
                State_s <= "10";
            end if;
            if Pause_btn = '0' AND (State_s = "10" OR State_s = "00") THEN
                State_s <= "01";
            end if;
        end process;

    State <= State_s;

end func;