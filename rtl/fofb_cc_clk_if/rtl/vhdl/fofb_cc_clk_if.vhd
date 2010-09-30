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

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

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
        refclk_n_i              : in std_logic;
        refclk_p_i              : in std_logic;
        -- clocks and resets
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
-- Component declaration
-----------------------------------------------
component IBUFDS_GTXE1
port (
    O       : out std_logic;
    ODIV2   : out std_logic;
    CEB     : in  std_logic;
    I       : in  std_logic;
    IB      : in  std_logic
);
end component;

component IBUFGDS
port (
    O       : out std_logic;
    I       : in std_logic;
    IB      : in std_logic
);
end component; 

component BUFG
port (
    O       : out std_logic;
    I       : in std_logic
);
end component;

component SRL16
port (
    Q       : out std_logic;
    A0      : in std_logic;
    A1      : in std_logic;
    A2      : in std_logic;
    A3      : in std_logic;
    CLK     : in std_logic;
    D       : in std_logic
);
end component; 

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal refclk           : std_logic;
signal refclk_i         : std_logic;
signal userclk          : std_logic;
signal dcm_reset        : std_logic;
signal txoutclk_to_dcm  : std_logic;
signal dcm_clkdiv1      : std_logic;
signal dcm_clkdiv2      : std_logic;
signal mgtreset_n       : std_logic;
signal init_reset       : std_logic;
signal dcm_locked       : std_logic;
signal tied_to_ground   : std_logic;
signal tied_to_vcc      : std_logic;

begin

--  Static signal Assigments
tied_to_ground <= '0';
tied_to_vcc <= '1';

-----------------------------------------
-- Virtex6 Clock Interface
-----------------------------------------
v6_clk_if : if (DEVICE = SNIFFER_V6) generate

refclk_ibufds : IBUFDS_GTXE1
    port map (
        O       => refclk_i,
        ODIV2   => open,
        CEB     => tied_to_ground,
        I       => refclk_p_i,
        IB      => refclk_n_i
    );

refclk_bufg : BUFG
    port map (
        I=>      refclk_i,
        O=>      refclk
    );

-- initial reset to to GTX
SRL16_dcmreset : SRL16
    port map    (
        Q   => init_reset,
        A0  => '1',
        A1  => '1',
        A2  => '1',
        A3  => '1',
        CLK => refclk,
        D   => '1'
    );

-- MGT/GTP clock domain reset is based on DCM lock output
SRL16_mgtreset : SRL16
    port map    (
        Q   => mgtreset_n,
        A0  => '1',
        A1  => '1',
        A2  => '1',
        A3  => '1',
        CLK => txoutclk_to_dcm,
        D   => plllkdet_i
    );

-- User clock comes from GTXE1 txoutclk for 2-Byte mode
-- there is no need to use a DCM
txoutclk_dcm0_bufg : BUFG
    port map (
        I   => txoutclk_i,
        O   => txoutclk_to_dcm
    );

-- Output assignments
refclk_o     <= refclk_i;
gtreset_o    <= not init_reset;
mgtreset_o   <= not mgtreset_n;
userclk_o    <= txoutclk_to_dcm;   -- 106.25MHz
userclk_2x_o <= tied_to_ground;    -- not used since TXUSRCLK2 = TXUSRCLK for 2-byte mode

end generate v6_clk_if;

-----------------------------------------
-- Virtex5 Clock Interface
-----------------------------------------
v5_clk_if : if (DEVICE = SNIFFER_V5) generate

-- Output assignments
refclk_o     <= refclk;
userclk_o    <= dcm_clkdiv2;    -- 106.25MHz
userclk_2x_o <= dcm_clkdiv1;    -- 212.5 MHz
gtreset_o    <= not init_reset;
mgtreset_o   <= not mgtreset_n;

-- Differential clock input for MGT/GTP
refclk_ibufds : IBUFGDS
    port map (
        O   => refclk_i,
        I   => refclk_p_i,
        IB  => refclk_n_i
    );

-- This buffer is required for CC GTPs becuase they are not clocked by dedicated clocks
refclk_bufg : BUFG
    port map (
        I   => refclk_i,
        O   => refclk
    );

-- initial reset is used to reset DCM in MGT design
SRL16_dcmreset : SRL16
    port map    (
        Q   => init_reset,
        A0  => '1',
        A1  => '1',
        A2  => '1',
        A3  => '1',
        CLK => refclk,
        D   => '1'
    );

-- MGT/GTP clock domain reset is based on DCM lock output
SRL16_mgtreset : SRL16
    port map    (
        Q   => mgtreset_n,
        A0  => '1',
        A1  => '1',
        A2  => '1',
        A3  => '1',
        CLK => dcm_clkdiv2,
        D   => dcm_locked
    );

-- Clock input to DCM comes from GTP_DUAL txoutclk
-- which is 2 x refclk (212.5MHz)
txoutclk_dcm0_bufg : BUFG
    port map (
        I   => txoutclk_i,
        O   => txoutclk_to_dcm
    );

-- DCM reset
dcm_reset <= not plllkdet_i;

-- user clock dcm
txoutclk_dcm0 : entity work.mgt_usrclk_source
    port map (
        clkdiv1_o           => dcm_clkdiv1,
        clkdiv2_o           => dcm_clkdiv2,
        dcm_locked_o        => dcm_locked,
        dcm_clk_i           => txoutclk_to_dcm,
        dcmreset_i          => dcm_reset
    );

end generate v5_clk_if;

----------------------------------------------------
-- Virtex2Pro Clock Interface with or without a DCM
----------------------------------------------------
v2p_clk_if : if (DEVICE /= SNIFFER_V5 and DEVICE /= SNIFFER_V6) generate

bpm_clk_if : if (USE_DCM) generate

-- Output assignments
refclk_o     <= refclk;
userclk_o    <= dcm_clkdiv1;    -- 106.25MHz
userclk_2x_o <= tied_to_ground;
gtreset_o    <= tied_to_ground;
mgtreset_o   <= not mgtreset_n;

-- Differential clock input for MGT/GTP
refclk_ibufds : IBUFGDS
    port map (
        O   => refclk,
        I   => refclk_p_i,
        IB  => refclk_n_i
    );

-- initial reset is used to reset DCM in MGT design
SRL16_dcmreset : SRL16
    port map    (
        Q   => init_reset,
        A0  => '1',
        A1  => '1',
        A2  => '1',
        A3  => '1',
        CLK => refclk,
        D   => '1'
    );

-- MGT/GTP clock domain reset is based on DCM lock output
SRL16_mgtreset : SRL16
    port map    (
        Q   => mgtreset_n,
        A0  => '1',
        A1  => '1',
        A2  => '1',
        A3  => '1',
        CLK => dcm_clkdiv1, -- userclk
        D   => dcm_locked
    );

-- DCM reset
dcm_reset <= not init_reset;

-- user clock dcm
userclk_dcm0 : entity work.mgt_usrclk_source
    port map (
        clkdiv1_o           => dcm_clkdiv1,
        clkdiv2_o           => dcm_clkdiv2,
        dcm_locked_o        => dcm_locked,
        dcm_clk_i           => refclk,
        dcmreset_i          => dcm_reset
    );

end generate bpm_clk_if;

pmc_clk_if : if (not USE_DCM) generate

-- Output assignments
refclk_o     <= refclk;
userclk_o    <= userclk;        -- 106.25MHz
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

end generate pmc_clk_if;

end generate v2p_clk_if;

end rtl;
