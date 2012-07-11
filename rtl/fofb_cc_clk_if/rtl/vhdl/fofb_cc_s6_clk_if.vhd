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

signal refclk           : std_logic;
signal userclk          : std_logic;
signal userclk_bufio    : std_logic;
signal init_clk         : std_logic;
signal init_reset       : std_logic;
signal clkfb_w          : std_logic;
signal clkout0          : std_logic;
signal clkout1          : std_logic;
signal clkout2          : std_logic;
signal clkout3          : std_logic;
signal pll_locked       : std_logic;
signal txoutclk         : std_logic;

begin

-----------------------------------------
-- Spartan6 Clock Interface
-----------------------------------------
refclk_ibufds : IBUFDS
port map (
    I                   => refclk_p_i,
    IB                  => refclk_n_i,
    O                   => refclk
);

-- Direct reference clock to GTP
refclk_o     <= refclk;

-- Output GT clock as init_clk via BUFG
userclk_bufio2: BUFIO2
generic map (
    DIVIDE          => 1,
    DIVIDE_BYPASS   => TRUE
)
port map (
    I               => txoutclk_i,
    DIVCLK          => txoutclk,
    IOCLK           => open,
    SERDESSTROBE    => open
);

-- Instantiate a PLL module to divide the reference clock.

pll_adv_i  : PLL_ADV
generic map (
     CLKFBOUT_MULT    =>  8,
     DIVCLK_DIVIDE    =>  1,
     CLKFBOUT_PHASE   =>  0.0,
     CLKIN1_PERIOD    =>  9.412,
     CLKIN2_PERIOD    =>  10.0,          -- Not used
     CLKOUT0_DIVIDE   =>  8,
     CLKOUT0_PHASE    =>  0.0,
     CLKOUT1_DIVIDE   =>  4,
     CLKOUT1_PHASE    =>  0.0,
     CLKOUT2_DIVIDE   =>  8,
     CLKOUT2_PHASE    =>  0.0,
     CLKOUT3_DIVIDE   =>  4,
     CLKOUT3_PHASE    =>  0.0
)
port map (
     CLKIN1            => txoutclk,
     CLKIN2            => '0',
     CLKINSEL          => '1',
     CLKFBIN           => clkfb_w,
     CLKOUT0           => clkout0,
     CLKOUT1           => clkout1,
     CLKOUT2           => clkout2,
     CLKOUT3           => clkout3,
     CLKOUT4           => open,
     CLKOUT5           => open,
     CLKFBOUT          => clkfb_w,
     CLKFBDCM          => open,
     CLKOUTDCM0        => open,
     CLKOUTDCM1        => open,
     CLKOUTDCM2        => open,
     CLKOUTDCM3        => open,
     CLKOUTDCM4        => open,
     CLKOUTDCM5        => open,
     DO                => open,
     DRDY              => open,
     DADDR             => "00000",
     DCLK              => '0',
     DEN               => '0',
     DI                => X"0000",
     DWE               => '0',
     REL               => '0',
     LOCKED            => pll_locked,
     RST               => not plllkdet_i
  );

sync_clk_net_i : BUFG
port map (
    I => clkout1,
    O => userclk_2x_o
);

user_clk_net_i : BUFG
port map (
    I => clkout0,
    O => userclk
);

--
-- SPARTAN-6 architecture does not allow to do this
--
---- Initial clock from GTP reference clocks via BUFG
--refclk_bufg : BUFG
--port map (
--    I=>      refclk,
--    O=>      init_clk
--);
--
---- Initial reset to GTP using init_clk
--SRL16_dcmreset : SRL16
--port map    (
--    Q   => init_reset,
--    A0  => '1',
--    A1  => '1',
--    A2  => '1',
--    A3  => '1',
--    CLK => init_clk,
--    D   => '1'
--);

init_reset <= '1';

-- Output assignments
gtreset_o    <= not init_reset;
mgtreset_o   <= not pll_locked;
userclk_o    <= userclk; -- 106.25MHz
initclk_o <= '0';        -- Not required for Spartan-6 GTP

end rtl;
