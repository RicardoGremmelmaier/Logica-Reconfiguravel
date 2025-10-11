library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FifoBram is
    port(
        CLK         : in std_logic;
        DATA_OUT    : out std_logic_vector(15 downto 0)
    );
end entity;

architecture arch of FifoBram is
    -- Types
    type state_type is (WR_FIFO, WR_WAIT, RD_FIFO, RD_WAIT, BRAM_INIT, WR_DONE, RD_DONE);
    signal prev_wr_state_s, current_state, next_state : state_type := BRAM_INIT;

    -- Signals
    signal counter_s: unsigned(2 downto 0) := (others => '0');

    signal fifo_empty_s, fifo_full_s : std_logic := '0';
    signal fifo_almost_empty_s, fifo_almost_full_s : std_logic := '0';
    signal fifo_usedw_s : std_logic_vector(9 downto 0) := (others => '0');
    signal rdreq_s, wrreq_s, wr_done_s, rd_done_s : std_logic := '0';

    signal bram_1_data_s, bram_2_data_s, bram_1_out_s, bram_2_out_s : std_logic_vector(15 downto 0) := (others => '0');
    signal bram_1_address_s, bram_2_address_s : std_logic_vector(10 downto 0) := (others => '0');
    signal bram_1_wren_s, bram_2_wren_s : std_logic := '0';

    signal init_done_s : std_logic := '0';
    signal init_addr_s : unsigned(10 downto 0) := (others => '0');

    component fifo1024 is 
        port(   
            aclr		    : IN STD_LOGIC ;
		    clock		    : IN STD_LOGIC ;
            data		    : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            rdreq		    : IN STD_LOGIC ;
            wrreq		    : IN STD_LOGIC ;
            almost_empty	: OUT STD_LOGIC ;
            almost_full	    : OUT STD_LOGIC ;
            empty		    : OUT STD_LOGIC ;
            full		    : OUT STD_LOGIC ;
            q		        : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            usedw		    : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
        );
    end component;

    component bram2048 is
        port(	
            address		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		    clock		: IN STD_LOGIC  := '1';
		    data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		    wren		: IN STD_LOGIC ;
		    q		    : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
    end component;

begin

    fifo: fifo1024 port map(
        aclr => '0',
        clock => CLK,
        data => bram_1_out_s,
        rdreq => rdreq_s,
        wrreq => wrreq_s,
        almost_empty => fifo_almost_empty_s,
        almost_full => fifo_almost_full_s,
        empty => fifo_empty_s,
        full => fifo_full_s,
        q => bram_2_data_s,
        usedw => fifo_usedw_s
    );

    bram_1: bram2048 port map(
        address => bram_1_address_s,
        clock => CLK,
        data => bram_1_data_s,
        wren => bram_1_wren_s,
        q => bram_1_out_s
    );

    bram_2: bram2048 port map(
        address => bram_2_address_s,
        clock => CLK,
        data => bram_2_data_s,
        wren => bram_2_wren_s,
        q => bram_2_out_s
    );

------------------------Sequential (clocked) process--------------------------
    process(CLK)
    begin
        if rising_edge(CLK) then
            current_state <= next_state;

            if current_state = WR_FIFO or current_state = WR_WAIT or current_state = WR_DONE then
                prev_wr_state_s <= current_state;
            end if;

            -- ==================== INICIALIZAÇÃO DA BRAM 1 ====================
            if init_done_s = '0' then
                -- escreve na BRAM 1 endereços 0..2047
                bram_1_data_s <= "00000" & std_logic_vector(init_addr_s);
                bram_1_address_s <= std_logic_vector(init_addr_s);
                bram_1_wren_s <= '1';

                if init_addr_s = 2047 then
                    init_done_s <= '1';
                    bram_1_wren_s <= '0';
                    bram_1_address_s <= (others => '0');
                    init_addr_s <= (others => '0');
                    counter_s <= (others => '0');  -- reseta contador no fim da inicialização
                else
                    init_addr_s <= init_addr_s + 1;
                end if;

            else
                -- ==================== OPERAÇÃO NORMAL ====================
                bram_1_wren_s <= '0';

                -- contador reseta ao sair do BRAM_INIT (transição segura)
                if current_state = BRAM_INIT and next_state = WR_FIFO then
                    counter_s <= (others => '0');
                    bram_1_address_s <= (others => '0');
                    bram_2_address_s <= (others => '0');

                -- contador cíclico (0..7)
                elsif counter_s = 7 then
                    counter_s <= "001";
                else
                    counter_s <= counter_s + 1;
                end if;

                -- incrementa endereços apenas quando efetivamente faz req
                if wrreq_s = '1' and wr_done_s = '0' then
                    bram_1_address_s <= std_logic_vector(unsigned(bram_1_address_s) + 1);
                    if unsigned(bram_1_address_s) = 2047 then
                        wr_done_s <= '1';
                    end if;
                end if;

                if rdreq_s = '1' and rd_done_s = '0' then
                    bram_2_address_s <= std_logic_vector(unsigned(bram_2_address_s) + 1);
                    if unsigned(bram_2_address_s) = 2047 then
                        rd_done_s <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

--------------------------Combinational State Machine--------------------------
    process(current_state, fifo_almost_full_s, fifo_almost_empty_s, fifo_empty_s, 
            counter_s, wr_done_s, rd_done_s, init_done_s, prev_wr_state_s)
    begin
        next_state <= current_state;
        wrreq_s <= '0';
        rdreq_s <= '0';
        bram_2_wren_s <= '0';

        if rd_done_s = '1' then
            next_state <= RD_DONE;
        else
            if counter_s = 6 then
                if fifo_empty_s = '1' then
                    next_state <= RD_WAIT;
                else
                    next_state <= RD_FIFO;
                    rdreq_s <= '1';
                    bram_2_wren_s <= '1';
                end if;
            else
                case current_state is
                    when WR_FIFO =>
                        if wr_done_s = '1' then
                            next_state <= WR_DONE;
                        elsif fifo_almost_full_s = '1' then
                            next_state <= WR_WAIT;
                        else
                            next_state <= WR_FIFO;
                            wrreq_s <= '1';
                        end if;

                    when WR_WAIT =>
                        if wr_done_s = '1' then
                            next_state <= WR_DONE;
                        elsif fifo_almost_empty_s = '1' then
                            next_state <= WR_FIFO;
                        else
                            next_state <= WR_WAIT;
                        end if;

                    when RD_FIFO =>
                        if prev_wr_state_s = WR_FIFO then
                            next_state <= WR_FIFO;
                            wrreq_s <= '1';
                        elsif prev_wr_state_s = WR_DONE then
                            next_state <= WR_DONE;
                        else
                            next_state <= WR_WAIT;
                        end if;

                    when RD_WAIT =>
                        if fifo_empty_s = '0' then
                            next_state <= WR_FIFO;
                        else
                            next_state <= RD_WAIT;
                        end if;
                    
                    when BRAM_INIT =>
                        if init_done_s = '1' then
                            next_state <= WR_FIFO;
                        else
                            next_state <= BRAM_INIT;
                        end if;

                    when WR_DONE =>
                        next_state <= WR_DONE;
                        wrreq_s <= '0';

                    when RD_DONE =>
                        next_state <= RD_DONE;
                        rdreq_s <= '0';
                end case;
            end if;
        end if;
    end process;

    DATA_OUT <= bram_2_out_s;

end architecture;
