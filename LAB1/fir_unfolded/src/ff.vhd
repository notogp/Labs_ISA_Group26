library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ff is
	 port ( CLK		: in std_logic;
		    RST_N	: in std_logic;
		    ENABLE 	: in std_logic;
		    REG_IN 	: in std_logic;
		    REG_OUT : out std_logic);
end ff;

architecture behavioural of ff is

begin

REGPROCff: process(CLK, RST_N)
	begin
		if(RST_N = '0') then
			REG_OUT <= '0';
			elsif(CLK'EVENT AND CLK = '1') then
				if(ENABLE = '1') then
				REG_OUT <= REG_IN;
			end if;
		end if;

end process;

end architecture;
