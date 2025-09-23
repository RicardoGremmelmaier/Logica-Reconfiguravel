library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TotalizadorB is
	PORT(
		CLK: 		in std_logic;
		DataIn: 	in std_logic_vector(3 downto 0);
		DataOutB1: out std_logic_vector(2 downto 0);
		DataOutB2: out std_logic_vector(2 downto 0);
		DataOutB3: out std_logic_vector(2 downto 0);
		DataOutB4: out std_logic_vector(2 downto 0);
		DataOutB5: out std_logic_vector(2 downto 0)
	);
end entity;

architecture arch of TotalizadorB is
	signal total_b1_s: unsigned(2 downto 0) := (others => '0');
	signal total_b2_s: unsigned(2 downto 0) := (others => '0');
	signal total_b3_s: unsigned(2 downto 0) := (others => '0');
	signal total_b4_s: unsigned(2 downto 0) := (others => '0');
	signal total_b5_s: unsigned(2 downto 0) := (others => '0');


begin

-- Totalizador B1	
	process(CLK)
		variable counter_v: unsigned(2 downto 0);
	begin
		if rising_edge(CLK) then
			counter_v := (others => '0');
			for i in 0 to 3 loop
				if DataIn(i) = '1' then
					counter_v := counter_v + 1;
				end if;
			end loop;
			total_b1_s <= counter_v;
		end if;
	end process;
	
-- Totalizador B2
	process(CLK)
		variable i: integer range 0 to 4;
		variable counter_v: unsigned(2 downto 0);
	begin
		if rising_edge(CLK) then
			i := 0;
			counter_v := (others => '0');
			while i < 4 loop
				if DataIn(i) = '1' then
					counter_v := counter_v + 1;
				end if;
				i := i + 1;
			end loop;
			total_b2_s <= counter_v;
		end if;
	end process;

-- Totalizador B3
	process(CLK)
		variable counter_v: unsigned(2 downto 0);
	begin
		if rising_edge(CLK) then
			counter_v := (others => '0');
			if DataIn(0) = '1' then
				counter_v := counter_v + 1;
			end if;
			if DataIn(1) = '1' then
				counter_v := counter_v + 1;
			end if;
			if DataIn(2) = '1' then
				counter_v := counter_v + 1;
			end if;
			if DataIn(3) = '1' then
				counter_v := counter_v + 1;
			end if;
			total_b3_s <= counter_v;
		end if;
	end process;

-- Totalizador B4
	process (CLK)
	begin
		if rising_edge(CLK) then
			case DataIn is
				when "0000" => 
					total_b4_s <= "000";
				
				when "0001" | "0010" | "0100" | "1000" => 
					total_b4_s <= "001"; 
					
				when "0011" | "0101" | "0110" | "1001" | "1010" | "1100" =>
					total_b4_s <= "010";
					
				when "0111" | "1011" | "1101" | "1110" => 
					total_b4_s <= "011";
					
				when "1111" => 
					total_b4_s <= "100";
					
				when others => 
					total_b4_s <= "000";
			end case;
		end if;
	end process;

-- Totalizador B5
	process(CLK)
	begin	
		if rising_edge(CLK) then
			total_b5_s <= to_unsigned(to_integer(unsigned(DataIn(0 downto 0))) + 
											  to_integer(unsigned(DataIn(1 downto 1))) +
											  to_integer(unsigned(DataIn(2 downto 2))) +
											  to_integer(unsigned(DataIn(3 downto 3))), 3);
		end if;
	end process;
	
-- Associacoes de sinais as portas
DataOutB1 <= std_logic_vector(total_b1_s);
DataOutB2 <= std_logic_vector(total_b2_s);
DataOutB3 <= std_logic_vector(total_b3_s);
DataOutB4 <= std_logic_vector(total_b4_s);
DataOutB5 <= std_logic_vector(total_b5_s);

end architecture;