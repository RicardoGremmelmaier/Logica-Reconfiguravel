Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cont4_BCD is
    PORT(
        RST:  in std_logic;
        CLK:  in std_logic;
        Q:    out std_logic_vector(3 downto 0);
        EN:   in std_logic;
        CLR:  in std_logic;
        LD:   in std_logic;
        LOAD: in std_logic_vector (3 downto 0)
    );
end entity;

Architecture X of cont4_BCD is
    Signal CONT: unsigned(3 downto 0);
Begin
    Process (CLK, RST)
    Begin
        If RST = '1' then
            CONT <= (others => '0');
        Elsif rising_edge(CLK) then
            If CLR = '1' then
                CONT <= (others => '0');
            Else
                If EN = '1' then
                    If LD = '1' then
                        CONT <= unsigned(LOAD);
                    Else
                        If CONT = 9 then
                            CONT <= (others => '0');
                        Else
                            CONT <= CONT + 1;
                        End If;
                    End If;
                End If;
            End If;
        End If;
    End process;

    Q <= std_logic_vector(CONT);

End architecture;
