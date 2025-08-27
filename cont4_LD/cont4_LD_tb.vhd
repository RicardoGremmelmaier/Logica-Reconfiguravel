Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cont4_LD_tb is
end entity;
architecture arch of cont4_LD_tb is

signal CLK : std_logic;
signal RST : std_logic;
signal Q   : std_logic_vector(4 downto 0);
signal EN  : std_logic;
signal CLR : std_logic;
signal LD  : std_logic;
signal LOAD: std_logic_vector (4 downto 0);
signal Q_unsi: unsigned (4 downto 0);



component cont4_LD is
	PORT(RST: in std_logic;
	     CLK: in std_logic;
		   Q: out std_logic_vector(4 downto 0);
		   EN: in std_logic;
		   CLR: in std_logic;
		   LD:  in std_logic;
		   LOAD: in std_logic_vector (4 downto 0);
			Q_unsi: out unsigned (4 downto 0));
			end component;  
begin
     UUT: cont4_LD
	port map
	     (RST => RST,
	      CLK => clk,
			Q   => Q,
			EN  => EN,
			CLR => clr,
			LD  => ld,
			LOAD=> load,
			Q_unsi => Q_unsi);

process
	begin
		clk <= '0';
		wait for 15 ns;
		clk <= '1';
		wait for 15 ns;
	end process;	

	process
	begin
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait;
	end process;	

   EN   <= '1';   
   CLR  <= '0';   
   LD   <= '0';   
   LOAD <= (others => '1');   

	
	
	end architecture;
