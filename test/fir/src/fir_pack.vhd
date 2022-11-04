library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package fir_pack is
	constant BIT_N : integer := 12; -- word length
	constant ORDER : integer := 8; -- also number of taps
	constant MULT_W : integer := 8;

	subtype word_t is signed(BIT_N-1 downto 0);
	-- extended word length, used as result of a sum
	subtype ext_word_t is signed(BIT_N downto 0);

	subtype mult_t is signed(MULT_W-1 downto 0);
	subtype true_mult_t is signed(2*BIT_N-1 downto 0);

	-- this is veeeeery bad
	subtype zero_padding_t is signed(BIT_N-MULT_W-1 downto 0);

	type word_array_t is array (natural range <>) of word_t;
end fir_pack; 
