library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hexTo7Seg_tb is
end;

architecture arch of hexTo7Seg_tb is
    component hexTo7Seg
        port(DataIn	:	in	std_logic_vector(3 downto 0);
				 DataOut	:	out std_logic_vector(7 downto 0)
        );
		  
    end component;
    signal dataIn : std_logic_vector(3 downto 0);
    signal dataOut : std_logic_vector(7 downto 0);

    begin
        UUT: hexTo7Seg port map 
		  (dataIn => DataIn,
			dataOut => DataOut
			);
        
    process
        begin
        dataIn <= "0001";
        wait for 50 ns;
		  
		  dataIn <= "0010";
        wait for 50 ns;
		  
		  dataIn <= "0011";
        wait for 50 ns;
		  
		  dataIn <= "0100";
        wait for 50 ns;
		  
		  dataIn <= "0101";
        wait for 50 ns;
		  
		  dataIn <= "0110";
        wait for 50 ns;
		  
		  dataIn <= "0111";
        wait for 50 ns;
		  
		  dataIn <= "1000";
        wait for 50 ns;
		  
		  dataIn <= "1001";
        wait for 50 ns;
		  
		  dataIn <= "0000";
        wait for 50 ns;
		    
        wait;
    end process;
end architecture;