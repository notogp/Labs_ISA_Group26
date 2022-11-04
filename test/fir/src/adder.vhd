library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.fir_pack.all;

-- no generics for now, lets keep everyting whitin the package
entity adder is 
    port (
        a, b : in word_t;
        sum : out word_t
    );
end adder;

-- Architecture is not specified at this time.
-- It just adds two words 
architecture beh of adder is 
begin
    sum <= a + b;
end beh;
