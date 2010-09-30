----------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     :
--  Purpose      : Virtex2Pro 2-byte lane interface to a single MGT
--  Responsible  : Isa S. Uzun
----------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------
--  Description: This module provides a full duplex 2-byte lane interface
--  to a single MGT. It instantiates RX and TX data path modules.
----------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------
--  Known Errors: Please send any bug reports to isa.uzun@diamond.ac.uk
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fofb_cc_mgt_lane is
    generic (
        TX_IDLE_NUM             : natural := 16;    --32767 cc
        RX_IDLE_NUM             : natural := 13;    --4095 cc
        SEND_ID_NUM             : natural := 14     --8191 cc
    );
    port (
        -- clocks and resets
        userclk_i               : in  std_logic;
        mgtreset_i              : in  std_logic;
        rxreset_o               : out std_logic;
        txreset_o               : out std_logic;
        powerdown_i             : in  std_logic;

        -- time frame sync
        timeframe_start_i       : in  std_logic;
        timeframe_end_i         : in std_logic;
        timeframe_val_i         : in  std_logic_vector(15 downto 0);
        bpmid_i                 : in  std_logic_vector(7 downto 0);

        -- status information
        linksup_o               : out std_logic_vector(1 downto 0); 
        frameerror_cnt_o        : inout std_logic_vector(15 downto 0);
        softerror_cnt_o         : inout std_logic_vector(15 downto 0);
        harderror_cnt_o         : inout std_logic_vector(15 downto 0);
        txpck_cnt_o             : out std_logic_vector(15 downto 0);
        rxpck_cnt_o             : out std_logic_vector(15 downto 0);

        -- network information
        tfs_bit_o               : out std_logic;
        link_partner_o          : out std_logic_vector(9 downto 0);
        pmc_timeframe_val_o     : out std_logic_vector(15 downto 0);
        timestamp_val_o         : out std_logic_vector(31 downto 0);

        -- tx/rx state machine status for reset operation
        tx_sm_busy_o            : out std_logic;
        rx_sm_busy_o            : out std_logic;

        -- TX FIFO interface
        tx_dat_i                : in  std_logic_vector(15 downto 0);
        txf_empty_i             : in  std_logic;
        txf_rd_en_o             : out std_logic;

        -- RX FIFO interface
        rxf_full_i              : in  std_logic;
        rx_dat_o                : out std_logic_vector (15 downto 0); 
        rx_dat_val_o            : out std_logic;

        -- GTP_DUAL Tile interface
        txdata_o                : out std_logic_vector(15 downto 0);
        txcharisk_o             : out std_logic_vector(1 downto 0);
        rxdata_i                : in  std_logic_vector(15 downto 0);
        rxcharisk_i             : in  std_logic_vector(1 downto 0);
        encommaalign_o          : out std_logic;
        txkerr_i                : in  std_logic_vector(1 downto 0);
        txbuferr_i              : in  std_logic;
        rxbuferr_i              : in  std_logic;
        rxrealign_i             : in  std_logic;
        rxdisperr_i             : in  std_logic_vector(1 downto 0);
        rxnotintable_i          : in  std_logic_vector(1 downto 0);
        rxcheckingcrc_i         : in  std_logic;
        rxcrcerr_i              : in  std_logic
    );
end fofb_cc_mgt_lane;

architecture rtl of fofb_cc_mgt_lane is

signal txlink_up            : std_logic;
signal rxlink_up            : std_logic;
signal ena_comma_align      : std_logic;
signal frameerror           : std_logic;
signal frameerror_prev      : std_logic;
signal frameerror_rise      : std_logic;
signal softerror            : std_logic;
signal softerror_prev       : std_logic;
signal softerror_rise       : std_logic;
signal tx_harderror         : std_logic;
signal rx_harderror         : std_logic;
signal harderror_prev       : std_logic;
signal harderror_rise       : std_logic;
signal harderror            : std_logic;

begin

linksup_o <= rxlink_up & txlink_up;
encommaalign_o <= ena_comma_align;

--
--
--
tx_ll : entity work.fofb_cc_mgt_tx_ll
    generic map (
        TX_IDLE_NUM         => TX_IDLE_NUM,
        SEND_ID_NUM         => SEND_ID_NUM
    )
    port map (
        mgtclk_i            => userclk_i,
        mgtreset_i          => mgtreset_i,
        txreset_o           => txreset_o,
        powerdown_i         => powerdown_i,
        timeframe_end_i     => timeframe_end_i,
        bpmid_i             => bpmid_i,
        tx_link_up_o        => txlink_up,
        txpck_cnt_o         => txpck_cnt_o,
        tx_sm_busy_o        => tx_sm_busy_o,
        txf_d_i             => tx_dat_i,
        txf_empty_i         => txf_empty_i,
        txf_rd_en_o         => txf_rd_en_o,
        tx_d_o              => txdata_o,
        txcharisk_o         => txcharisk_o,
        txkerr_i            => txkerr_i,
        txbuferr_i          => txbuferr_i,
        tx_harderror_o      => tx_harderror
    );

--
--
--
rx_ll : entity work.fofb_cc_mgt_rx_ll
    generic map (
        RX_IDLE_NUM         => RX_IDLE_NUM
    )
    port map (
        mgtclk_i            => userclk_i,
        mgtreset_i          => mgtreset_i,
        rxreset_o           => rxreset_o,
        powerdown_i         => powerdown_i,
        rx_link_up_o        => rxlink_up,
        rxpck_cnt_o         => rxpck_cnt_o,
        rx_sm_busy_o        => rx_sm_busy_o,
        rxf_d_o             => rx_dat_o,
        rxf_d_val_o         => rx_dat_val_o,
        rx_d_i              => rxdata_i,
        rxcharisk_i         => rxcharisk_i,
        tfs_bit_o           => tfs_bit_o,
        link_partner_o      => link_partner_o,
        pmc_timeframe_val_o => pmc_timeframe_val_o,
        timestamp_val_o     => timestamp_val_o,
        timeframe_end_i     => timeframe_end_i,
        timeframe_val_i     => timeframe_val_i,
        comma_align_o       => ena_comma_align,
        rxf_full_i          => rxf_full_i,
        rxbuferr_i          => rxbuferr_i,
        rxrealign_i         => rxrealign_i,
        rx_harderror_o      => rx_harderror,
        rx_softerror_o      => softerror,
        rx_frameerror_o     => frameerror,
        rxdisperr_i         => rxdisperr_i,
        rxnotintable_i      => rxnotintable_i,
        rxcheckingcrc_i     => rxcheckingcrc_i,
        rxcrcerr_i          => rxcrcerr_i
    );

--
-- Error Counters
--
harderror <= tx_harderror or rx_harderror;
frameerror_rise <= frameerror and not frameerror_prev;
softerror_rise <= softerror and not softerror_prev;
harderror_rise <= harderror and not harderror_prev;

process (userclk_i)
begin
if (userclk_i'event and userclk_i = '1') then
    if (mgtreset_i = '1') then
        frameerror_cnt_o <= (others => '0');
        softerror_cnt_o <= (others => '0');
        harderror_cnt_o <= (others => '0');
        softerror_prev <= '0';
        frameerror_prev <= '0';
        harderror_prev <= '0';
    else
        frameerror_prev <= frameerror;
        softerror_prev <= softerror;
        harderror_prev <= harderror;

        if (frameerror_rise = '1') then
            frameerror_cnt_o <= std_logic_vector(unsigned(frameerror_cnt_o) + 1);
        end if;

        if (softerror_rise = '1') then
            softerror_cnt_o <= std_logic_vector(unsigned(softerror_cnt_o) + 1);
        end if;

        if (harderror_rise = '1') then
            harderror_cnt_o <= std_logic_vector(unsigned(harderror_cnt_o) + 1);
        end if;
    end if;
end if;
end process;

end rtl;
