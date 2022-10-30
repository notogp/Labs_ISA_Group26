
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use ieee.std_logic_textio.all;
  use std.textio.all;
  use work.constants.all;

entity tb_fir_all is
end entity tb_fir_all;

architecture behavioural of tb_fir_all is

  component FIR_Filter is
    port (
      CLK              : in    std_logic;
      RST_N            : in    std_logic;
      DIN              : in    signed (11 downto 0);
      VIN              : in    std_logic;
      B0               : in    signed(11 downto 0);
      B1               : in    signed(11 downto 0);
      B2               : in    signed(11 downto 0);
      B3               : in    signed(11 downto 0);
      B4               : in    signed(11 downto 0);
      B5               : in    signed(11 downto 0);
      B6               : in    signed(11 downto 0);
      B7               : in    signed(11 downto 0);
      B8               : in    signed(11 downto 0);
      VOUT             : out   std_logic;
      DOUT             : out   signed (11 downto 0)

    );
  end component;

  signal initialized                 : std_logic := '0';
  signal vout,             vin       : std_logic;
  signal dout,             din       : signed (11 downto 0);
  signal clk,              rst_n     : std_logic;
  signal h0                          : signed (11 downto 0);
  signal h1                          : signed (11 downto 0);
  signal h2                          : signed (11 downto 0);
  signal h3                          : signed (11 downto 0);
  signal h4                          : signed (11 downto 0);
  signal h5                          : signed (11 downto 0);
  signal h6                          : signed (11 downto 0);
  signal h7                          : signed (11 downto 0);
  signal h8                          : signed (11 downto 0);
  signal cnt_ins,          cnt_outs  : unsigned (7 downto 0);
  signal start_pipe_debug, state_ver : std_logic;            -- DEBUG SIGNAL
  signal state0_debug                : signed (11 downto 0); -- DEBUG
  signal state1_debug                : signed (11 downto 0); -- DEBUG
  signal state2_debug                : signed (11 downto 0); -- DEBUG
  signal sEndSim   : std_logic;
  signal END_SIM_i : std_logic_vector(0 to NBIT-1);
  constant tco : time := 1 ns;
  constant ts : time := 10 ns;

begin

  CLK_PROCESS : process
  begin

    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;

  end process CLK_PROCESS;

  RST_PROCESS : process
  begin

    rst_n       <= '1';
    wait for 5 ns;
    rst_n       <= '0';
    wait for 10 ns;
    rst_n       <= '1';
    initialized <= '1';
    wait for 1 sec;

  end process RST_PROCESS;

  --  ^^ initialization takes 3 clock cycles ^^

  h0 <= to_signed(-13, 12);
  h1 <= to_signed(-28, 12);
  h2 <= to_signed(104, 12);
  h3 <= to_signed(544, 12);
  h4 <= to_signed(830, 12);
  h5 <= to_signed(544, 12);
  h6 <= to_signed(104, 12);
  h7 <= to_signed(-28, 12);
  h8 <= to_signed(-13, 12);

  state_ver <= '0'; -- set to 1 in order to monitor state register contents


---------------------------------------------------------------------------------------
	DATA_GEN_PROC : process (clk, rst_n)
    file fp_in       : text open READ_MODE is "/home/isa07_2021_2022/Desktop/Lab1_group07_NOTO/Lab1/Matlab_code/samples.txt";
    variable line_in : line;
    variable x       : integer;
  begin               -- process
    if rst_n = '0' then -- asynchronous reset (active low)
      din    <= (others => '0') after tco;
      vin    <= '0' after tco;
      sEndSim <= '0' after tco;
    elsif clk'event and clk = '1' then -- rising clock edge
      if not endfile(fp_in) then
        readline(fp_in, line_in);
        read(line_in, x);
        din    <= to_signed(x, NBIT) after tco;
        vin    <= '1' after tco;
        sEndSim <= '0' after tco;
      else
        vin    <= '0' after tco; --2*ts + tco;
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process DATA_GEN_PROC;

  END_SIM_PROC : process (clk, rst_n)
  begin               -- process
    if rst_n = '0' then -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif clk'event and clk = '1' then -- rising clock edge
      END_SIM_i(0)       <= sEndSim after tco;
      END_SIM_i(1 to NBIT-1) <= END_SIM_i(0 to NBIT-2) after tco;
    end if;
  end process END_SIM_PROC;

--------------------------------------------------
  DATA_SINK_PROCESS : process (clk, rst_n)
    file res_fp : text open WRITE_MODE is "/home/isa07_2021_2022/Desktop/Lab1_group07_NOTO/Lab1/VHDL_code/2.1/resultsVHDL.txt";
    variable line_out : line;    
  begin  -- process
    if rst_n = '0' then                 -- asynchronous reset (active low)
      null;
    elsif clk'event and clk = '1' then  -- rising clock edge
      if (vout = '1') then
        write(line_out, to_integer(dout));
        writeline(res_fp, line_out);
      end if;
    end if;
  end process DATA_SINK_PROCESS;
-------------------------------------------------- 
  DUT : FIR_Filter
    port map (CLK => clk, RST_N => rst_n, DIN => din, VIN => vin, B0 => h0, B1 => h1, B2 => h2, B3 => h3, B4 => h4, B5 => h5, B6 => h6, B7 => h7, B8 => h8, VOUT => vout, DOUT => dout);

end architecture behavioural;
