LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UserHW is
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
end entity;

architecture arch of UserHW is

component reg32_sc is
	PORT(
		CLK			: in  std_logic;
		RST_n		   : in  std_logic;
		WR_EN		   : in  std_logic;
		SC			   : in  std_logic;
		DataIn		: in  std_logic_vector(31 downto 0);
		DataOut  	: out std_logic_vector(31 downto 0)
	);
end component;

component bram1024x32 is
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		clock			: IN STD_LOGIC ;
		data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren			: IN STD_LOGIC ;
		q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

signal wr_en0_s, wr_en1_s, wr_en2_s: std_logic := '0';
signal rd_en_bram_s, rd_en_reg0_s, rd_en_reg1_s, rd_en_reg2_s: std_logic := '0';
signal reg0_out_s, reg1_out_s, reg2_out_s, bram_out_s: std_logic_vector(31 downto 0) := (others => '0');  

begin
--============================Instances============================--

-- Registrador 0, registrador de endereços da BRAM
	reg0: reg32_sc port map(
		CLK     => CLK,
		RST_n   => RST_n,
		WR_EN   => wr_en0_s,
		SC		  => '0',
		DataIn  => WriteData,
		DataOut => reg0_out_s
	);
	
-- Registrador 1, registrador de dados da BRAM
	reg1: reg32_sc port map(
		CLK     => CLK,
		RST_n   => RST_n,
		WR_EN   => wr_en1_s,
		SC		  => '0',
		DataIn  => WriteData,
		DataOut => reg1_out_s
	);
	
-- Registrador 2, registrador de controle da BRAM
	reg2: reg32_sc port map(
		CLK     => CLK,
		RST_n   => RST_n,
		WR_EN   => wr_en2_s,
		SC		  => '1',
		DataIn  => WriteData,
		DataOut => reg2_out_s
	);
	
-- BRAM
	bram0: bram1024x32 port map(
		address => reg0_out_s(9 downto 0),
		clock   => CLK,
		data    => reg1_out_s,
		wren   => reg2_out_s(0),
		q       => bram_out_s
	);
--============================Write Enable============================--

-- Reg0: Add tem que ser 00
	wr_en0_s <= WR_EN and ChipSelector and ((not ADD(1)) and (not ADD(0)));
-- Reg1: Add tem que ser 01
	wr_en1_s <= WR_EN and ChipSelector and ((not ADD(1)) and (    ADD(0)));
-- Reg2: Add tem que ser 10	
	wr_en2_s <= WR_EN and ChipSelector and ((    ADD(1)) and (not ADD(0)));
	
--============================Read MUX============================--

-- Saida do UserHW
	ReadData <= reg0_out_s when rd_en_reg0_s = '1' else
					reg1_out_s when rd_en_reg1_s = '1' else
					reg2_out_s when rd_en_reg2_s = '1' else
					bram_out_s when rd_en_bram_s = '1' else
					(others => 'Z');
					
-- Reg0: Add tem que ser 00
	rd_en_reg0_s <= RD_EN and ChipSelector and ((not ADD(1)) and (not ADD(0)));
-- Reg1: Add tem que ser 01
	rd_en_reg1_s <= RD_EN and ChipSelector and ((not ADD(1)) and (    ADD(0)));
-- Reg2: Add tem que ser 10	
	rd_en_reg2_s <= RD_EN and ChipSelector and ((    ADD(1)) and (not ADD(0)));
-- BRAM: Add tem que ser 11	
	rd_en_bram_s <= RD_EN and ChipSelector and ((    ADD(1)) and (    ADD(0)));
	
end architecture;