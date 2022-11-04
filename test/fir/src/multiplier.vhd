library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.fir_pack.all;

-- Multiply two numbers together and truncate the result to satisfy
-- a certain total harmonic distortion while reducing the area
-- of the multiplier itself.
entity multiplier is
    -- Yes, I know that genrics are more powerful but I wanted to try
    -- stuff with packages :)
    port (
        a, b : in word_t;
            c : out mult_t
    );
end multiplier;

architecture beh of multiplier is
    signal true_mult : true_mult_t := (others => '0');
begin
    true_mult <= a * b;
    c <= true_mult(true_mult_t'length-1 downto (true_mult_t'length - mult_t'length));
    -- c <= resize(true_mult, mult_t'length);

end beh;