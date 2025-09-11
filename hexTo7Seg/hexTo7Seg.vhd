Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hexTo7Seg is
	port(	DataIn	:	in	std_logic_vector(3 downto 0);
			DataOut	:	out std_logic_vector(7 downto 0)
	);
	
end entity;
  
architecture arch of hexTo7Seg is
	
signal data_in_s	:	std_logic_vector(3 downto 0);

begin

	data_in_s <= DataIn;

	DataOut <= "11111001" when data_in_s = "0001"
					else "10100100" when data_in_s = "0010"
					else "10110000" when data_in_s = "0011"
					else "10011001" when data_in_s = "0100"
					else "10010010" when data_in_s = "0101"
					else "10000010" when data_in_s = "0110"
					else "11111000" when data_in_s = "0111"
					else "10000000" when data_in_s = "1000"
					else "10010000" when data_in_s = "1001"
					else "11000000";
					
end architecture;