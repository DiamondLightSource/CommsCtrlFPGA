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
        -- System level clock and reset inputs
        txoutclk_i              : in  std_logic;
        plllkdet_i              : in  std_logic;
        -- System level clock and reset outputs
        refclk_o                : out std_logic;
        initclk_o               : out std_logic;
        userclk_o               : out std_logic;
        userclk_2x_o            : out std_logic;
        mgtreset_o              : out std_logic;
        gtreset_o               : out std_logic
    );
end fofb_cc_clk_if;

architecture rtl of fofb_cc_clk_if is

signal refclk           : std_logic;
signal userclk          : std_logic;
signal init_clk         : std_logic;
signal init_reset       : std_logic;

begin

-----------------------------------------
-- Spartan6 Clock Interface
-----------------------------------------
refclk_ibufds : IBUFDS_GTXE1
port map (
    O                   => refclk,
    ODIV2               => open,
    CEB                 => '0',
    I                   => refclk_p_i,
    IB                  => refclk_n_i
);

-- Direct reference clock to GTP
refclk_o     <= refclk;

-- Output MGT clock as init_clk via BUFG
userclk_bufg : BUFG
port map (
    I=>      txoutclk_i,
    O=>      userclk
);

-- Initial clock from GTP reference clocks via BUFG
refclk_bufg : BUFG
port map (
    I=>      refclk,
    O=>      init_clk
);

-- Initial reset to GTP using init_clk
SRL16_dcmreset : SRL16
port map    (
    Q   => init_reset,
    A0  => '1',
    A1  => '1',
    A2  => '1',
    A3  => '1',
    CLK => init_clk,
    D   => '1'
);

-- Output assignments
gtreset_o    <= not init_reset;
mgtreset_o   <= not plllkdet_i;
userclk_o    <= userclk; -- 106.25MHz
userclk_2x_o <= userclk; -- not used since TXUSRCLK2 = TXUSRCLK for 2-byte mode
initclk_o <= '0';        -- Not required for Spartan-6 GTP

end rtl;
