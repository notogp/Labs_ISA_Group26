library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.fir_pack.all;

-- basic register with async reset
-- holds a single word of our architecture
entity word_reg is
    port (
        rst_n, ld, clk : in std_logic;
        din : in word_t;
        dout : out word_t
    );
end entity;

architecture rtl of word_reg is
begin
    main : process(rst_n, clk) is
    begin
        if (rst_n = '0') then
            dout <= (others => '0');
        elsif rising_edge(clk) then
            if (ld = '1') then
                dout <= din;
            end if;
        end if;
    end process;
end architecture;