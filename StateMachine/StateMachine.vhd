library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StateMachine is
    port (
        CLK, RST: in std_logic;
        State: out std_logic_vector(1 downto 0)
    );
end entity StateMachine;

architecture func of StateMachine is

    signal Data: std_logic_vector(1 downto 0) := "00";

    begin

        process(CLK, RST)
        begin
            if RST = '1' then
                Data <= "00";
            elsif rising_edge(CLK) then
                if Data = "10" then
                    Data <= "00";
                else
                    Data <= std_logic_vector(unsigned(Data)+1);
                end if;
            end if;
        end process;

        State <= Data;

end func;