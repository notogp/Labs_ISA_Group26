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

	component ff is
		port ( CLK  	  : in std_logic;
			   RST_N	  : in std_logic;
			   ENABLE  : in std_logic;
			   REG_IN  : in std_logic;
			   REG_OUT : out std_logic);
   end component;

	type registers_array is array (7 downto 0) of signed(NBIT-1 downto 0); -- Array for the delay line
	type bcoeff_array is array (8 downto 0) of signed(NBIT-1 downto 0);     -- Array for the coefficients
	type mult_array is array (8 downto 0) of signed(2*NBIT-1 downto 0);    -- Array for the results of multiplications
	type mult_array_12 is array (8 downto 0) of signed(NBIT-1 downto 0);    -- Array for the results of multiplications
	type sum_array is array (7 downto 0) of signed(NBIT-1 downto 0);            -- Array for the results of additions

	signal bcoeff     : bcoeff_array;
	signal reg_line   : registers_array;
	signal mult       : mult_array;
	signal mult_12    : mult_array_12;
	signal sum        : sum_array;
	signal VIN_s : std_logic;
	signal VIN_s1 : std_logic;
	signal VIN_s2 : std_logic;
	signal reg_DIN : signed(NBIT-1 downto 0);
	signal reg_DOUT : signed(NBIT-1 downto 0);
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
	input_register : reg 
		port map( CLK => CLK, 
				  RST_N => RST_N, 
				  ENABLE => VIN,
		          REG_IN => DIN,
				  REG_OUT => reg_DIN);
---------------------------------------------------------------------------------------

	registers_generate : for i in 0 to 7 generate
		first_reg_generate : if i=0 generate	
			input_register : reg 
			port map( CLK => CLK, 
					  RST_N => RST_N, 
					  ENABLE => VIN,
			          REG_IN => reg_DIN,
					  REG_OUT => reg_line(i));
		end generate first_reg_generate; 

		regs_generate : if i>0 generate
			register_line : reg 
			port map( CLK => CLK, 
					  RST_N => RST_N, 
					  ENABLE => VIN,
				      REG_IN => reg_line(i - 1), 
			          REG_OUT => reg_line(i));
		end generate regs_generate;
	end generate registers_generate; 

---------------------------------------------------------------------------------------

	multipliers_generate : for i in 0 to 8 generate
		
		first_mult_generate : if i=0 generate	
			mult(i) <= bcoeff(i) * reg_DIN;
		end generate first_mult_generate;

		mults_generate : if i>0 generate
			mult(i) <= bcoeff(i) * reg_line(i - 1);
		end generate mults_generate; -- multipliers with correction
	
	end generate multipliers_generate;
---------------------------------------------------------------------------------------
	multipliers12_generate : for i in 0 to 8 generate
		mult_12(i) <= ((mult(i)(2*NBIT - 1 downto 2*NBIT - 8)) & "0000");
	end generate;
	
	
	adders_generate : for i in 0 to 7 generate
		
		first_add_generate : if i=0 generate	
			sum(i) <= mult_12(i) + mult_12(i + 1);
    	end generate first_add_generate;

		adds_generate : if i>0 and i<7 generate 
			sum(i) <= sum(i-1) + mult_12(i + 1);
    	end generate adds_generate;
		
		last_add_generate : if i=7 generate
			reg_DOUT <= sum(i-1) + mult_12(i + 1);
		end generate last_add_generate;
	
	end generate adders_generate; -- adders

---------------------------------------------------------------------------------------

	output_register : reg 
		port map( CLK => CLK, 
				  RST_N => RST_N, 
				  ENABLE => VIN_s1,
				  REG_IN => reg_DOUT, 
				  REG_OUT => DOUT);

	VIN_s <= VIN;

	FFdelay1 : ff 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => '1',
	          REG_IN => VIN_s,
			  REG_OUT => VIN_s1);
	FFdelay2 : ff 
	port map( CLK => CLK, 
			  RST_N => RST_N, 
			  ENABLE => '1',
	          REG_IN => VIN_s1,
			  REG_OUT => VIN_s2);
    
    --FFdelay3 : ff 
    --port map( CLK => CLK, 
  	--		RST_N => RST_N, 
  	--		ENABLE => '1',
  	--		REG_IN => VIN_s2,
  	--		REG_OUT => VOUT);
			  
	VOUT <= VIN_s2;
	--valid_proc : process(CLK) is 
	--variable cnt : integer := 0;
	--begin
	--	if RST_N = '0' then 
	--		cnt := 0;
	--	elsif rising_edge(CLK) then
	--		if (VIN_s = '1') or (cnt > 1) then
	--			cnt := cnt + 1;
	--			if (cnt > 1) then 
	--				VOUT <= VIN_s;
	--				cnt := 2;
	--			end if; 
	--		end if; 
	--	end if;
	--end process valid_proc;

end architecture;
