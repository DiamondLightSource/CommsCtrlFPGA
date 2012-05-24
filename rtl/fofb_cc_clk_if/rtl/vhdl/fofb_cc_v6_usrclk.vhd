library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity fofb_cc_v6_usrclk is
generic (
    constant MULT        : real    := 8.0;
    constant DIVIDE      : integer := 1;
    constant CLK_PERIOD  : real    := 9.41;
    constant OUT0_DIVIDE : real    := 8.0;
    constant OUT1_DIVIDE : integer := 8;
    constant OUT2_DIVIDE : integer := 8;
    constant OUT3_DIVIDE : integer := 8
);
port (

    GT_CLK                 : in std_logic;
    GT_CLK_LOCKED          : in std_logic;
    USER_CLK               : out std_logic;
    SYNC_CLK               : out std_logic;
    PLL_NOT_LOCKED         : out std_logic
);
end fofb_cc_v6_usrclk;

architecture MAPPED of fofb_cc_v6_usrclk is

signal PLL_NOT_LOCKED_Buffer    : std_logic;
signal clkfb_w                  : std_logic;
signal clkout0_o                : std_logic;
signal clkout1_o                : std_logic;
signal clkout2_o                : std_logic;
signal clkout3_o                : std_logic;
signal locked_w                 : std_logic;
signal reset_n                  : std_logic;

signal tied_to_ground_vec_i   : std_logic_vector(15 downto 0);
signal tied_to_ground_i       : std_logic;
signal tied_to_vcc_i          : std_logic;

begin

    --  Static signal Assigments    
    tied_to_ground_i         <= '0';
    tied_to_ground_vec_i     <= (others=>'0');
    tied_to_vcc_i            <= '1';

    PLL_NOT_LOCKED <= PLL_NOT_LOCKED_Buffer;
    reset_n        <= not GT_CLK_LOCKED; 


-- ************************Main Body of Code *************************--

    -- Instantiate a MMCM module to divide the reference clock.

    mmcm_adv_i  : MMCM_ADV
    generic map
    (
         CLKFBOUT_MULT_F  =>  MULT,
         DIVCLK_DIVIDE    =>  DIVIDE,
         CLKFBOUT_PHASE   =>  0.0,
         CLKIN1_PERIOD    =>  CLK_PERIOD,
         CLKIN2_PERIOD    =>  10.0,          -- Not used
         CLKOUT0_DIVIDE_F =>  OUT0_DIVIDE,
         CLKOUT0_PHASE    =>  0.0,
         CLKOUT1_DIVIDE   =>  OUT1_DIVIDE,
         CLKOUT1_PHASE    =>  0.0,
         CLKOUT2_DIVIDE   =>  OUT2_DIVIDE,
         CLKOUT2_PHASE    =>  0.0,
         CLKOUT3_DIVIDE   =>  OUT3_DIVIDE,
         CLKOUT3_PHASE    =>  0.0         
    )
    port map
    (
         CLKIN1          =>  GT_CLK,
         CLKIN2          =>  tied_to_ground_i,
         CLKINSEL        =>  tied_to_vcc_i,
         CLKFBIN         =>  clkfb_w,
         CLKOUT0         =>  clkout0_o,
         CLKOUT0B        =>  open,
         CLKOUT1         =>  clkout1_o,
         CLKOUT1B        =>  open,
         CLKOUT2         =>  clkout2_o,
         CLKOUT2B        =>  open,
         CLKOUT3         =>  clkout3_o,
         CLKOUT3B        =>  open,
         CLKOUT4         =>  open,
         CLKOUT5         =>  open,
         CLKOUT6         =>  open,
         CLKFBOUT        =>  clkfb_w,
         CLKFBOUTB       =>  open,
         CLKFBSTOPPED    =>  open,
         CLKINSTOPPED    =>  open,
         DO              =>  open,
         DRDY            =>  open,
         DADDR           =>  tied_to_ground_vec_i(6 downto 0),
         DCLK            =>  tied_to_ground_i,
         DEN             =>  tied_to_ground_i,
         DI              =>  tied_to_ground_vec_i(15 downto 0),
         DWE             =>  tied_to_ground_i,
         LOCKED          =>  locked_w,
         PSCLK           =>  tied_to_ground_i,
         PSEN            =>  tied_to_ground_i,        
         PSINCDEC        =>  tied_to_ground_i, 
         PSDONE          =>  open,         
         PWRDWN          =>  tied_to_ground_i,
         RST             =>  reset_n     
    );

    sync_clk_net_i : BUFG

        port map (

                    I => clkout1_o,
                    O => SYNC_CLK

                 );
    -- The User Clock is distributed on a global clock net.
    user_clk_net_i : BUFG

        port map (

                    I => clkout0_o,
                    O => USER_CLK

                 );

    -- The PLL_NOT_LOCKED signal is created by inverting the DCM's locked signal.

    PLL_NOT_LOCKED_Buffer <= not locked_w;

end MAPPED;
