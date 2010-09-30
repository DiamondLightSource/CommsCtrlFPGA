----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : pmc_top.vhd
--  Purpose      : PMC-SFP top level design
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: Top level design file for PMC-SFP module including
--  CC instantiation.
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug
--  reports to isa.uzun@diamond.ac.uk.
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.fofb_cc_pkg.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity pmc_top is
    generic (
        LANE_COUNT              : integer := 4
    );
    port (
        -- 106.25 MHz BREFCLKx is sourced by Micrel SY87739L
        brefclk_p_i             : in  std_logic;
        brefclk_n_i             : in  std_logic;
        -- Local Bus Signals @ lclk_i = 60 MHz
        lclk_i                  : in  std_logic;
        cs_n_i                  : in  std_logic_vector(1 downto 0);
        ready_n_o               : out std_logic;
        bterm_n_o               : out std_logic;
        lint_o                  : out std_logic_vector(2 downto 1);
        wr_n_i                  : in  std_logic;
        rd_n_i                  : in  std_logic;
        ads_n_i                 : in  std_logic;
        lad_io                  : inout std_logic_vector(31 downto 0);
        -- I/O connector pins
        pmc_connector_io        : inout std_logic_vector(31 downto 0);
        -- LEDS
        led_n_o                 : out std_logic_vector(3 downto 0);
        -- Micrel SY87739L programming signals
        cgsk_o                  : out std_logic;
        cgdi_o                  : out std_logic;
        cgcs_o                  : out std_logic;
        -- MGT Interface
        txdis_o                 : out std_logic_vector(LANE_COUNT-1 downto 0);
        rxn_i                   : in  std_logic_vector(LANE_COUNT-1 downto 0);
        rxp_i                   : in  std_logic_vector(LANE_COUNT-1 downto 0);
        txn_o                   : out std_logic_vector(LANE_COUNT-1 downto 0);
        txp_o                   : out std_logic_vector(LANE_COUNT-1 downto 0)
    );
end pmc_top;

architecture rtl of pmc_top is

-----------------------------------------------
--  Component declaration
-----------------------------------------------
component SRL16
-- synthesis translate_off
generic (
    INIT: bit_value:= X"0001"
);
-- synthesis translate_on
port (
    Q : out STD_ULOGIC;
    A0 : in STD_ULOGIC;
    A1 : in STD_ULOGIC;
    A2 : in STD_ULOGIC;
    A3 : in STD_ULOGIC;
    CLK : in STD_ULOGIC;
    D : in STD_ULOGIC
);
end component;

signal sysclk                   : std_logic;
signal sysreset_n               : std_logic;
signal sysreset                 : std_logic;
signal dcmreset                 : std_logic;
signal dcmreset_n               : std_logic;
signal sys_dcm_locked           : std_logic;
signal lclk_int                 : std_logic;
signal xy_pos_buf_dat           : std_logic_vector(63 downto 0);
signal xy_pos_buf_addr          : std_logic_vector(9 downto 0);
signal timeframe_end_rise_sys   : std_logic;
signal fai_cfg_a                : std_logic_vector(10 downto 0);
signal fai_cfg_di               : std_logic_vector(31 downto 0);
signal fai_cfg_do               : std_logic_vector(31 downto 0);
signal fai_cfg_we               : std_logic;
signal fai_cfg_val              : std_logic_vector(31 downto 0);
signal fai_cfg_clk              : std_logic;
signal fofb_watchdog            : std_logic_vector(31 downto 0);
signal fofb_event               : std_logic_vector(31 downto 0);
signal fofb_bpm_count           : std_logic_vector(7 downto 0);
signal fod_process_time         : std_logic_vector(15 downto 0);
signal fofb_dma_ok              : std_logic;
signal fofb_node_mask           : std_logic_vector(NodeNum-1 downto 0);
signal fofb_timestamp_val       : std_logic_vector(31 downto 0);

begin

ready_n_o <= '1';
bterm_n_o <= '1';
txdis_o <= "0000";
sysreset <=  not sysreset_n;

---------------------------------------------------------
-- Reset logic for PMC-CC
-- main reset - while asserted (0), hold DCM in reset
-- when it de-asserts, wait for DCM locks and release
-- internal resets
---------------------------------------------------------
i_SRL16_dcmreset : SRL16
    port map (
        Q       => dcmreset_n,
        A0      => '1',
        A1      => '1',
        A2      => '1',
        A3      => '1',
        CLK     => lclk_int,
        D       => '1'
    );

i_SRL16_sysreset : SRL16
    port map (
        Q       => sysreset_n,
        A0      => '1',
        A1      => '1',
        A2      => '1',
        A3      => '1',
        CLK     => sysclk,
        D       => sys_dcm_locked
    );

-----------------------------------
-- System clock Interface (60 MHz)
-----------------------------------
dcmreset <= not dcmreset_n;

i_dcm_lclk : entity work.dcm_lclk
    port map (
        clk_i                   => lclk_i,
        reset_i                 => dcmreset,
        clkin_ibufg_o           => lclk_int,
        clk0_o                  => sysclk,
        dcm_locked_o            => sys_dcm_locked
    );

--
-- Clock Synthesizer to generate 106.25MHz for CC from
-- on-board 24MHz oscillator
--
i_uwire : entity work.uwire
    port map (
        clk_i                   => sysclk,
        dat_i                   => (others=>'0'),
        wr_i                    => '0',
        data_rdback_o           => open,
        reload_i                => '0',
        reset_i                 => sysreset,
        cgsk_o                  => cgsk_o,
        cgdi_o                  => cgdi_o,
        cgcs_o                  => cgcs_o
    );

--------------------------------------------------
-- Communication Controller Instantiation
-------------------------------------------------- 
i_fofb_cc_top_wrapper : entity work.fofb_cc_top_wrapper
    generic map (
        USE_DCM                 => false,
        LANE_COUNT              => LANE_COUNT
    )
    port map(
        refclk_p_i              => brefclk_p_i,
        refclk_n_i              => brefclk_n_i,
        sysclk_i                => sysclk,

        fai_cfg_a_o             => fai_cfg_a,
        fai_cfg_d_o             => fai_cfg_di,
        fai_cfg_d_i             => fai_cfg_do,
        fai_cfg_we_o            => fai_cfg_we,
        fai_cfg_clk_o           => fai_cfg_clk,
        fai_cfg_val_i           => fai_cfg_val,

        xy_buf_addr_i           => xy_pos_buf_addr,
        xy_buf_dat_o            => xy_pos_buf_dat,
        timeframe_end_rise_o    => timeframe_end_rise_sys,

        fai_rio_rdp_i           => rxp_i,
        fai_rio_rdn_i           => rxn_i,
        fai_rio_tdp_o           => txp_o,
        fai_rio_tdn_o           => txn_o,

        fofb_watchdog_i         => fofb_watchdog,
        fofb_event_i            => fofb_event,
        fofb_process_time_o     => fod_process_time,
        fofb_bpm_count_o        => fofb_bpm_count,
        fofb_dma_ok_i           => fofb_dma_ok,
        fofb_node_mask_o        => fofb_node_mask,
        fofb_timestamp_val_o    => fofb_timestamp_val
    );

--------------------------------------------------
-- PMC module bus control interface
-------------------------------------------------- 
i_pmc_bus_cntrl : entity work.pmc_bus_cntrl
    port map(
        sysreset_i              => sysreset,
        sysclk_i                => sysclk,
        cs_n_i                  => cs_n_i,
        lint_o                  => lint_o,
        wr_n_i                  => wr_n_i,
        rd_n_i                  => rd_n_i,
        ads_n_i                 => ads_n_i,
        lad_io                  => lad_io,
        pmc_connector_io        => pmc_connector_io,
        xy_pos_buf_addr_o       => xy_pos_buf_addr,
        xy_pos_buf_dat_i        => xy_pos_buf_dat(31 downto 0),
        timeframe_end_rise_i    => timeframe_end_rise_sys,
        fai_cfg_a_i             => fai_cfg_a,
        fai_cfg_do_o            => fai_cfg_do,
        fai_cfg_di_i            => fai_cfg_di,
        fai_cfg_we_i            => fai_cfg_we,
        fai_cfg_clk_i           => fai_cfg_clk,
        fai_cfg_val_o           => fai_cfg_val,
        fofb_watchdog_o         => fofb_watchdog,
        fofb_event_o            => fofb_event,
        fofb_process_time_i     => fod_process_time,
        fofb_bpm_count_i        => fofb_bpm_count,
        fofb_dma_ok_o           => fofb_dma_ok,
        fofb_node_mask_i        => fofb_node_mask,
        fofb_timestamp_val_i    => fofb_timestamp_val
    );

led_n_o(0)  <= not fai_cfg_val(3);
led_n_o(1)  <= '1';
led_n_o(2)  <= '1';
led_n_o(3)  <= '1';

end rtl;
