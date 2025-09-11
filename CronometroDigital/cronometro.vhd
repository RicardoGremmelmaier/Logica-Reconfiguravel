library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cronometro is
    port(
        CLK: in std_logic;
        RST: in std_logic;
        START_STOP_BTN: in std_logic;
        CLR_BTN: in std_logic;
        HEX_0: out std_logic_vector(7 downto 0); -- Menos significativo
        HEX_1: out std_logic_vector(7 downto 0);
        HEX_2: out std_logic_vector(7 downto 0);
        HEX_3: out std_logic_vector(7 downto 0) -- Mais significativo
    );
end entity;

architecture arch of cronometro is

    signal Clk_en_cont99_s: std_logic := '0';
    signal Clk_en_cont59_s: std_logic := '0';
    signal State_s: std_logic_vector(1 downto 0) := "00";
    signal Q_cent_s: std_logic_vector(7 downto 0) := (others => '0');
    signal Q_seg_s: std_logic_vector(7 downto 0) := (others => '0');
    signal StartStop_btn_s: std_logic := '1';
    signal Clr_btn_s: std_logic := '1';
    signal Clr_s: std_logic := '0';

    component Divisor is 
        port(   CLK:    in std_logic;
                RST:    in std_logic;
		        DIV50:  out std_logic
        );
    end component;

    component cont59 is
        port(	RST:  in std_logic;
	            CLK:  in std_logic;
		        Q:    out std_logic_vector(7 downto 0);
                EN:   in std_logic;
		        CLR:  in std_logic;
		        LD:   in std_logic;
		        LOAD: in std_logic_vector (7 downto 0)
        );
    end component;

    component cont99 is
        port(	RST:  in std_logic;
                CLK:  in std_logic;
                Q:    out std_logic_vector(7 downto 0);
                EN:   in std_logic;
                CLR:  in std_logic;
                LD:   in std_logic;
                LOAD: in std_logic_vector (7 downto 0)
        );
    end component;
    
    component hexTo7Seg is
        port(	DataIn	:	in	std_logic_vector(3 downto 0);
                DataOut	:	out std_logic_vector(7 downto 0)
        );
    end component;

    -- 00 - Reseted
    -- 01 - Running
    -- 10 - Paused
    component StateMachine is
        port(   Clr_btn, Pause_btn, RST: in std_logic;
                State: out std_logic_vector(1 downto 0)
        );
    end component;

    begin

        Divisor_cent: Divisor port map(
            CLK => CLK,
            RST => RST,
            DIV50 => Clk_en_cont99_s
        );

        cont_cent: cont99 port map(
            RST => RST,
            CLK => CLK,
            Q => Q_cent_s,
            EN => Clk_en_cont99_s,
            CLR => Clr_s,
            LD => '0',
            LOAD => (others => '0')
        );

        cont_seg: cont59 port map(
            RST => RST,
            CLK => CLK,
            Q => Q_seg_s,
            EN => Clk_en_cont59_s,
            CLR => Clr_s,
            LD => '0',
            LOAD => (others => '0')
        );

        hex0: hexTo7Seg port map(
            DataIn => Q_seg_s(3 downto 0),
            DataOut => HEX_0
        );

        hex1: hexTo7Seg port map(
            DataIn => Q_seg_s(7 downto 4),
            DataOut => HEX_1
        );

        hex2: hexTo7Seg port map(
            DataIn => Q_cent_s(3 downto 0),
            DataOut => HEX_2
        );

        hex3: hexTo7Seg port map(
            DataIn => Q_cent_s(7 downto 4),
            DataOut => HEX_3
        );

        SM: StateMachine port map(
            Clr_btn => CLR_BTN,
            Pause_btn => START_STOP_BTN,
            RST => RST,
            State => State_s
        );

        Clr_s <= '1' when State_s = "00" else '0';

        Clk_en_cont59_s <= '1' when Q_cent_s = "01100011" and Clk_en_cont99_s = '1' and State_s = "01" else '0';

    end architecture;