----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : fofb_cc_clk_if.vhd
--  Purpose      : Clock and reset interface logic
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: This module receives differential input clock for
--  CC design, and generates user clk, and reset outputs for Spartan6
--  FPGA famile.
--  For more details on RocketIO clocking, please have a look at:
--      UG366 Virtex-6 FPGA GTX Transceivers User Guide
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.fofb_cc_pkg.all;

library unisim;
use unisim.vcomponents.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_clk_if is
    port (
        -- Differential GT clock inputs
        refclk_n_i              : in  std_logic;
        refclk_p_i              : in  std_logic;
        -- system interface
        gtreset_i               : in  std_logic;
        txoutclk_i              : in  std_logic;
        plllkdet_i              : in  std_logic;
        -- clocks and resets
        initclk_o               : out std_logic;
        refclk_o                : out std_logic;
        mgtreset_o              : out std_logic;
        gtreset_o               : out std_logic;
        -- user clocks
        userclk_o               : out std_logic;
        userclk_2x_o            : out std_logic
    );
end fofb_cc_clk_if;

architecture rtl of fofb_cc_clk_if is

component MMCM_ADV
generic (
    BANDWIDTH : string := "OPTIMIZED";
    CLKFBOUT_MULT_F : real := 1.0;
    CLKFBOUT_PHASE : real := 0.0;
    CLKFBOUT_USE_FINE_PS : boolean := FALSE;
    CLKIN1_PERIOD : real := 0.0;
    CLKIN2_PERIOD : real := 0.0;
    CLKOUT0_DIVIDE_F : real := 1.0;
    CLKOUT0_DUTY_CYCLE : real := 0.5;
    CLKOUT0_PHASE : real := 0.0;
    CLKOUT0_USE_FINE_PS : boolean := FALSE;
    CLKOUT1_DIVIDE : integer := 1;
    CLKOUT1_DUTY_CYCLE : real := 0.5;
    CLKOUT1_PHASE : real := 0.0;
    CLKOUT1_USE_FINE_PS : boolean := FALSE;
    CLKOUT2_DIVIDE : integer := 1;
    CLKOUT2_DUTY_CYCLE : real := 0.5;
    CLKOUT2_PHASE : real := 0.0;
    CLKOUT2_USE_FINE_PS : boolean := FALSE;
    CLKOUT3_DIVIDE : integer := 1;
    CLKOUT3_DUTY_CYCLE : real := 0.5;
    CLKOUT3_PHASE : real := 0.0;
    CLKOUT3_USE_FINE_PS : boolean := FALSE;
    CLKOUT4_CASCADE : boolean := FALSE;
    CLKOUT4_DIVIDE : integer := 1;
    CLKOUT4_DUTY_CYCLE : real := 0.5;
    CLKOUT4_PHASE : real := 0.0;
    CLKOUT4_USE_FINE_PS : boolean := FALSE;
    CLKOUT5_DIVIDE : integer := 1;
    CLKOUT5_DUTY_CYCLE : real := 0.5;
    CLKOUT5_PHASE : real := 0.0;
    CLKOUT5_USE_FINE_PS : boolean := FALSE;
    CLKOUT6_DIVIDE : integer := 1;
    CLKOUT6_DUTY_CYCLE : real := 0.5;
    CLKOUT6_PHASE : real := 0.0;
    CLKOUT6_USE_FINE_PS : boolean := FALSE;
    CLOCK_HOLD : boolean := TRUE;
    COMPENSATION : string := "ZHOLD";
    DIVCLK_DIVIDE : integer := 1;
    REF_JITTER1 : real := 0.0;
    REF_JITTER2 : real := 0.0;
    STARTUP_WAIT : boolean := FALSE
);
port (
    CLKFBOUT             : out std_ulogic := '0';
    CLKFBOUTB            : out std_ulogic := '0';
    CLKFBSTOPPED         : out std_ulogic := '0';
    CLKINSTOPPED         : out std_ulogic := '0';
    CLKOUT0              : out std_ulogic := '0';
    CLKOUT0B             : out std_ulogic := '0';
    CLKOUT1              : out std_ulogic := '0';
    CLKOUT1B             : out std_ulogic := '0';
    CLKOUT2              : out std_ulogic := '0';
    CLKOUT2B             : out std_ulogic := '0';
    CLKOUT3              : out std_ulogic := '0';
    CLKOUT3B             : out std_ulogic := '0';
    CLKOUT4              : out std_ulogic := '0';
    CLKOUT5              : out std_ulogic := '0';
    CLKOUT6              : out std_ulogic := '0';
    DO                   : out std_logic_vector (15 downto 0);
    DRDY                 : out std_ulogic := '0';
    LOCKED               : out std_ulogic := '0';
    PSDONE               : out std_ulogic := '0';
    CLKFBIN              : in std_ulogic;
    CLKIN1               : in std_ulogic;
    CLKIN2               : in std_ulogic;
    CLKINSEL             : in std_ulogic;
    DADDR                : in std_logic_vector(6 downto 0);
    DCLK                 : in std_ulogic;
    DEN                  : in std_ulogic;
    DI                   : in std_logic_vector(15 downto 0);
    DWE                  : in std_ulogic;
    PSCLK                : in std_ulogic;
    PSEN                 : in std_ulogic;
    PSINCDEC             : in std_ulogic;
    PWRDWN               : in std_ulogic;
    RST                  : in std_ulogic
);
end component;

signal refclk               : std_logic;
signal userclk              : std_logic;
signal dcm_locked           : std_logic;
signal dcm_reset            : std_logic;
signal init_clk             : std_logic;
signal txoutclk_to_dcm      : std_logic;
signal clkfb_w              : std_logic;
signal clkout0              : std_logic;

begin

-- Direct reference clock to GTP
refclk_o     <= refclk;

-----------------------------------------
-- Virtex6 Clock Interface
-----------------------------------------
refclk_ibufds : IBUFDS_GTXE1
port map (
    O                   => refclk,
    ODIV2               => open,
    CEB                 => '0',
    I                   => refclk_p_i,
    IB                  => refclk_n_i
);

-- Initial clock from GTP reference clocks via BUFG
refclk_bufg : BUFG
port map (
    I                   => refclk,
    O                   => init_clk
);

-- Initial reset to GTP (gtreset_i) is tied to fofb_cc_enable
-- to let the clock settle
process(gtreset_i, init_clk)
    variable cnt    : unsigned(4 downto 0) := "00000";
begin
    if (gtreset_i = '1') then
        gtreset_o <= '1';
    elsif rising_edge(init_clk) then
        if (cnt(4) = '1') then
            gtreset_o <= '0';
        else
            cnt := cnt + 1;
            gtreset_o <= '1';
        end if;
    end if;
end process;

-- Output MGT clock as init_clk via BUFG
userclk_bufg : BUFG
port map (
    I                   => txoutclk_i,
    O                   => txoutclk_to_dcm
);

--
dcm_reset <= not plllkdet_i;

mmcm_adv_i  : MMCM_ADV
generic map (
     CLKFBOUT_MULT_F  =>  8.0,
     DIVCLK_DIVIDE    =>  1,
     CLKFBOUT_PHASE   =>  0.0,
     CLKIN1_PERIOD    =>  9.41,
     CLKIN2_PERIOD    =>  10.0,          -- Not used
     CLKOUT0_DIVIDE_F =>  8.0,
     CLKOUT0_PHASE    =>  0.0,
     CLKOUT1_DIVIDE   =>  8,
     CLKOUT1_PHASE    =>  0.0,
     CLKOUT2_DIVIDE   =>  8,
     CLKOUT2_PHASE    =>  0.0,
     CLKOUT3_DIVIDE   =>  8,
     CLKOUT3_PHASE    =>  0.0
)
port map (
     CLKIN1          =>  txoutclk_to_dcm,
     CLKIN2          =>  '0',
     CLKINSEL        =>  '1',
     CLKFBIN         =>  clkfb_w,
     CLKOUT0         =>  clkout0,
     CLKOUT0B        =>  open,
     CLKOUT1         =>  open,
     CLKOUT1B        =>  open,
     CLKOUT2         =>  open,
     CLKOUT2B        =>  open,
     CLKOUT3         =>  open,
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
     DADDR           =>  (others => '0'),
     DCLK            =>  '0',
     DEN             =>  '0',
     DI              =>  (others => '0'),
     DWE             =>  '0',
     LOCKED          =>  dcm_locked,
     PSCLK           =>  '0',
     PSEN            =>  '0',
     PSINCDEC        =>  '0',
     PSDONE          =>  open,
     PWRDWN          =>  '0',
     RST             =>  dcm_reset
);

-- The User Clock is distributed on a global clock net.
user_clk_net_i : BUFG
port map (
    I       => clkout0,
    O       => userclk
);

-- Output assignments
mgtreset_o   <= not dcm_locked;
userclk_o    <= userclk; -- 106.25MHz
userclk_2x_o <= userclk; -- not used since TXUSRCLK2 = TXUSRCLK for 2-byte mode
initclk_o    <= init_clk;

end rtl;
