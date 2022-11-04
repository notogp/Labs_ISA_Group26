
library ieee;
use ieee.std_logic_1164.all;
-- ieee.arith is evil!
use ieee.numeric_std.all;

use work.fir_pack.all;

entity myfir is
	 port (	CLK   : in std_logic;
			RST_n : in std_logic;
			VIN   : in std_logic;
			DIN   : in signed(BIT_N-1 downto 0);
			B0	  : in signed(BIT_N-1 downto 0);
			B1	  : in signed(BIT_N-1 downto 0);
			B2	  : in signed(BIT_N-1 downto 0);
			B3	  : in signed(BIT_N-1 downto 0);
			B4	  : in signed(BIT_N-1 downto 0);
			B5	  : in signed(BIT_N-1 downto 0);
			B6	  : in signed(BIT_N-1 downto 0);
			B7	  : in signed(BIT_N-1 downto 0);
			B8	  : in signed(BIT_N-1 downto 0);
			VOUT  : out std_logic;
			DOUT  : out signed(BIT_N-1 downto 0));
end entity;

architecture rtl of myfir is

	component word_reg is
	port (
		rst_n, ld, clk : in std_logic;
		din : in word_t;
		dout : out word_t
	);
	end component;

	component multiplier is 
	port (
		a, b : in word_t;
		c : out mult_t
		);
	end component;

	component adder is 
		port (
			a, b : in word_t;
			sum : out word_t
		);
	end component;

	type mult_res_array is array (natural range <>) of mult_t;
	
	-- ugly but useful for iteration
	signal coefficients_s : word_array_t (0 to ORDER);
	signal sample_regs_out : word_array_t(0 to ORDER-1);
	signal mult_res : mult_res_array(0 to ORDER);
	signal mult_res_ext : word_array_t(0 to ORDER);
	signal sum_res : word_array_t (0 to ORDER-1);
	
	signal reg_din, reg_dout : word_t;

	-- baaaaad
	signal padding : zero_padding_t := (others => '0');

begin
	-- coefficient loading
	coefficients_s <= (B0, B1, B2, B3, B4, B5, B6, B7, B8);

	-- registers on in and out
	inreg : word_reg port map (
		rst_n => RST_n,
		ld => VIN,
		clk => CLK,
		din => DIN,
		dout => reg_din
	);
	outreg : word_reg port map (
		rst_n => RST_n,
		ld => VIN,
		clk => CLK,
		din => reg_dout,
		dout => DOUT
	);

	-- samples register instantiation
	-- generate a bunch of registers that shift the samples when VIN is high
	gen_regs : for i in 0 to ORDER-1 generate   --ORDER = 8
		first_reg : if i=0 generate
			fist_reg_inst : word_reg
				port map (
					rst_n => RST_n, 
					ld => VIN, 
					clk => CLK, 
					din => reg_din, -- already cleaned by the ff
					dout => sample_regs_out(i)
					);
		end generate first_reg;

		other_regs : if i>0 generate
			other_reg_inst : word_reg
				port map (
					rst_n => RST_n, 
					ld => VIN, 
					clk => CLK, 
					din => sample_regs_out(i-1), 
					dout => sample_regs_out(i)
					);
		end generate other_regs;
	end generate gen_regs;

	-- multiply the coeffients by the samples
	-- TODO: check if it's ok that the first sample is taken directly from the input
	-- what if it's glitchy?
	gen_mult : for i in 0 to ORDER generate
		first_mult : if i=0 generate
			first_mult_inst : multiplier
				port map (
					a => reg_din,
					b => coefficients_s(i),
					c => mult_res(i)
					);
		end generate first_mult;

		other_mult : if i>0 generate
			other_mult_inst : multiplier
				port map (
					a => sample_regs_out(i-1),
					b => coefficients_s(i),
					c => mult_res(i)
					);
		end generate other_mult;
	end generate gen_mult;

	-- extend the mult results to word_t
	gen_mult_ext : for i in 0 to ORDER generate
		mult_res_ext(i) <= shift_left((mult_res(i) & padding),1);
	end generate gen_mult_ext;

	
	-- sum all the results
	gen_sum : for i in 0 to ORDER-1 generate
		first_sum_inst : if i=0 generate
			first_adder_inst: adder
				port map (
					a => mult_res_ext(i),
					b => mult_res_ext(i+1),
					sum => sum_res(i)
					);
		end generate first_sum_inst;
		
		mid_sum_inst : if i>0 and i<ORDER-1 generate
			mid_adder_inst: adder
				port map (
					a => sum_res(i-1),
					b => mult_res_ext(i+1),
					sum => sum_res(i)
					);
		end generate mid_sum_inst;	

		last_sum_inst : if i=ORDER-1 generate
			last_adder_inst: adder
				port map (
						a => sum_res(i-1),
						b => mult_res_ext(i+1),
						sum => reg_dout
						);
			end generate last_sum_inst;
	end generate gen_sum;

	-- vout valid with two clock cycles delay
	valid_proc : process (CLK) is
		variable cnt : integer := 0;
		variable vout_v : std_logic := '0';
	begin
		if rising_edge(CLK) then
			if RST_n = '0' then
				cnt := 0;
			elsif VIN = '1' then
				cnt := cnt + 1;
				if cnt > 1 then
					vout_v := '1';
					--cnt := 3;
				else
					vout_v := '0';
				end if;
			end if;
		end if;
	
		VOUT <= vout_v;
	end process valid_proc;

end architecture rtl;
			 
	
	


