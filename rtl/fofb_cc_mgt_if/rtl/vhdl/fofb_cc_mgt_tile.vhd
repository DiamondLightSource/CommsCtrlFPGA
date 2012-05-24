----------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     :
--  Purpose      : Virtex2Pro GT_CUSTOM
--  Responsible  : Isa S. Uzun
----------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------
--  Description: Virtex2Pro GT_CUSTOM component instantiation with
--  required configuration.
----------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------
--  Known Errors: Please send any bug reports to isa.uzun@diamond.ac.uk
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

entity fofb_cc_mgt_tile is
    port (
        brefclk_i               : in  std_logic;
        refclksel_i             : in  std_logic;
        encommaalign_i          : in  std_logic;
        loopback_i              : in  std_logic_vector(1 downto 0);
        powerdown_i             : in  std_logic;
        rxn_i                   : in  std_logic;
        rxp_i                   : in  std_logic;
        rxreset_i               : in  std_logic;
        userclk_i               : in  std_logic;
        txcharisk_i             : in  std_logic_vector(1 downto 0);
        txdata_i                : in  std_logic_vector(15 downto 0);
        txreset_i               : in  std_logic;
        txpolarity_i            : in  std_logic;
        rxbufstatus_o           : out std_logic;
        rxcharisk_o             : out std_logic_vector(1 downto 0);
        rxcheckingcrc_o         : out std_logic;
        rxcrcerr_o              : out std_logic;
        rxdata_o                : out std_logic_vector(15 downto 0);
        rxdisperr_o             : out std_logic_vector(1 downto 0);
        rxnotintable_o          : out std_logic_vector(1 downto 0);
        rxrealign_o             : out std_logic; 
        txbuferr_o              : out std_logic; 
        txkerr_o                : out std_logic_vector(1 downto 0);
        txn_o                   : out std_logic;
        txp_o                   : out std_logic
    );
end fofb_cc_mgt_tile;

architecture rtl of fofb_cc_mgt_tile is

-----------------------------------------------
-- Component declaration
-----------------------------------------------
component BUFG
port (
    O : out STD_ULOGIC;
    I : in STD_ULOGIC
);
end component;

component GT_CUSTOM
generic (
    ALIGN_COMMA_MSB : boolean := FALSE;
    CHAN_BOND_LIMIT : integer := 16;
    CHAN_BOND_MODE : string := "OFF";
    CHAN_BOND_OFFSET : integer := 8;
    CHAN_BOND_ONE_SHOT : boolean := FALSE;
    CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
    CHAN_BOND_SEQ_2_USE : boolean := FALSE;
    CHAN_BOND_SEQ_LEN : integer := 1;
    CHAN_BOND_WAIT : integer := 8;
    CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
    CLK_COR_KEEP_IDLE : boolean := FALSE;
    CLK_COR_REPEAT_WAIT : integer := 1;
    CLK_COR_SEQ_1_1 : bit_vector := "00000000000";
    CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
    CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
    CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
    CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
    CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
    CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
    CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
    CLK_COR_SEQ_2_USE : boolean := FALSE;
    CLK_COR_SEQ_LEN : integer := 1;
    CLK_CORRECT_USE : boolean := TRUE;
    COMMA_10B_MASK : bit_vector := "1111111000";
    CRC_END_OF_PKT : string := "K29_7";
    CRC_FORMAT : string := "USER_MODE";
    CRC_START_OF_PKT : string := "K27_7";
    DEC_MCOMMA_DETECT : boolean := TRUE;
    DEC_PCOMMA_DETECT : boolean := TRUE;
    DEC_VALID_COMMA_ONLY : boolean := TRUE;
    MCOMMA_10B_VALUE : bit_vector := "1100000000";
    MCOMMA_DETECT : boolean := TRUE;
    PCOMMA_10B_VALUE : bit_vector := "0011111000";
    PCOMMA_DETECT : boolean := TRUE;
    REF_CLK_V_SEL : integer := 0;
    RX_BUFFER_USE : boolean := TRUE;
    RX_CRC_USE : boolean := FALSE;
    RX_DATA_WIDTH : integer := 2;
    RX_DECODE_USE : boolean := TRUE;
    RX_LOS_INVALID_INCR : integer := 1;
    RX_LOS_THRESHOLD : integer := 4;
    RX_LOSS_OF_SYNC_FSM : boolean := TRUE;
    SERDES_10B : boolean := FALSE;
    TERMINATION_IMP : integer := 50;
    TX_BUFFER_USE : boolean := TRUE;
    TX_CRC_FORCE_VALUE : bit_vector := "11010110";
    TX_CRC_USE : boolean := FALSE;
    TX_DATA_WIDTH : integer := 2;
    TX_DIFF_CTRL : integer := 500;
    TX_PREEMPHASIS : integer := 0
    );
port (
    CHBONDDONE : out std_ulogic;
    CHBONDO : out std_logic_vector(3 downto 0);
    CONFIGOUT : out std_ulogic;
    RXBUFSTATUS : out std_logic_vector(1 downto 0);
    RXCHARISCOMMA : out std_logic_vector(3 downto 0);
    RXCHARISK : out std_logic_vector(3 downto 0);
    RXCHECKINGCRC : out std_ulogic;
    RXCLKCORCNT : out std_logic_vector(2 downto 0);
    RXCOMMADET : out std_ulogic;
    RXCRCERR : out std_ulogic;
    RXDATA : out std_logic_vector(31 downto 0);
    RXDISPERR : out std_logic_vector(3 downto 0);
    RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
    RXNOTINTABLE : out std_logic_vector(3 downto 0);
    RXREALIGN : out std_ulogic;
    RXRECCLK : out std_ulogic;
    RXRUNDISP : out std_logic_vector(3 downto 0);
    TXBUFERR : out std_ulogic;
    TXKERR : out std_logic_vector(3 downto 0);
    TXN : out std_ulogic;
    TXP : out std_ulogic;
    TXRUNDISP : out std_logic_vector(3 downto 0);
    BREFCLK : in std_ulogic;
    BREFCLK2 : in std_ulogic;
    CHBONDI : in std_logic_vector(3 downto 0);
    CONFIGENABLE : in std_ulogic;
    CONFIGIN : in std_ulogic;
    ENCHANSYNC : in std_ulogic;
    ENMCOMMAALIGN : in std_ulogic;
    ENPCOMMAALIGN : in std_ulogic;
    LOOPBACK : in std_logic_vector(1 downto 0);
    POWERDOWN : in std_ulogic;
    REFCLK : in std_ulogic;
    REFCLK2 : in std_ulogic;
    REFCLKSEL : in std_ulogic;
    RXN : in std_ulogic;
    RXP : in std_ulogic;
    RXPOLARITY : in std_ulogic;
    RXRESET : in std_ulogic;
    RXUSRCLK : in std_ulogic;
    RXUSRCLK2 : in std_ulogic;
    TXBYPASS8B10B : in std_logic_vector(3 downto 0);
    TXCHARDISPMODE : in std_logic_vector(3 downto 0);
    TXCHARDISPVAL : in std_logic_vector(3 downto 0);
    TXCHARISK : in std_logic_vector(3 downto 0);
    TXDATA : in std_logic_vector(31 downto 0);
    TXFORCECRCERR : in std_ulogic;
    TXINHIBIT : in std_ulogic;
    TXPOLARITY : in std_ulogic;
    TXRESET : in std_ulogic;
    TXUSRCLK : in std_ulogic;
    TXUSRCLK2 : in std_ulogic
);
end component; 


signal GND4                     : std_logic_vector (15 downto 0);
signal float2_0                 : std_logic_vector(1 downto 0); 
signal float2_1                 : std_logic_vector(1 downto 0); 
signal float2_2                 : std_logic_vector(1 downto 0); 
signal float2_3                 : std_logic_vector(1 downto 0); 
signal float2_4                 : std_logic_vector(1 downto 0); 
signal float4                   : std_logic_vector(3 downto 0); 
signal float16                  : std_logic_vector(15 downto 0);    
signal rxrecclk                 : std_logic;
signal rxrecclk_r               : std_logic;
signal encommaalign_r           : std_logic;
signal rxbufstatus              : std_logic_vector(1 downto 0);
signal brefclk                  : std_logic;
signal brefclk2                 : std_logic;

begin

brefclk  <= brefclk_i when (refclksel_i = '0') else '0';
brefclk2 <= brefclk_i when (refclksel_i = '1') else '0';

rxbufstatus_o <= rxbufstatus(1);

GND4(15 downto 0) <= "0000000000000000";

-- RocketIO component instantiation
MGT_INST : GT_CUSTOM
    generic map( 
        ALIGN_COMMA_MSB             => TRUE,
        CHAN_BOND_LIMIT             => 16,
        CHAN_BOND_MODE              => "OFF",
        CHAN_BOND_OFFSET            => 8,
        CHAN_BOND_ONE_SHOT          => FALSE,
        CHAN_BOND_SEQ_1_1           => "00000000000",
        CHAN_BOND_SEQ_1_2           => "00000000000",
        CHAN_BOND_SEQ_1_3           => "00000000000",
        CHAN_BOND_SEQ_1_4           => "00000000000",
        CHAN_BOND_SEQ_2_1           => "00000000000",
        CHAN_BOND_SEQ_2_2           => "00000000000",
        CHAN_BOND_SEQ_2_3           => "00000000000",
        CHAN_BOND_SEQ_2_4           => "00000000000",
        CHAN_BOND_SEQ_2_USE         => FALSE,
        CHAN_BOND_SEQ_LEN           => 1,
        CHAN_BOND_WAIT              => 8,
        CLK_CORRECT_USE             => TRUE,
        CLK_COR_INSERT_IDLE_FLAG    => FALSE,
        CLK_COR_KEEP_IDLE           => FALSE,
        CLK_COR_REPEAT_WAIT         => 8,
        CLK_COR_SEQ_1_1             => "00110111100",--K28.5 = BC
        CLK_COR_SEQ_1_2             => "00010010101",--D21.4 = 95
        CLK_COR_SEQ_1_3             => "00000000000",
        CLK_COR_SEQ_1_4             => "00000000000",
        CLK_COR_SEQ_2_1             => "00000000000",
        CLK_COR_SEQ_2_2             => "00000000000",
        CLK_COR_SEQ_2_3             => "00000000000",
        CLK_COR_SEQ_2_4             => "00000000000",
        CLK_COR_SEQ_2_USE           => FALSE,
        CLK_COR_SEQ_LEN             => 2,
        COMMA_10B_MASK              => "1111111111",
        CRC_END_OF_PKT              => "K29_7",
        CRC_FORMAT                  => "USER_MODE",
        CRC_START_OF_PKT            => "K27_7",
        DEC_MCOMMA_DETECT           => TRUE,
        DEC_PCOMMA_DETECT           => TRUE,
        DEC_VALID_COMMA_ONLY        => TRUE,
        MCOMMA_10B_VALUE            => "1100000101",
        MCOMMA_DETECT               => TRUE,
        PCOMMA_10B_VALUE            => "0011111010",
        PCOMMA_DETECT               => TRUE,
        RX_BUFFER_USE               => TRUE,
        RX_DATA_WIDTH               => 2,
        RX_DECODE_USE               => TRUE,
        RX_LOSS_OF_SYNC_FSM         => TRUE,
        RX_LOS_INVALID_INCR         => 1,
        RX_LOS_THRESHOLD            => 4,
        TERMINATION_IMP             => 50,
        SERDES_10B                  => FALSE,
        TX_BUFFER_USE               => TRUE,
        TX_CRC_FORCE_VALUE          => "11010110",
        RX_CRC_USE                  => TRUE,
        TX_CRC_USE                  => TRUE,
        TX_DATA_WIDTH               => 2,
        TX_DIFF_CTRL                => 600,
        TX_PREEMPHASIS              => 1,
        REF_CLK_V_SEL               => 1
)
port map (
        CHBONDI(3 downto 0)         => "0000",
        ENCHANSYNC                  => '0',
        ENMCOMMAALIGN               => encommaalign_r, 
        ENPCOMMAALIGN               => encommaalign_r, 
        LOOPBACK                    => loopback_i,
        POWERDOWN                   => powerdown_i,
        RXN                         => rxn_i,
        RXP                         => rxp_i,
        RXPOLARITY                  => '0',
        RXRESET                     => rxreset_i,
        RXUSRCLK                    => userclk_i,
        RXUSRCLK2                   => userclk_i,
        TXUSRCLK                    => userclk_i,
        TXUSRCLK2                   => userclk_i,
        REFCLK                      => '0',
        REFCLKSEL                   => refclksel_i,   -- 0: bref, 1:bref2
        REFCLK2                     => '0',
        BREFCLK                     => brefclk,
        BREFCLK2                    => brefclk2,
        TXBYPASS8B10B               => "0000",
        TXCHARDISPMODE              => "0000",
        TXCHARDISPVAL               => "0000",
        CONFIGENABLE                => '0',
        CONFIGIN                    => '0',
        TXFORCECRCERR               => '0',
        TXINHIBIT                   => '0',
        TXPOLARITY                  => txpolarity_i,
        TXCHARISK(3 downto 2)       => "00",
        TXCHARISK(1 downto 0)       => txcharisk_i,
        TXDATA(31 downto 16)        => GND4(15 downto 0),
        TXDATA(15 downto 0)         => txdata_i,
        TXRESET                     => txreset_i,
        CHBONDDONE                  => open,
        CHBONDO                     => open,
        CONFIGOUT                   => open,
        RXBUFSTATUS                 => rxbufstatus,
        RXCHARISCOMMA               => open,
        RXCHARISK(3 downto 2)       => float2_1,
        RXCHARISK(1 downto 0)       => rxcharisk_o,
        RXCHECKINGCRC               => rxcheckingcrc_o,
        RXCLKCORCNT                 => open,
        RXCOMMADET                  => open,
        RXCRCERR                    => rxcrcerr_o,
        RXDATA(31 downto 16)        => float16,
        RXDATA(15 downto 0)         => rxdata_o,
        RXDISPERR(3 downto 2)       => float2_2,
        RXDISPERR(1 downto 0)       => rxdisperr_o,
        RXLOSSOFSYNC                => open,
        RXNOTINTABLE(3 downto 2)    => float2_3,
        RXNOTINTABLE(1 downto 0)    => rxnotintable_o,
        RXREALIGN                   => rxrealign_o,
        RXRECCLK                    => rxrecclk,
        RXRUNDISP                   => open,
        TXBUFERR                    => txbuferr_o,
        TXKERR(3 downto 2)          => float2_4,
        TXKERR(1 downto 0)          => txkerr_o,
        TXN                         => txn_o,
        TXP                         => txp_o,
        TXRUNDISP                   => open
);

i_phase_align : entity work.phase_align
port map (
    ENA_COMMA_ALIGN => encommaalign_i,
    RX_REC_CLK      => rxrecclk_r,
    ENA_CALIGN_REC  => encommaalign_r
);

i_bufg: BUFG
port map (
    O => rxrecclk_r,
    I => rxrecclk
);

end rtl;
