----------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     :
--  Purpose      : Virtex6 GTX interface
--  Responsible  : Isa S. Uzun
----------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------
--  Description: This is the top-level interface module that instantiates
--  GTX Tile and user logic to interface CC.
----------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------
--  Known Errors: Please send any bug reports to isa.uzun@diamond.ac.uk
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.fofb_cc_pkg.all;

entity fofb_cc_gt_if is
    generic (
        -- CC Design selection parameters
        LaneCount               : integer := 1;
        TX_IDLE_NUM             : integer := 16;    --32767 cc
        RX_IDLE_NUM             : integer := 13;    --4095 cc
        SEND_ID_NUM             : integer := 14;    --8191 cc
        -- Simulation parameters
        SIM_GTPRESET_SPEEDUP    : integer := 0
    );
    port (
        -- clocks and resets
        refclk_i                : in  std_logic;
        mgtreset_i              : in  std_logic;
        initclk_i               : in  std_logic;

        -- system interface
        gtreset_i               : in  std_logic;
        txoutclk_o              : out std_logic;
        plllkdet_o              : out std_logic;
        userclk_i               : in  std_logic;
        userclk_2x_i            : in  std_logic;

        -- RocketIO
        rxn_i                   : in  std_logic_vector(LaneCount-1 downto 0);
        rxp_i                   : in  std_logic_vector(LaneCount-1 downto 0);
        txn_o                   : out std_logic_vector(LaneCount-1 downto 0);
        txp_o                   : out std_logic_vector(LaneCount-1 downto 0);

        -- time frame sync
        timeframe_start_i       : in  std_logic;
        timeframe_end_i         : in  std_logic;
        timeframe_val_i         : in  std_logic_vector(15 downto 0);
        bpmid_i                 : in  std_logic_vector(7 downto 0);

        -- mgt configuration
        powerdown_i             : in  std_logic_vector(3 downto 0);
        loopback_i              : in  std_logic_vector(7 downto 0);

        -- status information
        linksup_o               : out std_logic_vector(7 downto 0);
        frameerror_cnt_o        : out std_logic_2d_16(3 downto 0);
        softerror_cnt_o         : out std_logic_2d_16(3 downto 0);
        harderror_cnt_o         : out std_logic_2d_16(3 downto 0);
        txpck_cnt_o             : out std_logic_2d_16(3 downto 0);
        rxpck_cnt_o             : out std_logic_2d_16(3 downto 0);

        -- network information
        tfs_bit_o               : out std_logic_vector(3 downto 0);
        link_partner_o          : out std_logic_2d_10(3 downto 0);
        pmc_timeframe_val_o     : out std_logic_2d_16(3 downto 0);
        pmc_timestamp_val_o     : out std_logic_2d_32(3 downto 0);

        -- tx/rx state machine status for reset operation
        tx_sm_busy_o            : out std_logic_vector(LaneCount-1 downto 0);
        rx_sm_busy_o            : out std_logic_vector(LaneCount-1 downto 0);

        -- TX FIFO interface
        tx_dat_i                : in  std_logic_2d_16(LaneCount-1 downto 0);
        txf_empty_i             : in  std_logic_vector(LaneCount-1 downto 0);
        txf_rd_en_o             : out std_logic_vector(LaneCount-1 downto 0);

        -- RX FIFO interface
        rxf_full_i              : in  std_logic_vector(LaneCount-1 downto 0);
        rx_dat_o                : out std_logic_2d_16(LaneCount-1 downto 0);
        rx_dat_val_o            : out std_logic_vector(LaneCount-1 downto 0)
    );
end fofb_cc_gt_if;

architecture rtl of fofb_cc_gt_if is 

-- GTP_DUAL 0 & 1
signal rxusrclk0            : std_logic := '0';
signal rxusrclk1            : std_logic := '0';
signal rxusrclk20           : std_logic := '0';
signal rxusrclk21           : std_logic := '0';
signal clkin                : std_logic := '0';
signal txusrclk0            : std_logic := '0';
signal txusrclk1            : std_logic := '0';
signal txusrclk20           : std_logic := '0';
signal txusrclk21           : std_logic := '0';
signal plllkdet             : std_logic;
signal rxplllkdet           : std_logic_vector(3 downto 0);
signal txplllkdet           : std_logic_vector(3 downto 0);
signal refclkout            : std_logic;
signal txoutclk             : std_logic_vector(3 downto 0);
signal open_rxbufstatus0    : std_logic_vector(1 downto 0);
signal open_rxbufstatus1    : std_logic_vector(1 downto 0);
signal open_txbufstatus0    : std_logic;
signal open_txbufstatus1    : std_logic;
signal rxelecidlereset      : std_logic_vector(3 downto 0);

signal loopback             : std_logic_2d_3(3 downto 0);
signal powerdown            : std_logic_2d_2(3 downto 0);
signal txdata               : std_logic_2d_16(3 downto 0);
signal rxdata               : std_logic_2d_16(3 downto 0);
signal txcharisk            : std_logic_2d_2(3 downto 0);
signal rxcharisk            : std_logic_2d_2(3 downto 0);
signal rxenmcommaalign      : std_logic_vector(3 downto 0);
signal rxenpcommaalign      : std_logic_vector(3 downto 0);
signal userclk              : std_logic;
signal resetdone            : std_logic_vector(3 downto 0);
signal rxresetdone          : std_logic_vector(3 downto 0);
signal txresetdone          : std_logic_vector(3 downto 0);
signal txkerr               : std_logic_2d_2(3 downto 0);
signal txbuferr             : std_logic_vector(3 downto 0);
signal rxbuferr             : std_logic_vector(3 downto 0);
signal rxrealign            : std_logic_vector(3 downto 0);
signal rxdisperr            : std_logic_2d_2(3 downto 0);
signal rxnotintable         : std_logic_2d_2(3 downto 0);
signal rxreset              : std_logic_vector(3 downto 0);
signal txreset              : std_logic_vector(3 downto 0);
signal rxn                  : std_logic_vector(3 downto 0);
signal rxp                  : std_logic_vector(3 downto 0);
signal txn                  : std_logic_vector(3 downto 0);
signal txp                  : std_logic_vector(3 downto 0);

signal rx_dat_buffer        : std_logic_2d_16(LaneCount-1 downto 0);
signal rx_dat_val_buffer    : std_logic_vector(LaneCount-1 downto 0);
signal linksup_buffer       : std_logic_vector(7 downto 0);
signal link_partner_buffer  : std_logic_2d_10(3 downto 0);

signal tied_to_ground       : std_logic;
signal tied_to_vcc          : std_logic;

signal control              : std_logic_vector(35 downto 0);
signal data                 : std_logic_vector(63 downto 0);
signal trig0                : std_logic_vector(7 downto 0);

begin

-- Static signal Assignments
tied_to_ground <= '0';
tied_to_vcc    <= '1';

-- connect the txoutclk of lane 0 to txoutclk
txoutclk_o <= txoutclk(0);

-- assign outputs
rx_dat_o <= rx_dat_buffer;
rx_dat_val_o <= rx_dat_val_buffer;
linksup_o(1 downto 0) <= linksup_buffer(1 downto 0);
link_partner_o <= link_partner_buffer;

-- connect tx_lock to tx_lock_i from lane 0
plllkdet_o <= rxplllkdet(0);

userclk <= userclk_i;
resetdone <= rxresetdone and txresetdone;

--
-- GTP User Logic instantiation
--
gtx_if_gen : for N in 0 to (LaneCount-1) generate

    -- Back compatibility with V2Pro loopback. Supports
    -- parallel and serial loopback modes
    loopback(N) <= '0' & loopback_i(2*N+1 downto 2*N);
    powerdown(N) <= '0' & powerdown_i(N);

    -- Output ports
    --
    rxn(N) <= rxn_i(N);
    rxp(N) <= rxp_i(N);
    txn_o(N) <= txn(N);
    txp_o(N) <= txp(N);


    gtx_lane : entity work.fofb_cc_gtx_lane
        generic map(
            -- CC Design selection parameters
            TX_IDLE_NUM             => TX_IDLE_NUM,
            RX_IDLE_NUM             => RX_IDLE_NUM,
            SEND_ID_NUM             => SEND_ID_NUM
        )
        port map (
            userclk_i               => userclk,
            mgtreset_i              => mgtreset_i,
            gtp_resetdone_i         => resetdone(N),
            rxreset_o               => rxreset(N),
            txreset_o               => txreset(N),
            powerdown_i             => powerdown_i(N),
            rxelecidlereset_i       => tied_to_ground,

            timeframe_start_i       => timeframe_start_i,
            timeframe_end_i         => timeframe_end_i,
            timeframe_val_i         => timeframe_val_i,
            bpmid_i                 => bpmid_i,

            linksup_o               => linksup_buffer(2*N+1 downto 2*N),
            frameerror_cnt_o        => frameerror_cnt_o(N),
            softerror_cnt_o         => softerror_cnt_o(N),
            harderror_cnt_o         => harderror_cnt_o(N),
            txpck_cnt_o             => txpck_cnt_o(N),
            rxpck_cnt_o             => rxpck_cnt_o(N),

            tfs_bit_o               => tfs_bit_o(N),
            link_partner_o          => link_partner_buffer(N),
            pmc_timeframe_val_o     => pmc_timeframe_val_o(N),
            timestamp_val_o         => pmc_timestamp_val_o(N),

            tx_sm_busy_o            => tx_sm_busy_o(N),
            rx_sm_busy_o            => rx_sm_busy_o(N),

            tx_dat_i                => tx_dat_i(N),
            txf_empty_i             => txf_empty_i(N),
            txf_rd_en_o             => txf_rd_en_o(N),

            rxf_full_i              => rxf_full_i(N),
            rx_dat_o                => rx_dat_buffer(N),
            rx_dat_val_o            => rx_dat_val_buffer(N),

            txdata_o                => txdata(N),
            txcharisk_o             => txcharisk(N),
            rxdata_i                => rxdata(N),
            rxcharisk_i             => rxcharisk(N),
            rxenmcommaalign_o       => rxenmcommaalign(N),
            rxenpcommaalign_o       => rxenpcommaalign(N),
            txkerr_i                => txkerr(N),
            txbuferr_i              => txbuferr(N),
            rxbuferr_i              => rxbuferr(N),
            rxrealign_i             => rxrealign(N),
            rxdisperr_i             => rxdisperr(N),
            rxnotintable_i          => rxnotintable(N)
        );
--
-- GTP Tile instantiation
--
    gtx_tile_wrapper : entity work.fofb_cc_gtx_tile_wrapper
        generic map (
            -- simulation attributes
            GTX_SIM_GTXRESET_SPEEDUP    => SIM_GTPRESET_SPEEDUP
        )
        port map (
            loopback_in                => loopback(N),
            rxpowerdown_in             => powerdown(N),
            txpowerdown_in             => powerdown(N),
            rxcharisk_out              => rxcharisk(N),
            rxdisperr_out              => rxdisperr(N),
            rxnotintable_out           => rxnotintable(N),
            rxbyterealign_out          => rxrealign(N),
            rxenmcommaalign_in         => rxenmcommaalign(N),
            rxenpcommaalign_in         => rxenpcommaalign(N),
            rxdata_out                 => rxdata(N),
            rxreset_in                 => rxreset(N),
            rxusrclk2_in               => userclk_2x_i,
            rxn_in                     => rxn(N),
            rxp_in                     => rxp(N),
            rxbufstatus_out(2)         => rxbuferr(N),
            rxbufstatus_out(1 downto 0)=> open_rxbufstatus0(1 downto 0),

            gtxrxreset_in              => gtreset_i,
            mgtrefclkrx_in(0)          => refclk_i,
            mgtrefclkrx_in(1)          => tied_to_ground,
            pllrxreset_in              => tied_to_ground,
            rxplllkdet_out             => rxplllkdet(N),
            rxresetdone_out            => rxresetdone(N),

            gtxtxreset_in              => gtreset_i,
            mgtrefclktx_in(0)          => refclk_i,
            mgtrefclktx_in(1)          => tied_to_ground,
            plltxreset_in              => tied_to_ground,
            txplllkdet_out             => txplllkdet(n),
            txresetdone_out            => txresetdone(n),
            init_clk_in                => initclk_i,
            link_reset_in              => "00",

            txcharisk_in               => txcharisk(N),
            txkerr_out                 => txkerr(N),
            txbufstatus_out(1)         => txbuferr(N),
            txbufstatus_out(0)         => open_txbufstatus0,
            txdata_in                  => txdata(N),
            txoutclk_out               => txoutclk(N),
            txreset_in                 => txreset(N),
            txusrclk2_in               => userclk_2x_i,
            txn_out                    => txn(N),
            txp_out                    => txp(N)
        );
end generate;

--
-- Conditional chipscope generation
--
CSCOPE_GEN : if (GTX_IF_CSGEN = true) generate

icon_inst : icon
    port map (
        control0        => control
    );

ila_inst : ila_t8_d64_s16384
    port map (
        control         => control,
        clk             => userclk,
        data            => data,
        trig0           => trig0
     );

trig0(0)           <= rxbuferr(0);
trig0(1)           <= rxrealign(0);
trig0(7 downto 2)  <= (others => '0');

data(15 downto  0) <= rxdata(0);
data(16)           <= rxreset(0);
data(17)           <= rxplllkdet(0);
data(18)           <= rxresetdone(0);
data(20 downto 19) <= rxnotintable(0);
data(22 downto 21) <= rxdisperr(0);
data(24 downto 23) <= rxcharisk(0);
data(25)           <= rxbuferr(0);
data(26)           <= rxrealign(0);
data(29 downto 27) <= rxbuferr(0) & open_rxbufstatus0(1 downto 0);
data(63 downto 30) <= (others => '0');

end generate;

end rtl;
