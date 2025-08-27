Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cont4_LD is
	PORT(RST: in std_logic;
	     CLK: in std_logic;
		  Q: out std_logic_vector(4 downto 0);
		  Q_unsi: out unsigned(4 downto 0);
		  EN: in std_logic;
		  CLR: in std_logic;
		  LD:  in std_logic;
		  LOAD: in std_logic_vector (4 downto 0));
end entity;  
Architecture X of cont4_LD is
Signal CONT: std_logic_vector (4 downto 0);
Begin
	Process (CLK, RST)
		Begin
		If RST = '1' then
		   CONT <= (others => '0');
		Elsif CLK' event and CLK = '1' then
		   If CLR = '1'then
				CONT <= (others => '0');
			Else
				If EN = '1' then
					If LD = '1' then
						CONT <= LOAD;
					Else
						CONT <= std_logic_vector(unsigned(CONT)+3); --,CONT'length
					End IF;
				End If;
			End If;
		End If;
	End process;
	
	Q <= CONT;
	
	Q_unsi(4) <= CONT(4);
	Q_unsi(3) <= CONT(3);
	Q_unsi(2) <= CONT(2);
	Q_unsi(1) <= CONT(1);
	Q_unsi(0) <= CONT(0);
	
	
End architecture;
