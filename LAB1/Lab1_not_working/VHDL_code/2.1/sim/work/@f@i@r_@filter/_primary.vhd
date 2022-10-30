library verilog;
use verilog.vl_types.all;
entity FIR_Filter is
    port(
        CLK             : in     vl_logic;
        RST_n           : in     vl_logic;
        VIN             : in     vl_logic;
        DIN             : in     vl_logic_vector(11 downto 0);
        B0              : in     vl_logic_vector(11 downto 0);
        B1              : in     vl_logic_vector(11 downto 0);
        B2              : in     vl_logic_vector(11 downto 0);
        B3              : in     vl_logic_vector(11 downto 0);
        B4              : in     vl_logic_vector(11 downto 0);
        B5              : in     vl_logic_vector(11 downto 0);
        B6              : in     vl_logic_vector(11 downto 0);
        B7              : in     vl_logic_vector(11 downto 0);
        B8              : in     vl_logic_vector(11 downto 0);
        VOUT            : out    vl_logic;
        DOUT            : out    vl_logic_vector(11 downto 0)
    );
end FIR_Filter;
