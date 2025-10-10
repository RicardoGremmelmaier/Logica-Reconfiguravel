library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FifoBram_tb is
end entity;

architecture tb of FifoBram_tb is

    -- Componente sob teste
    component FifoBram is
        port(
            CLK         : in std_logic;
            DATA_OUT    : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Sinais de simulação
    signal CLK         : std_logic := '0';
    signal DATA_OUT_s  : std_logic_vector(15 downto 0);

    constant period_time : time := 20 ns;
    signal finished : std_logic := '0';

begin
    UUT: FifoBram
        port map(
            CLK => CLK,
            DATA_OUT => DATA_OUT_s
        );

    -- Clock process
    clk_proc: process
    begin
        while finished /= '1' loop
            CLK <= '0';
            wait for period_time/2;
            CLK <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process;

process
    begin
        report "Iniciando simulacao da FifoBram" severity note;

        -- Aguarda tempo suficiente para inicializar BRAM1
        wait for 50 us;

        -- Aguarda o fluxo de dados BRAM1 -> FIFO -> BRAM2
        wait for 100 us;

        -- Aguarda mais tempo para BRAM2 preencher
        wait for 200 us;

        wait;
    end process;

end architecture;
