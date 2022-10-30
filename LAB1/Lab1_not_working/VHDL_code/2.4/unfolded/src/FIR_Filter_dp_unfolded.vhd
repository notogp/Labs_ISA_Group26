library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity FIR_Filter_dp_unfolded is
	port (
		RST_N    : in std_logic;           -- Control unit
		CTRL_IN  : in std_logic;           -- Control unit
		CLK      : in std_logic;           -- External
    	DIN0     : in signed(NBIT-1 downto 0);
   	 	DIN1     : in signed(NBIT-1 downto 0);
    	DIN2     : in signed(NBIT-1 downto 0); 
		B0       : in signed(NBIT-1 downto 0); -- External
		B1       : in signed(NBIT-1 downto 0); -- External
		B2       : in signed(NBIT-1 downto 0); -- External
		B3       : in signed(NBIT-1 downto 0); -- External
		B4       : in signed(NBIT-1 downto 0); -- External
		B5       : in signed(NBIT-1 downto 0); -- External
		B6       : in signed(NBIT-1 downto 0); -- External
		B7       : in signed(NBIT-1 downto 0); -- External
		B8       : in signed(NBIT-1 downto 0); -- External
		DOUT0     : out signed(NBIT-1 downto 0);
    	DOUT1     : out signed(NBIT-1 downto 0);
    	DOUT2     : out signed(NBIT-1 downto 0)
	);
end entity;

architecture behavioural of FIR_Filter_dp_unfolded is

	component REG is
		port (
			REG_IN 	: in signed(NBIT-1 downto 0);
			REG_OUT : out signed(NBIT-1 downto 0);
			CLK		: in std_logic;
			RST_N	: in std_logic;
			LOAD 	: in std_logic);
	end component;

	type registers_array is array (4 downto 0) of signed(NBIT-1 downto 0); -- Array for the delay line
	type coeff_array is array (8 downto 0) of signed(NBIT-1 downto 0);     -- Array for the coefficients
	type mult_array is array (8 downto 0) of signed(2*NBIT-1 downto 0);    -- Array for the results of multiplications
	type sum_array is array (7 downto 0) of signed(NBIT-1 downto 0);            -- Array for the results of additions

  signal coeff      : coeff_array;
  signal x3k : signed(NBIT-1 downto 0);
  signal x3k1 : signed(NBIT-1 downto 0);
  signal x3k2 : signed(NBIT-1 downto 0);
  
  signal x3k_1 : signed(NBIT-1 downto 0);
  signal x3k1_1 : signed(NBIT-1 downto 0);
  signal x3k2_1 : signed(NBIT-1 downto 0);
  
  signal shift_reg  : registers_array;
  
  signal mult0       : mult_array;
  signal mult1       : mult_array;
  signal mult2       : mult_array;
  
  signal sum0        : sum_array;
  signal sum1        : sum_array;
  signal sum2        : sum_array;



begin

	coeff(0) <= B0(NBIT-1 downto 0);
	coeff(1) <= B1(NBIT-1 downto 0);
	coeff(2) <= B2(NBIT-1 downto 0);
	coeff(3) <= B3(NBIT-1 downto 0);
	coeff(4) <= B4(NBIT-1 downto 0);
	coeff(5) <= B5(NBIT-1 downto 0);
	coeff(6) <= B6(NBIT-1 downto 0);
	coeff(7) <= B7(NBIT-1 downto 0);
	coeff(8) <= B8(NBIT-1 downto 0);
	
	
    xthreek_register : REG 
		port map(REG_IN => DIN0, REG_OUT => x3k, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);
    xthreek1_input_register : REG 
		port map(REG_IN => DIN1, REG_OUT => x3k1, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN); 
    xthreek2_register : REG 
		port map(REG_IN => DIN2, REG_OUT => x3k2, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN); 
	
	xthreek_1_register : REG 
		port map(REG_IN => x3k, REG_OUT => x3k_1, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);
    xthreek1_1_input_register : REG 
		port map(REG_IN => x3k1, REG_OUT => x3k1_1, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN); 
    xthreek2_1_register : REG 
		port map(REG_IN => x3k2, REG_OUT => x3k2_1, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN); 

    one_register : REG 
    port map(REG_IN => x3k_1, REG_OUT => shift_reg(0), CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);
    two_register : REG 
    port map(REG_IN => shift_reg(0), REG_OUT => shift_reg(1), CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);
    three_register : REG 
    port map(REG_IN => shift_reg(1), REG_OUT => shift_reg(2), CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);
    four_register : REG 
    port map(REG_IN => shift_reg(2), REG_OUT => shift_reg(3), CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);
    five_register : REG 
    port map(REG_IN => shift_reg(3), REG_OUT => shift_reg(4), CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);
    

  ----------------------------------------------------------------------------------


    mult0(0) <= coeff(0) * x3k;
    mult0(1) <= coeff(1) * x3k2_1;
    mult0(2) <= coeff(2) * x3k1_1;
    mult0(3) <= coeff(3) * x3k_1;
    mult0(4) <= coeff(4) * shift_reg(0);
    mult0(5) <= coeff(5) * shift_reg(1);
    mult0(6) <= coeff(6) * shift_reg(2);
    mult0(7) <= coeff(7) * shift_reg(3);
    mult0(8) <= coeff(8) * shift_reg(4);

  
   sum0(0) <= mult0(0)(2*NBIT-2 downto NBIT-1) + mult0(1)(2*NBIT-2 downto NBIT-1);
   sum0(1) <= sum0(0) + mult0(2)(2*NBIT-2 downto NBIT-1);
   sum0(2) <= sum0(1) + mult0(3)(2*NBIT-2 downto NBIT-1);
   sum0(3) <= sum0(2) + mult0(4)(2*NBIT-2 downto NBIT-1);
   sum0(4) <= sum0(3) + mult0(5)(2*NBIT-2 downto NBIT-1);
   sum0(5) <= sum0(4) + mult0(6)(2*NBIT-2 downto NBIT-1);
   sum0(6) <= sum0(5) + mult0(7)(2*NBIT-2 downto NBIT-1);
   sum0(7) <= sum0(6) + mult0(8)(2*NBIT-2 downto NBIT-1);

  
  ----------------------------------------------------------------------------------


   mult1(0) <= coeff(0) * x3k1;
   mult1(1) <= coeff(1) * x3k;
   mult1(2) <= coeff(2) * x3k2_1;
   mult1(3) <= coeff(3) * x3k1_1;
   mult1(4) <= coeff(4) * x3k_1;
   mult1(5) <= coeff(5) * shift_reg(0);
   mult1(6) <= coeff(6) * shift_reg(1);
   mult1(7) <= coeff(7) * shift_reg(2);
   mult1(8) <= coeff(8) * shift_reg(3);

  
  sum1(0) <= mult1(0)(2*NBIT-2 downto NBIT-1) + mult1(1)(2*NBIT-2 downto NBIT-1);
  sum1(1) <= sum1(0) + mult1(2)(2*NBIT-2 downto NBIT-1);
  sum1(2) <= sum1(1) + mult1(3)(2*NBIT-2 downto NBIT-1);
  sum1(3) <= sum1(2) + mult1(4)(2*NBIT-2 downto NBIT-1);
  sum1(4) <= sum1(3) + mult1(5)(2*NBIT-2 downto NBIT-1);
  sum1(5) <= sum1(4) + mult1(6)(2*NBIT-2 downto NBIT-1);
  sum1(6) <= sum1(5) + mult1(7)(2*NBIT-2 downto NBIT-1);
  sum1(7) <= sum1(6) + mult1(8)(2*NBIT-2 downto NBIT-1);

  ----------------------------------------------------------------------------------

  mult2(0) <= coeff(0) * x3k2;
  mult2(1) <= coeff(1) * x3k1;
  mult2(2) <= coeff(2) * x3k;
  mult2(3) <= coeff(3) * x3k2_1;
  mult2(4) <= coeff(4) * x3k1_1;
  mult2(5) <= coeff(5) * x3k_1;
  mult2(6) <= coeff(6) * shift_reg(0);
  mult2(7) <= coeff(7) * shift_reg(1);
  mult2(8) <= coeff(8) * shift_reg(2);


 sum2(0) <= mult2(0)(2*NBIT-2 downto NBIT-1) + mult2(1)(2*NBIT-2 downto NBIT-1);
 sum2(1) <= sum2(0) + mult2(2)(2*NBIT-2 downto NBIT-1);
 sum2(2) <= sum2(1) + mult2(3)(2*NBIT-2 downto NBIT-1);
 sum2(3) <= sum2(2) + mult2(4)(2*NBIT-2 downto NBIT-1);
 sum2(4) <= sum2(3) + mult2(5)(2*NBIT-2 downto NBIT-1);
 sum2(5) <= sum2(4) + mult2(6)(2*NBIT-2 downto NBIT-1);
 sum2(6) <= sum2(5) + mult2(7)(2*NBIT-2 downto NBIT-1);
 sum2(7) <= sum2(6) + mult2(8)(2*NBIT-2 downto NBIT-1);

 -------------------------------------------------------------------------------------

	output_register0 : REG 
		port map(REG_IN => sum0(7), REG_OUT => DOUT0, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);--output register,enabled when an output is ready
	output_register1 : REG 
		port map(REG_IN => sum1(7), REG_OUT => DOUT1, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);--output register,enabled when an output is ready
	output_register2 : REG 
		port map(REG_IN => sum2(7), REG_OUT => DOUT2, CLK => CLK, RST_N => RST_N, LOAD => CTRL_IN);--output register,enabled when an output is ready
    
    

end architecture;
