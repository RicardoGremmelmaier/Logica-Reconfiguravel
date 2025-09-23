library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TotalizadorA is
	PORT(
		CLK: 		in std_logic;
		DataIn: 	in std_logic_vector(3 downto 0);
		DataOut: out std_logic_vector(2 downto 0)
	);
end entity;

architecture arch of TotalizadorA is
	signal counter: unsigned(2 downto 0) := (others => '0');
	signal iterator: unsigned (2 downto 0) := (others => '0');

	type state_type is (CONTANDO, FINALIZADO);
	signal current_state, next_state: state_type;

begin
-- Logica para o proximo estado
	process(current_state, iterator)
	begin
		case current_state is
			when CONTANDO =>
				if iterator = 3 then
					next_state <= FINALIZADO;
				else
					next_state <= CONTANDO;
				end if;
			when FINALIZADO =>
				next_state <= CONTANDO;
		end case;
	end process;

-- Logica sequencial para transicoes
	process(CLK)
	begin
		if rising_edge(CLK) then
			current_state <= next_state;

			case current_state is
				when CONTANDO =>
					if DataIn(to_integer(iterator)) = '1' then
						counter <= counter + 1;
					end if;
					iterator <= iterator + 1;

				when FINALIZADO =>
					DataOut <= std_logic_vector(counter);
					iterator <= (others => '0');
					counter <= (others => '0');
			end case;
		end if;
	end process;
		
end architecture;