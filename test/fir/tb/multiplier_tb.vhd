library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.fir_pack.all;

entity multiplier_tb is
begin
end multiplier_tb;

architecture tb of multiplier_tb is
    component multiplier is
        port (
            a, b : in word_t;
            c : out mult_t
            );
    end component;

    signal a, b: word_t := (others => '0');
    -- signal c: mult_t := (others => '0');
    signal c: mult_t := (others => '0');
    -- signal c : signed(23 downto 0) := (others => '0');
begin
    tb_proc : process is
    begin
        for i in 1 to 20 loop
            a <= to_signed(-i*5, word_t'length);
            b <= to_signed(i*3, word_t'length);
            -- c <= (a * b);
            report "a = " & integer'image(to_integer(a)) 
                & " b = " & integer'image(to_integer(b)) 
                & " c = " & integer'image(to_integer(c));
            wait for 10 ns;
        end loop;
        wait;
    end process;

    uut : multiplier port map 
    (
        a => a,
        b => b,
        c => c
    );
end architecture;
