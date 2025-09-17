Library IEEE;
use IEEE.std_logic_1164.all;

entity binTo7Seg is
	port(
		DataIn: in std_logic_vector(3 downto 0);
		DataOut: out std_logic_vector(7 downto 0)
	);
end binTo7Seg;
	
architecture func of binTo7Seg is
	signal B0, B1, B2, B3 : std_logic := '0';
	signal seg0, seg1, seg2, seg3, seg4, seg5, seg6 : std_logic;
	
	begin
	
	B0 <= DataIn(0);
	B1 <= DataIn(1);
	B2 <= DataIn(2);
	B3 <= DataIn(3);
	
	seg0 <= (NOT(B3) AND NOT(B2) AND NOT(B1) AND B0) OR 
			  (NOT(B3) AND B2 AND NOT(B1) AND NOT(B0)) OR
			  (B3 AND B2 AND NOT(B1) AND B0) OR
			  (B3 AND NOT(B2)AND B1 AND B0);
	
	seg1 <= (B3 AND B2 AND NOT(B0)) OR
			  (B3 AND B1 AND B0) OR
			  (B2 AND B1 AND NOT(B0))OR
			  (NOT(B3) AND B2 AND NOT(B1) AND B0);
			  
	seg2 <= (NOT(B3) AND NOT(B2) AND B1 AND NOT(B0)) OR
			  (B3 AND B2 AND NOT(B0)) OR
			  (B3 AND B2 AND B1);
			  
	seg3 <= (B3 AND NOT(B2) AND B1 AND NOT(B0)) OR
			  (B2 AND B1 AND B0) OR
			  (NOT(B3)AND B2 AND NOT(B1) AND NOT(B0)) OR
			  (NOT(B3) AND NOT(B2) AND NOT(B1) AND B0);
			  
	seg4 <= (NOT(B3) AND B2 AND NOT(B1)) OR
			  (NOT(B2) AND NOT(B1) AND B0) OR
			  (NOT(B3) AND B0);
			  
	seg5 <= (B3 AND B2 AND NOT(B1) AND B0) OR
			  (NOT(B3) AND NOT(B2) AND B0) OR
			  (NOT(B3) AND NOT(B2) AND B1) OR
			  (NOT(B3) AND B1 AND B0);
			  
	seg6 <= (B3 AND B2 AND NOT(B1) AND NOT(B0)) OR
			  (NOT(B3) AND B2 AND B1 AND B0) OR
			  (NOT(B3) AND NOT(B2) AND NOT(B1));
			  
			  
	DataOut(0) <= seg0;
	DataOut(1) <= seg1;
	DataOut(2) <= seg2;
	DataOut(3) <= seg3;
	DataOut(4) <= seg4;
	DataOut(5) <= seg5;
	DataOut(6) <= seg6;
	DataOut(7) <= '0';
	
	end func;