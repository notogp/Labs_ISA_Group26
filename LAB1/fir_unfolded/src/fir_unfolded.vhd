library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--source /eda/scripts/init_questa_core_prime


entity myfir_unfolded is
 generic ( NBIT : integer := 12);
   	port ( CLK      : in std_logic;           
		   RST_n    : in std_logic;          
		   DIN3k    : in signed(NBIT-1 downto 0);
		   DIN3k1   : in signed(NBIT-1 downto 0);
		   DIN3k2   : in signed(NBIT-1 downto 0);
		   VIN      : in std_logic;         
		   B0       : in signed(NBIT-1 downto 0); 
		   B1       : in signed(NBIT-1 downto 0); 
		   B2       : in signed(NBIT-1 downto 0); 
		   B3       : in signed(NBIT-1 downto 0); 
		   B4       : in signed(NBIT-1 downto 0); 
		   B5       : in signed(NBIT-1 downto 0); 
		   B6       : in signed(NBIT-1 downto 0); 
		   B7       : in signed(NBIT-1 downto 0); 
		   B8       : in signed(NBIT-1 downto 0); 
		   DOUT3k   : out signed(NBIT-1 downto 0); 
		   DOUT3k1  : out signed(NBIT-1 downto 0); 
    	   DOUT3k2  : out signed(NBIT-1 downto 0); 
		   VOUT     : out std_logic
	);
end entity;

architecture behavioural of myfir_unfolded is

	component REG is
		port( CLK		: in std_logic;
			  RST_N	: in std_logic;
			  ENABLE 	: in std_logic;
			  REG_IN 	: in signed(NBIT-1 downto 0);
			  REG_OUT : out signed(NBIT-1 downto 0));
	end component;

	type registers_array is array (4 downto 0) of signed(NBIT-1 downto 0); -- Array for the delay line
	type bcoeff_array is array (8 downto 0) of signed(NBIT-1 downto 0);     -- Array for the coefficients
	type mult_array is array (8 downto 0) of signed(2*NBIT-1 downto 0);    -- Array for the results of multiplications
	type mult_array_12 is array (8 downto 0) of signed(NBIT-1 downto 0);    -- Array for the results of multiplications
	type sum_array is array (7 downto 0) of signed(NBIT-1 downto 0);            -- Array for the results of additions

	signal bcoeff     : bcoeff_array;
	signal reg_line   : registers_array;
	signal mult_3k        : mult_array;
	signal mult_3k1       : mult_array;
	signal mult_3k2       : mult_array;
	signal mult_12_3k     : mult_array_12;
	signal mult_12_3k1    : mult_array_12;
	signal mult_12_3k2    : mult_array_12;
	signal sum_3k         : sum_array;
	signal sum_3k1        : sum_array;
	signal sum_3k2        : sum_array;
	signal VIN_s : std_logic;
	signal reg_DIN_3k : signed(NBIT-1 downto 0);
	signal reg_DIN_3k1 : signed(NBIT-1 downto 0);
	signal reg_DIN_3k2 : signed(NBIT-1 downto 0);
	signal reg_DIN_3k_signal : signed(NBIT-1 downto 0);
	signal reg_DIN_3k1_signal : signed(NBIT-1 downto 0);
	signal reg_DIN_3k2_signal : signed(NBIT-1 downto 0);
	signal reg_DOUT_3k : signed(NBIT-1 downto 0);
	signal reg_DOUT_3k1 : signed(NBIT-1 downto 0);
	signal reg_DOUT_3k2 : signed(NBIT-1 downto 0);
	signal cnt : integer range 0 to 2;

	constant tco : time := 10 ns;

begin

	bcoeff(0) <= B0;
	bcoeff(1) <= B1;
	bcoeff(2) <= B2;
	bcoeff(3) <= B3;
	bcoeff(4) <= B4;
	bcoeff(5) <= B5;
	bcoeff(6) <= B6;
	bcoeff(7) <= B7;
	bcoeff(8) <= B8;
	
---------------------------------------------------------------------------------------		
input_register3k : reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
	          REG_IN => DIN3k,
			  REG_OUT => reg_DIN_3k);

input_register3k1 : reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
			  REG_IN => DIN3k1,
			  REG_OUT => reg_DIN_3k1);

input_register3k2 : reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
	          REG_IN => DIN3k2,
			  REG_OUT => reg_DIN_3k2);
---------------------------------------------------------------------------------------
reg3k: reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
	          REG_IN => reg_DIN_3k,
			  REG_OUT => reg_DIN_3k_signal);

reg3k1: reg 
	port map( CLK => CLK, 
			RST_N => RST_N, 
			ENABLE => VIN,
			REG_IN => reg_DIN_3k1,
			REG_OUT => reg_DIN_3k1_signal);

reg3k2: reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
			  REG_IN => reg_DIN_3k2,
			  REG_OUT => reg_DIN_3k2_signal);
---------------------------------------------------------------------------------------
-- REGISTERS
	registers_generate : for i in 0 to 4 generate
		first_reg_generate : if i=0 generate	
			first_register : reg 
			port map( CLK => CLK, 
					  RST_N => RST_N, 
					  ENABLE => VIN,
			          REG_IN => reg_DIN_3k_signal,
					  REG_OUT => reg_line(i));
		end generate first_reg_generate; 

		regs_generate : if i>0 generate
			register_line : reg 
			port map( CLK => CLK, 
					  RST_N => RST_N, 
					  ENABLE => VIN,
				      REG_IN => reg_line(i-1), 
			          REG_OUT => reg_line(i));
		end generate regs_generate;
	end generate registers_generate; 

---------------------------------------------------------------------------------------
--MULTIPLIERS 3K
	multipliers_generate3k : for i in 0 to 8 generate
		
		first_mult_generate3k : if i=0 generate	
			mult_3k(i) <= bcoeff(i) * reg_DIN_3k;
		end generate first_mult_generate3k;

		second_mult_generate3k : if i=1 generate	
			mult_3k(i) <= bcoeff(i) * reg_DIN_3k2_signal;
		end generate second_mult_generate3k;

		third_mult_generate3k : if i=2 generate	
			mult_3k(i) <= bcoeff(i) * reg_DIN_3k1_signal;
		end generate third_mult_generate3k;

		fourth_mult_generate3k : if i=3 generate	
			mult_3k(i) <= bcoeff(i) * reg_DIN_3k_signal;
		end generate fourth_mult_generate3k;

		mults_generate3k : if i>3 generate
			mult_3k(i) <= bcoeff(i) * reg_line(i - 4);
		end generate mults_generate3k; -- multipliers with correction
	
	end generate multipliers_generate3k;

	multipliers12_generate3k : for i in 0 to 8 generate
		mult_12_3k(i) <= ((mult_3k(i)(2*NBIT - 1 downto 2*NBIT - 8)) & "0000");
	end generate multipliers12_generate3k;
---------------------------------------------------------------------------------------	
-- ADDERS 3K	
	adders_generate3k : for i in 0 to 7 generate
		
		first_add_generate3k : if i=0 generate	
			sum_3k(i) <= mult_12_3k(i) + mult_12_3k(i + 1);
    	end generate first_add_generate3k;

		adds_generate3k : if i>0 and i<7 generate 
			sum_3k(i) <= sum_3k(i-1) + mult_12_3k(i + 1);
    	end generate adds_generate3k;
		
		last_add_generate3k : if i=7 generate
			reg_DOUT_3k <= sum_3k(i-1) + mult_12_3k(i + 1);
		end generate last_add_generate3k;
	
	end generate adders_generate3k; -- adders
---------------------------------------------------------------------------------------
-- MULTIPLIERS 3K1
multipliers_generate3k1 : for i in 0 to 8 generate
		
first_mult_generate3k1 : if i=0 generate	
	mult_3k1(i) <= bcoeff(i) * reg_DIN_3k1;
end generate first_mult_generate3k1;

second_mult_generate3k1 : if i=1 generate	
	mult_3k1(i) <= bcoeff(i) * reg_DIN_3k;
end generate second_mult_generate3k1;

third_mult_generate3k1 : if i=2 generate	
	mult_3k1(i) <= bcoeff(i) * reg_DIN_3k2_signal;
end generate third_mult_generate3k1;

fourth_mult_generate3k1 : if i=3 generate	
	mult_3k1(i) <= bcoeff(i) * reg_DIN_3k1_signal;
end generate fourth_mult_generate3k1;

fifth_mult_generate3k1 : if i=4 generate	
	mult_3k1(i) <= bcoeff(i) * reg_DIN_3k_signal;
end generate fifth_mult_generate3k1;

mults_generate3k1 : if i>4 generate
	mult_3k1(i) <= bcoeff(i) * reg_line(i - 5);
end generate mults_generate3k1; -- multipliers with correction

end generate multipliers_generate3k1;

multipliers12_generate3k1 : for i in 0 to 8 generate
	mult_12_3k1(i) <= ((mult_3k1(i)(2*NBIT - 1 downto 2*NBIT - 8)) & "0000");
end generate multipliers12_generate3k1;
---------------------------------------------------------------------------------------
-- ADDERS 3K1
adders_generate3k1 : for i in 0 to 7 generate
		
first_add_generate3k1 : if i=0 generate	
	sum_3k1(i) <= mult_12_3k1(i) + mult_12_3k1(i + 1);
end generate first_add_generate3k1;

adds_generate3k1 : if i>0 and i<7 generate 
	sum_3k1(i) <= sum_3k1(i-1) + mult_12_3k1(i + 1);
end generate adds_generate3k1;

last_add_generate3k1 : if i=7 generate
	reg_DOUT_3k1 <= sum_3k1(i-1) + mult_12_3k1(i + 1);
end generate last_add_generate3k1;

end generate adders_generate3k1; -- adders
---------------------------------------------------------------------------------------
-- MULTIPLIERS 3K2
multipliers_generate3k2 : for i in 0 to 8 generate
		
first_mult_generate3k2 : if i=0 generate	
	mult_3k2(i) <= bcoeff(i) * reg_DIN_3k2;
end generate first_mult_generate3k2;

second_mult_generate3k2 : if i=1 generate	
	mult_3k2(i) <= bcoeff(i) * reg_DIN_3k1;
end generate second_mult_generate3k2;

third_mult_generate3k2 : if i=2 generate	
	mult_3k2(i) <= bcoeff(i) * reg_DIN_3k;
end generate third_mult_generate3k2;

fourth_mult_generate3k2 : if i=3 generate	
	mult_3k2(i) <= bcoeff(i) * reg_DIN_3k2_signal;
end generate fourth_mult_generate3k2;

fifth_mult_generate3k2 : if i=4 generate	
	mult_3k2(i) <= bcoeff(i) * reg_DIN_3k1_signal;
end generate fifth_mult_generate3k2;

sixth_mult_generate3k2 : if i=5 generate	
	mult_3k2(i) <= bcoeff(i) * reg_DIN_3k_signal;
end generate sixth_mult_generate3k2;

mults_generate3k2 : if i>5 generate
	mult_3k2(i) <= bcoeff(i) * reg_line(i - 6);
end generate mults_generate3k2; -- multipliers with correction

end generate multipliers_generate3k2;

multipliers12_generate3k2 : for i in 0 to 8 generate
	mult_12_3k2(i) <= ((mult_3k2(i)(2*NBIT - 1 downto 2*NBIT - 8)) & "0000");
end generate multipliers12_generate3k2;
---------------------------------------------------------------------------------------
-- ADDERS 3K2
adders_generate3k2 : for i in 0 to 7 generate
		
first_add_generate3k2 : if i=0 generate	
	sum_3k2(i) <= mult_12_3k2(i) + mult_12_3k2(i + 1);
end generate first_add_generate3k2;

adds_generate3k2 : if i>0 and i<7 generate 
	sum_3k2(i) <= sum_3k2(i-1) + mult_12_3k2(i + 1);
end generate adds_generate3k2;

last_add_generate3k2 : if i=7 generate
	reg_DOUT_3k2 <= sum_3k2(i-1) + mult_12_3k2(i + 1);
end generate last_add_generate3k2;

end generate adders_generate3k2; -- adders
---------------------------------------------------------------------------------------

output_register3k : reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
	          REG_IN => reg_DOUT_3k,
			  REG_OUT => DOUT3k);

output_register3k1 : reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
			  REG_IN => reg_DOUT_3k1,
			  REG_OUT => DOUT3k1);

output_register3k2 : reg 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => VIN,
	          REG_IN => reg_DOUT_3k2,
			  REG_OUT => DOUT3k2);
---------------------------------------------------------------------------------------


	VIN_s <= VIN;

	valid_proc : process(CLK) is 
	variable cnt : integer := 0;
	begin
		if RST_N = '0' then 
			cnt := 0;
		elsif rising_edge(CLK) then
			if (VIN_s = '1') or (cnt > 1) then
				cnt := cnt + 1;
				if (cnt > 1) then 
					VOUT <= VIN_s;
					cnt := 2;
				end if; 
			end if; 
		end if;
	end process valid_proc;

end architecture;
