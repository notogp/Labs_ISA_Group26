library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--source /eda/scripts/init_questa_core_prime


entity myfir is
 generic ( NBIT : integer := 12);
   	port ( CLK      : in std_logic;           
		   RST_n    : in std_logic;          
		   DIN      : in signed(NBIT-1 downto 0);
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
		   DOUT     : out signed(NBIT-1 downto 0); 
		   VOUT     : out std_logic
	);
end entity;

architecture behavioural of myfir is

	component REG is
		port( CLK		: in std_logic;
			  RST_N	: in std_logic;
			  ENABLE 	: in std_logic;
			  REG_IN 	: in signed(NBIT-1 downto 0);
			  REG_OUT : out signed(NBIT-1 downto 0));
	end component;

	type registers_array is array (8 downto 0) of signed(NBIT-1 downto 0); -- Array for the delay line
	type bcoeff_array is array (8 downto 0) of signed(NBIT-1 downto 0);     -- Array for the coefficients
	type mult_array is array (8 downto 0) of signed(2*NBIT-1 downto 0);    -- Array for the results of multiplications
	type sum_array is array (7 downto 0) of signed(NBIT-1 downto 0);            -- Array for the results of additions

	signal bcoeff     : bcoeff_array;
	signal reg_line   : registers_array;
	signal mult       : mult_array;
	signal sum        : sum_array;
	signal VIN_s : std_logic;
begin

	bcoeff(0) <= B0(NBIT-1 downto 0);
	bcoeff(1) <= B1(NBIT-1 downto 0);
	bcoeff(2) <= B2(NBIT-1 downto 0);
	bcoeff(3) <= B3(NBIT-1 downto 0);
	bcoeff(4) <= B4(NBIT-1 downto 0);
	bcoeff(5) <= B5(NBIT-1 downto 0);
	bcoeff(6) <= B6(NBIT-1 downto 0);
	bcoeff(7) <= B7(NBIT-1 downto 0);
	bcoeff(8) <= B8(NBIT-1 downto 0);
	
---------------------------------------------------------------------------------------		
	input_register : reg 
		port map( CLK => CLK, 
				  RST_N => RST_N, 
				  ENABLE => VIN,
		          REG_IN => DIN,
				  REG_OUT => reg_line(0));

---------------------------------------------------------------------------------------

	registers_generate : for i in 1 to 8 generate
			register_line : reg 
			port map( CLK => CLK, 
					  RST_N => RST_N, 
					  ENABLE => VIN,
				      REG_IN => reg_line(i - 1), 
			          REG_OUT => reg_line(i));
	end generate; 

---------------------------------------------------------------------------------------

	multipliers_generate : for i in 0 to 8 generate
		mult(i) <= bcoeff(i) * reg_line(i);
	end generate; -- multipliers with correction

---------------------------------------------------------------------------------------
	--resize((mult(0)(2*NBIT - 1 downto 2*NBIT - 8) + mult(1)(2*NBIT - 1 downto 2*NBIT - 8)), 12);
	sum(0) <= mult(0)(2*NBIT - 1 downto 2*NBIT - 8) + mult(1)(2*NBIT - 1 downto 2*NBIT - 8) & "0000";
	adders_generate : for i in 1 to 7 generate
		sum(i) <= mult(i)(2*NBIT - 1 downto 2*NBIT - 8) & "0000" + sum(i - 1);
	end generate; -- adders

---------------------------------------------------------------------------------------

	output_register : reg 
		port map( CLK => CLK, 
				  RST_N => RST_N, 
				  ENABLE => VIN,
				  REG_IN => sum(7), 
				  REG_OUT => DOUT);
	
	VIN_s <= VIN;
	VOUT <= VIN_s;

end architecture;
