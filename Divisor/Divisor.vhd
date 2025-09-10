Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity DIVISOR is

port	(CLK: in std_logic;
		 RST: in std_logic;
		 DIV50: out std_logic
		 );
		 
End entity;

Architecture x of DIVISOR is

SIGNAL CONT: integer range 0 to 50000000;

begin
process (RST,CLK)
begin
	if RST = '1' then
		DIV50 <= '0';
		CONT <= 0;
	Elsif CLK = '1' and CLK'event then
		if CONT = (500000 - 1) then -- 0.01 segundos
			DIV50 <= '1';
			CONT <= 0;
		ELSE
			CONT <= CONT +1;
			DIV50 <= '0';
		end if;
	end if;
end process;
end architecture;