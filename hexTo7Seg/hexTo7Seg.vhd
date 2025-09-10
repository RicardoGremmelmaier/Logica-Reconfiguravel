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

	DataOut <= "00000110" when data_in_s = "0001"
					else "01011011" when data_in_s = "0010"
					else "01001111" when data_in_s = "0011"
					else "01100110" when data_in_s = "0100"
					else "01101101" when data_in_s = "0101"
					else "01111101" when data_in_s = "0110"
					else "00000111" when data_in_s = "0111"
					else "01111111" when data_in_s = "1000"
					else "01101111" when data_in_s = "1001"
					else "00111111";
					
end architecture;