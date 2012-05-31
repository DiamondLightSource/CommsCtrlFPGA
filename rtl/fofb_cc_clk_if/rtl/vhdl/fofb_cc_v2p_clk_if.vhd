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
--  CC design, and generates user clk, and reset outputs for Virtex2Pro,Virtex5 
--  and Virtex6 devices.
--  For more details on RocketIO clocking, please have a look at:
--      UG024 Virtex-2Pro RocketIO Transceiver User Guide
--      UG196 Virtex-5 FPGA RocketIO GTP Transceiver User Guide
--      UG366 Virtex-6 FPGA GTX Transceivers User Guide
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.fofb_cc_pkg.all;-- DLS FOFB package

library unisim;
use unisim.vcomponents.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_clk_if is
    generic (
        -- FPGA Device
        DEVICE                  : device_t := BPM;
        USE_DCM                 : boolean := true
    );
    port (
        refclk_n_i              : in  std_logic;
        refclk_p_i              : in  std_logic;
        -- clocks and resets
        extreset_i              : in  std_logic;
        initclk_o               : out std_logic;
        refclk_o                : out std_logic;
        mgtreset_o              : out std_logic;
        gtreset_o               : out std_logic;
        -- system interface
        txoutclk_i              : in  std_logic;
        plllkdet_i              : in  std_logic;
        -- user clocks
        userclk_o               : out std_logic;
        userclk_2x_o            : out std_logic
    );
end fofb_cc_clk_if;

architecture rtl of fofb_cc_clk_if is

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal init_clk         : std_logic;
signal refclk           : std_logic;
signal refclk_i         : std_logic;
signal userclk          : std_logic;
signal dcm_reset        : std_logic;
signal dcm_clkdiv1      : std_logic;
signal dcm_clkdiv2      : std_logic;
signal mgtreset_n       : std_logic;
signal init_reset       : std_logic;
signal dcm_locked       : std_logic;
signal tied_to_ground   : std_logic;
signal tied_to_vcc      : std_logic;
signal pll_not_locked   : std_logic;
signal reset_debounce_r   : std_logic_vector(0 to 3);
signal reset_debounce_r2  : std_logic;
signal reset_debounce_r3  : std_logic;
signal reset_debounce_r4  : std_logic;
signal txoutclk_to_dcm    : std_logic;

begin

--  Static signal Assigments
tied_to_ground <= '0';
tied_to_vcc <= '1';

----------------------------------------------------
-- Virtex2Pro Clock Interface with or without a DCM
----------------------------------------------------

-- Output assignments
refclk_o     <= refclk;
userclk_o    <= userclk;        -- 106.25MHz
userclk_2x_o <= userclk;        -- 106.25MHz
gtreset_o    <= tied_to_ground;
mgtreset_o   <= not mgtreset_n;

-- Differential clock input for MGT/GTP
refclk_ibufds : IBUFGDS
    port map (
        O   => refclk,
        I   => refclk_p_i,
        IB  => refclk_n_i
    );

user_clock_bufg : BUFG
    port map (
        I => refclk,
        O => userclk
    );

-- MGT/GTP clock domain reset is based on DCM lock output
SRL16_mgtreset : SRL16
    port map    (
        Q   => mgtreset_n,
        A0  => '1',
        A1  => '1',
        A2  => '1',
        A3  => '1',
        CLK => userclk,
        D   => '1'
    );

end rtl;
