library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
  generic ( NBIT : integer := 12);
	 port ( CLK		: in std_logic;
		    RST_N	: in std_logic;
		    ENABLE 	: in std_logic;
		    REG_IN 	: in signed(NBIT-1 downto 0);
		    REG_OUT : out signed(NBIT-1 downto 0));
end reg;

architecture behavioural of reg is

begin

REGPROC: process(CLK, RST_N)
	begin
		if(RST_N = '0') then
			REG_OUT <= (others => '0');
			elsif(CLK'EVENT AND CLK = '1') then
				if(ENABLE = '1') then
				REG_OUT <= REG_IN;
			end if;
		end if;

end process;

end architecture;
