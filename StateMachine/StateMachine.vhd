library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StateMachine is
    port (
        clk      : in std_logic;                        -- Clock
        RST      : in std_logic;                        -- Reset assíncrono
        Clr_btn  : in std_logic;                        -- Botão CLR
        Pause_btn: in std_logic;                        -- Botão PAUSE/RESUME
        State    : out std_logic_vector(1 downto 0)     -- Estado atual
    );
end entity StateMachine;

architecture arch of StateMachine is

    signal State_s : std_logic_vector(1 downto 0) := "00";
    signal pause_btn_prev : std_logic := '1';  -- Para detectar borda de descida
    signal clr_btn_prev   : std_logic := '1';

    -- Definição dos estados
    constant ST_RESET : std_logic_vector(1 downto 0) := "00";
    constant ST_RUN   : std_logic_vector(1 downto 0) := "01";
    constant ST_PAUSE : std_logic_vector(1 downto 0) := "10";

begin

    process(clk, RST)
    begin
        if RST = '1' then
            State_s <= ST_RESET;

        elsif rising_edge(clk) then

            -- Detecta borda de descida do Pause_btn
            if pause_btn_prev = '1' and Pause_btn = '0' then
                if State_s = ST_RUN then
                    State_s <= ST_PAUSE;     -- Se estava rodando → pausa
                else
                    State_s <= ST_RUN;       -- Se estava pausado ou resetado → roda
                end if;
            end if;

            -- Detecta borda de descida do Clr_btn
            if clr_btn_prev = '1' and Clr_btn = '0' then
                if State_s = ST_PAUSE then
                    State_s <= ST_RESET;     -- Só limpa se estiver pausado
                end if;
            end if;

            -- Atualiza os registradores de borda
            pause_btn_prev <= Pause_btn;
            clr_btn_prev   <= Clr_btn;
        end if;
    end process;

    State <= State_s;

end arch;
