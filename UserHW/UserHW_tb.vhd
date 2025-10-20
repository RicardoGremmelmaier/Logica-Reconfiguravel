Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity UserHW_tb is
end entity;
architecture arch of UserHW_tb is

	component UserHW is
		PORT(   
			CLK 			 : in  std_logic;
			RST_n			 : in  std_logic;
			WR_EN			 : in  std_logic;
			RD_EN			 : in  std_logic;
			ChipSelector : in  std_logic;
			ADD			 : in  std_logic_vector(1 downto 0);
			WriteData 	 : in  std_logic_vector(31 downto 0); --DataIn
			ReadData		 : out std_logic_vector(31 downto 0)  --DataOut
		);
	end component;  

-- Sinais de simulacao
	type state_type is (IDLE_ST0, IDLE_ST1, 
							  WRITE_ST0, WRITE_ST1, WRITE_ST2,
							  READ_ST0, READ_ST1, READ_ST2, READ_ST3);
							  
	signal state: state_type;

	signal CLK : std_logic;
	signal rst, rst_n : std_logic;
	signal WriteData_s, ReadData_s : std_logic_vector(31 downto 0) := (others => '0');
	signal ADD_s : std_logic_vector(1 downto 0) := (others => '0');
	signal interval_0, interval_1, counter, address: integer;
	signal ChipSelector_s, WR_EN_s, RD_EN_s: std_logic := '0';
	

-- Constantes
	constant period_time : time := 20 ns;
	signal finished : std_logic := '0';
	
begin

	interval_0 <= 10;
	interval_1 <= 15;

	UUT: UserHW port map(
		CLK 			  => CLK,
		RST_n			  => rst_n,
		WR_EN			  => WR_EN_s,
		RD_EN			  => RD_EN_s,
		ChipSelector  => ChipSelector_s,
		ADD			  => ADD_s,
		WriteData 	  => WriteData_s,
		ReadData		  => ReadData_s
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

-- Reset global
	reset_global: process
	begin
		rst   <= '1';
		rst_n <= '0';
		wait for 15 ns;
		rst   <= '0';
		rst_n <= '1';
		wait;
	end process reset_global;

-- Configuracoes de estados
	process (state)
	begin
		case state is 
			
			when IDLE_ST0 =>
				WriteData_s 	<= x"00000000";
				WR_EN_s 			<= '0';
				RD_EN_s 			<= '0';
				ChipSelector_s <= '0';
				ADD_s 			<= (others => '0');
			when IDLE_ST1 =>
				WriteData_s 	<= (others => '0');
				WR_EN_s 			<= '0';
				RD_EN_s 			<= '0';
				ChipSelector_s <= '0';
				ADD_s 			<= (others => '0');
				
			when WRITE_ST0 => -- EndereÃ§o da BRAM
				WriteData_s 	<= x"00000020";
				WR_EN_s 			<= '1';
				RD_EN_s 			<= '0';
				ChipSelector_s <= '1';
				ADD_s 			<= "00";
			when WRITE_ST1 => -- Dados da BRAM
				WriteData_s 	<= x"12345620";
				WR_EN_s 			<= '1';
				RD_EN_s 			<= '0';
				ChipSelector_s <= '1';
				ADD_s 			<= "01";
			when WRITE_ST2 => -- Controle da BRAM
				WriteData_s 	<= x"00000001";
				WR_EN_s 			<= '1';
				RD_EN_s 			<= '0';
				ChipSelector_s <= '1';
				ADD_s 			<= "10";
				
			when READ_ST0 => -- Leitura Endereco
				WriteData_s 	<= (others => '0');
				WR_EN_s 			<= '0';
				RD_EN_s 			<= '1';
				ChipSelector_s <= '1';
				ADD_s 			<= "00";
			when READ_ST1 => -- Leitura Dados
				WriteData_s 	<= (others => '0');
				WR_EN_s 			<= '0';
				RD_EN_s 			<= '1';
				ChipSelector_s <= '1';
				ADD_s 			<= "01";
			when READ_ST2 => -- Leitura Controle
				WriteData_s 	<= (others => '0');
				WR_EN_s 			<= '0';
				RD_EN_s 			<= '1';
				ChipSelector_s <= '1';
				ADD_s 			<= "10";
			when READ_ST3 => -- Leitura BRAM
				WriteData_s 	<= (others => '0');
				WR_EN_s 			<= '0';
				RD_EN_s 			<= '1';
				ChipSelector_s <= '1';
				ADD_s 			<= "11";
		end case;
	end process;

-- Testbench
	process (RST, CLK)
	begin 
		  
		if rst = '1' then
			counter <= 0;
			state <= IDLE_ST0;
		elsif rising_edge(CLK) then
			counter <= counter + 1;
			case state is 
			
				when IDLE_ST0 => 
					if counter = interval_0 then
						state <= WRITE_ST0;
						counter <= 0;
					end if;
				when IDLE_ST1 =>
					if counter = interval_1 then
						state <= READ_ST0;
						counter <= 0;
					end if;
					
				when WRITE_ST0 =>
					state <= WRITE_ST1;
					counter <= 0;
				when WRITE_ST1 =>
					state <= WRITE_ST2;
					counter <= 0;
				when WRITE_ST2 =>
					state <= IDLE_ST1;
					counter <= 0;
				
				when READ_ST0 =>
					state <= READ_ST1;
					counter <= 0;
				when READ_ST1 =>
					state <= READ_ST2;
					counter <= 0;
				when READ_ST2 =>
					state <= READ_ST3;
					counter <= 0;
				when READ_ST3 =>
					state <= IDLE_ST0;
					counter <= 0;
			end case;
		end if;
	end process;

end architecture;
