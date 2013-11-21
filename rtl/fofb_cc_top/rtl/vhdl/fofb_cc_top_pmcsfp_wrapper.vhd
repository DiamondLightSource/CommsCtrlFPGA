library ieee;
use ieee.std_logic_1164.all;

library work;
use work.fofb_cc_pkg.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_top_wrapper is
    generic (
        USE_DCM                 : boolean := false;
        LANE_COUNT              : integer := 4;
        TX_IDLE_NUM             : natural := 18;
        RX_IDLE_NUM             : natural := 12;
        SEND_ID_NUM             : natural := 16
    );
    port (
        -- differential MGT/GTP clock inputs
        refclk_p_i              : in  std_logic;
        refclk_n_i              : in  std_logic;
        -- clock and reset interface
        sysclk_i                : in  std_logic;
        sysreset_n_i            : in  std_logic;
        -- FOFB communication controller configuration interface
        fai_cfg_a_o             : out std_logic_vector(10 downto 0);
        fai_cfg_d_o             : out std_logic_vector(31 downto 0);
        fai_cfg_d_i             : in  std_logic_vector(31 downto 0);
        fai_cfg_we_o            : out std_logic;
        fai_cfg_clk_o           : out std_logic;
        fai_cfg_val_i           : in  std_logic_vector(31 downto 0);
        fai_rxfifo_clear        : in  std_logic;
        fai_txfifo_clear        : in  std_logic;
        -- serial I/Os for eight RocketIOs on the Libera
        fai_rio_rdp_i           : in  std_logic_vector(LANE_COUNT-1 downto 0);
        fai_rio_rdn_i           : in  std_logic_vector(LANE_COUNT-1 downto 0);
        fai_rio_tdp_o           : out std_logic_vector(LANE_COUNT-1 downto 0);
        fai_rio_tdn_o           : out std_logic_vector(LANE_COUNT-1 downto 0);
        -- PMC-SFP module interface
        xy_buf_addr_i           : in  std_logic_vector(NodeW downto 0);
        xy_buf_dat_o            : out std_logic_vector(63 downto 0);
        xy_buf_rstb_i           : in  std_logic;
        timeframe_end_o         : out std_logic;
        -- Higher-level integration interface (used for PMC)
        fofb_watchdog_i         : in  std_logic_vector(31 downto 0);
        fofb_event_i            : in  std_logic_vector(31 downto 0);
        fofb_process_time_o     : out std_logic_vector(15 downto 0);
        fofb_bpm_count_o        : out std_logic_vector(7 downto 0);
        fofb_dma_ok_i           : in  std_logic;
        fofb_node_mask_o        : out std_logic_vector(NodeNum-1 downto 0);
        fofb_timestamp_val_o    : out std_logic_vector(31 downto 0)
);
end fofb_cc_top_wrapper;

architecture structure of fofb_cc_top_wrapper is
begin

fofb_cc_top : entity work.fofb_cc_top
    generic map (
        DEVICE                  => PMC,
        USE_DCM                 => USE_DCM,
        LANE_COUNT              => LANE_COUNT,
        TX_IDLE_NUM             => TX_IDLE_NUM,
        RX_IDLE_NUM             => RX_IDLE_NUM,
        SEND_ID_NUM             => SEND_ID_NUM
    )
    port map (
        refclk_p_i              => refclk_p_i,
        refclk_n_i              => refclk_n_i,
        adcclk_i                => '0',
        adcreset_i              => '0',
        sysclk_i                => sysclk_i,
        sysreset_n_i            => sysreset_n_i,
        fai_fa_block_start_i    => '0',
        fai_fa_data_valid_i     => '0',
        fai_fa_d_i              => (others => '0'),
        fai_cfg_a_o             => fai_cfg_a_o,
        fai_cfg_d_o             => fai_cfg_d_o,
        fai_cfg_d_i             => fai_cfg_d_i,
        fai_cfg_we_o            => fai_cfg_we_o,
        fai_cfg_clk_o           => fai_cfg_clk_o,
        fai_cfg_val_i           => fai_cfg_val_i,
        fai_psel_val_i          => X"000000FE",
        fai_rxfifo_clear        => fai_rxfifo_clear,
        fai_txfifo_clear        => fai_txfifo_clear,
        fai_rio_rdp_i           => fai_rio_rdp_i,
        fai_rio_rdn_i           => fai_rio_rdn_i,
        fai_rio_tdp_o           => fai_rio_tdp_o,
        fai_rio_tdn_o           => fai_rio_tdn_o,
        fai_rio_tdis_o          => open,
        coeff_x_addr_i          => (others => '0'),
        coeff_x_dat_o           => open,
        coeff_y_addr_i          => (others => '0'),
        coeff_y_dat_o           => open,
        xy_buf_addr_i           => xy_buf_addr_i,
        xy_buf_dat_o            => xy_buf_dat_o,
        xy_buf_rstb_i           => xy_buf_rstb_i,
        timeframe_start_o       => open,
        timeframe_end_o         => timeframe_end_o,
        fofb_watchdog_i         => fofb_watchdog_i,
        fofb_event_i            => fofb_event_i,
        fofb_process_time_o     => fofb_process_time_o,
        fofb_bpm_count_o        => fofb_bpm_count_o,
        fofb_dma_ok_i           => fofb_dma_ok_i,
        fofb_node_mask_o        => fofb_node_mask_o,
        fofb_rxlink_up_o        => open,
        fofb_rxlink_partner_o   => open,
        fofb_timestamp_val_o    => fofb_timestamp_val_o,
        harderror_cnt_o         => open,
        softerror_cnt_o         => open,
        frameerror_cnt_o        => open,
        bpmid_i                 => (others => '0'),
        timeframe_length_i      => (others => '0'),
        pbpm_xpos_0_i           => (others => '0'),
        pbpm_ypos_0_i           => (others => '0'),
        pbpm_xpos_1_i           => (others => '0'),
        pbpm_ypos_1_i           => (others => '0')
    );
end structure;

