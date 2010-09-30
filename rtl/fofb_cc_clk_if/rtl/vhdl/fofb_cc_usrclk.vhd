----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : fofb_cc_clk_if.vhd
--  Purpose      : Virtex5 GTP clock DCM
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: This module instantiates the DCM required for Virtex2Pro and
--  Virtex-5 GTP clocking.
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

entity mgt_usrclk_source is
    port (
        clkdiv1_o               : out std_logic;
        clkdiv2_o               : out std_logic;
        dcm_locked_o            : out std_logic;
        dcm_clk_i               : in  std_logic;
        dcmreset_i              : in  std_logic
    );

end mgt_usrclk_source;

architecture RTL of mgt_usrclk_source is

-----------------------------------------------
--  Component declaration
-----------------------------------------------
component BUFG
port (
    O : out std_logic;
    I : in std_logic
);
end component;

component DCM
generic (
    CLKDV_DIVIDE        : real:= 2.0;
    DFS_FREQUENCY_MODE  : string := "LOW";
    DLL_FREQUENCY_MODE  : string := "LOW"
);
port (
    CLK0                : out std_logic;
    CLK180              : out std_logic;
    CLK270              : out std_logic;
    CLK2X               : out std_logic;
    CLK2X180            : out std_logic;
    CLK90               : out std_logic;
    CLKDV               : out std_logic;
    CLKFX               : out std_logic;
    CLKFX180            : out std_logic;
    LOCKED              : out std_logic;
    PSDONE              : out std_logic;
    STATUS              : out STD_LOGIC_VECTOR (7 downto 0);
    CLKFB               : in std_logic;
    CLKIN               : in std_logic;
    DSSEN               : in std_logic;
    PSCLK               : in std_logic;
    PSEN                : in std_logic;
    PSINCDEC            : in std_logic;
    RST                 : in std_logic
);
end component;

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal clkfb                    : std_logic;
signal clkdv                    : std_logic;
signal clk0                     : std_logic;

begin

--
-- Instantiate a DCM module to divide the reference clock.
--
i_clock_divider : DCM
    generic map (
        CLKDV_DIVIDE            => 2.0,
        DFS_FREQUENCY_MODE      => "LOW",
        DLL_FREQUENCY_MODE      => "HIGH"
    )
    port map (
        CLK0                    => clk0,
        CLK180                  => open,
        CLK270                  => open,
        CLK2X                   => open,
        CLK2X180                => open,
        CLK90                   => open,
        CLKDV                   => clkdv,
        CLKFX                   => open,
        CLKFX180                => open,
        LOCKED                  => dcm_locked_o,
        PSDONE                  => open,
        STATUS                  => open,
        CLKFB                   => clkfb,
        CLKIN                   => dcm_clk_i,
        DSSEN                   => '0',
        PSCLK                   => '0',
        PSEN                    => '0',
        PSINCDEC                => '0',
        RST                     => dcmreset_i
    );

dcm_1x_bufg_i : BUFG 
    port map (
        I                       => clk0,
        O                       => clkfb
    );

clkdiv1_o  <=  clkfb;

dcm_div2_bufg_i : BUFG 
    port map (
        I                       => clkdv,
        O                       => clkdiv2_o
    );

end RTL;

