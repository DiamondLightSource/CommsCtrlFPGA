----------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     :
--  Purpose      : Virtex5 GTP_DUAL
--  Responsible  : Isa S. Uzun
----------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------
--  Description: Virtex5 GTP_DUAL component instantiation with
--  required configuration.
----------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------
--  Known Errors: Please send any bug reports to isa.uzun@diamond.ac.uk
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

--***************************** Entity Declaration ****************************

entity FOFB_CC_GTP_TILE is
generic
(
    -- Simulation attributes
    TILE_SIM_MODE                : string    := "FAST"; -- Set to Fast Functional Simulation Model    
    TILE_SIM_GTPRESET_SPEEDUP    : integer   := 0; -- Set to 1 to speed up sim reset
    TILE_SIM_PLL_PERDIV2         : bit_vector:= x"1d6"; -- Set to the VCO Unit Interval time 

    -- Channel bonding attributes
    TILE_CHAN_BOND_MODE_0        : string    := "OFF";  -- "MASTER", "SLAVE", or "OFF"
    TILE_CHAN_BOND_LEVEL_0       : integer   := 0;     -- 0 to 7. See UG for details

    TILE_CHAN_BOND_MODE_1        : string    := "OFF";  -- "MASTER", "SLAVE", or "OFF"
    TILE_CHAN_BOND_LEVEL_1       : integer   := 0      -- 0 to 7. See UG for details
);
port 
(
    ------------------------ Loopback and Powerdown Ports ----------------------
    LOOPBACK0_IN                            : in   std_logic_vector(2 downto 0);
    LOOPBACK1_IN                            : in   std_logic_vector(2 downto 0);
    RXPOWERDOWN0_IN                         : in   std_logic_vector(1 downto 0);
    RXPOWERDOWN1_IN                         : in   std_logic_vector(1 downto 0);
    TXPOWERDOWN0_IN                         : in   std_logic_vector(1 downto 0);
    TXPOWERDOWN1_IN                         : in   std_logic_vector(1 downto 0);
    ----------------------- Receive Ports - 8b10b Decoder ----------------------
    RXCHARISK0_OUT                          : out  std_logic_vector(1 downto 0);
    RXCHARISK1_OUT                          : out  std_logic_vector(1 downto 0);
    RXDISPERR0_OUT                          : out  std_logic_vector(1 downto 0);
    RXDISPERR1_OUT                          : out  std_logic_vector(1 downto 0);
    RXNOTINTABLE0_OUT                       : out  std_logic_vector(1 downto 0);
    RXNOTINTABLE1_OUT                       : out  std_logic_vector(1 downto 0);
    ------------------- Receive Ports - Clock Correction Ports -----------------
    --------------- Receive Ports - Comma Detection and Alignment --------------
    RXBYTEREALIGN0_OUT                      : out  std_logic;
    RXBYTEREALIGN1_OUT                      : out  std_logic;
    RXENMCOMMAALIGN0_IN                     : in   std_logic;
    RXENMCOMMAALIGN1_IN                     : in   std_logic;
    RXENPCOMMAALIGN0_IN                     : in   std_logic;
    RXENPCOMMAALIGN1_IN                     : in   std_logic;
    ------------------- Receive Ports - RX Data Path interface -----------------
    RXDATA0_OUT                             : out  std_logic_vector(15 downto 0);
    RXDATA1_OUT                             : out  std_logic_vector(15 downto 0);
    RXRESET0_IN                             : in   std_logic;
    RXRESET1_IN                             : in   std_logic;
    RXUSRCLK0_IN                            : in   std_logic;
    RXUSRCLK1_IN                            : in   std_logic;
    RXUSRCLK20_IN                           : in   std_logic;
    RXUSRCLK21_IN                           : in   std_logic;
    ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    RXN0_IN                                 : in   std_logic;
    RXN1_IN                                 : in   std_logic;
    RXP0_IN                                 : in   std_logic;
    RXP1_IN                                 : in   std_logic;
    -------- Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    RXBUFSTATUS0_OUT                        : out  std_logic_vector(2 downto 0);
    RXBUFSTATUS1_OUT                        : out  std_logic_vector(2 downto 0);
    --------------------- Shared Ports - Tile and PLL Ports --------------------
    CLKIN_IN                                : in   std_logic;
    GTPRESET_IN                             : in   std_logic;
    PLLLKDET_OUT                            : out  std_logic;
    REFCLKOUT_OUT                           : out  std_logic;
    RESETDONE0_OUT                          : out  std_logic;
    RESETDONE1_OUT                          : out  std_logic;
    RXELECIDLERESET0_OUT                    : out  std_logic;
    RXELECIDLERESET1_OUT                    : out  std_logic;
    ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    TXCHARISK0_IN                           : in   std_logic_vector(1 downto 0);
    TXCHARISK1_IN                           : in   std_logic_vector(1 downto 0);
    TXKERR0_OUT                             : out  std_logic_vector(1 downto 0);
    TXKERR1_OUT                             : out  std_logic_vector(1 downto 0);
    ------------- Transmit Ports - TX Buffering and Phase Alignment ------------
    TXBUFSTATUS0_OUT                        : out  std_logic_vector(1 downto 0);
    TXBUFSTATUS1_OUT                        : out  std_logic_vector(1 downto 0);
    ------------------ Transmit Ports - TX Data Path interface -----------------
    TXDATA0_IN                              : in   std_logic_vector(15 downto 0);
    TXDATA1_IN                              : in   std_logic_vector(15 downto 0);
    TXOUTCLK0_OUT                           : out  std_logic;
    TXOUTCLK1_OUT                           : out  std_logic;
    TXRESET0_IN                             : in   std_logic;
    TXRESET1_IN                             : in   std_logic;
    TXUSRCLK0_IN                            : in   std_logic;
    TXUSRCLK1_IN                            : in   std_logic;
    TXUSRCLK20_IN                           : in   std_logic;
    TXUSRCLK21_IN                           : in   std_logic;
    --------------- Transmit Ports - TX Driver and OOB signalling --------------
    TXN0_OUT                                : out  std_logic;
    TXN1_OUT                                : out  std_logic;
    TXP0_OUT                                : out  std_logic;
    TXP1_OUT                                : out  std_logic


);
end FOFB_CC_GTP_TILE;

architecture RTL of FOFB_CC_GTP_TILE is

   component GTP_DUAL
   generic (
        AC_CAP_DIS_0 : boolean := TRUE;
        AC_CAP_DIS_1 : boolean := TRUE;
        ALIGN_COMMA_WORD_0 : integer := 1;
        ALIGN_COMMA_WORD_1 : integer := 1;
        CHAN_BOND_1_MAX_SKEW_0 : integer := 7;
        CHAN_BOND_1_MAX_SKEW_1 : integer := 7;
        CHAN_BOND_2_MAX_SKEW_0 : integer := 1;
        CHAN_BOND_2_MAX_SKEW_1 : integer := 1;
        CHAN_BOND_LEVEL_0 : integer := 0;
        CHAN_BOND_LEVEL_1 : integer := 0;
        CHAN_BOND_MODE_0 : string := "OFF";
        CHAN_BOND_MODE_1 : string := "OFF";
        CHAN_BOND_SEQ_1_1_0 : bit_vector := "0001001010";
        CHAN_BOND_SEQ_1_1_1 : bit_vector := "0001001010";
        CHAN_BOND_SEQ_1_2_0 : bit_vector := "0001001010";
        CHAN_BOND_SEQ_1_2_1 : bit_vector := "0001001010";
        CHAN_BOND_SEQ_1_3_0 : bit_vector := "0001001010";
        CHAN_BOND_SEQ_1_3_1 : bit_vector := "0001001010";
        CHAN_BOND_SEQ_1_4_0 : bit_vector := "0110111100";
        CHAN_BOND_SEQ_1_4_1 : bit_vector := "0110111100";
        CHAN_BOND_SEQ_1_ENABLE_0 : bit_vector := "1111";
        CHAN_BOND_SEQ_1_ENABLE_1 : bit_vector := "1111";
        CHAN_BOND_SEQ_2_1_0 : bit_vector := "0110111100";
        CHAN_BOND_SEQ_2_1_1 : bit_vector := "0110111100";
        CHAN_BOND_SEQ_2_2_0 : bit_vector := "0100111100";
        CHAN_BOND_SEQ_2_2_1 : bit_vector := "0100111100";
        CHAN_BOND_SEQ_2_3_0 : bit_vector := "0100111100";
        CHAN_BOND_SEQ_2_3_1 : bit_vector := "0100111100";
        CHAN_BOND_SEQ_2_4_0 : bit_vector := "0100111100";
        CHAN_BOND_SEQ_2_4_1 : bit_vector := "0100111100";
        CHAN_BOND_SEQ_2_ENABLE_0 : bit_vector := "1111";
        CHAN_BOND_SEQ_2_ENABLE_1 : bit_vector := "1111";
        CHAN_BOND_SEQ_2_USE_0 : boolean := TRUE;
        CHAN_BOND_SEQ_2_USE_1 : boolean := TRUE;
        CHAN_BOND_SEQ_LEN_0 : integer := 4;
        CHAN_BOND_SEQ_LEN_1 : integer := 4;
        CLK25_DIVIDER : integer := 4;
        CLKINDC_B : boolean := TRUE;
        CLK_CORRECT_USE_0 : boolean := TRUE;
        CLK_CORRECT_USE_1 : boolean := TRUE;
        CLK_COR_ADJ_LEN_0 : integer := 1;
        CLK_COR_ADJ_LEN_1 : integer := 1;
        CLK_COR_DET_LEN_0 : integer := 1;
        CLK_COR_DET_LEN_1 : integer := 1;
        CLK_COR_INSERT_IDLE_FLAG_0 : boolean := FALSE;
        CLK_COR_INSERT_IDLE_FLAG_1 : boolean := FALSE;
        CLK_COR_KEEP_IDLE_0 : boolean := FALSE;
        CLK_COR_KEEP_IDLE_1 : boolean := FALSE;
        CLK_COR_MAX_LAT_0 : integer := 32;
        CLK_COR_MAX_LAT_1 : integer := 32;
        CLK_COR_MIN_LAT_0 : integer := 16;
        CLK_COR_MIN_LAT_1 : integer := 16;
        CLK_COR_PRECEDENCE_0 : boolean := TRUE;
        CLK_COR_PRECEDENCE_1 : boolean := TRUE;
        CLK_COR_REPEAT_WAIT_0 : integer := 5;
        CLK_COR_REPEAT_WAIT_1 : integer := 5;
        CLK_COR_SEQ_1_1_0 : bit_vector := "0100011100";
        CLK_COR_SEQ_1_1_1 : bit_vector := "0100011100";
        CLK_COR_SEQ_1_2_0 : bit_vector := "0000000000";
        CLK_COR_SEQ_1_2_1 : bit_vector := "0000000000";
        CLK_COR_SEQ_1_3_0 : bit_vector := "0000000000";
        CLK_COR_SEQ_1_3_1 : bit_vector := "0000000000";
        CLK_COR_SEQ_1_4_0 : bit_vector := "0000000000";
        CLK_COR_SEQ_1_4_1 : bit_vector := "0000000000";
        CLK_COR_SEQ_1_ENABLE_0 : bit_vector := "1111";
        CLK_COR_SEQ_1_ENABLE_1 : bit_vector := "1111";
        CLK_COR_SEQ_2_1_0 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_1_1 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_2_0 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_2_1 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_3_0 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_3_1 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_4_0 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_4_1 : bit_vector := "0000000000";
        CLK_COR_SEQ_2_ENABLE_0 : bit_vector := "1111";
        CLK_COR_SEQ_2_ENABLE_1 : bit_vector := "1111";
        CLK_COR_SEQ_2_USE_0 : boolean := FALSE;
        CLK_COR_SEQ_2_USE_1 : boolean := FALSE;
        COMMA_10B_ENABLE_0 : bit_vector := "1111111111";
        COMMA_10B_ENABLE_1 : bit_vector := "1111111111";
        COMMA_DOUBLE_0 : boolean := FALSE;
        COMMA_DOUBLE_1 : boolean := FALSE;
        COM_BURST_VAL_0 : bit_vector := "1111";
        COM_BURST_VAL_1 : bit_vector := "1111";
        DEC_MCOMMA_DETECT_0 : boolean := TRUE;
        DEC_MCOMMA_DETECT_1 : boolean := TRUE;
        DEC_PCOMMA_DETECT_0 : boolean := TRUE;
        DEC_PCOMMA_DETECT_1 : boolean := TRUE;
        DEC_VALID_COMMA_ONLY_0 : boolean := TRUE;
        DEC_VALID_COMMA_ONLY_1 : boolean := TRUE;
        MCOMMA_10B_VALUE_0 : bit_vector := "1010000011";
        MCOMMA_10B_VALUE_1 : bit_vector := "1010000011";
        MCOMMA_DETECT_0 : boolean := TRUE;
        MCOMMA_DETECT_1 : boolean := TRUE;
        OOBDETECT_THRESHOLD_0 : bit_vector := "110";
        OOBDETECT_THRESHOLD_1 : bit_vector := "110";
        OOB_CLK_DIVIDER : integer := 4;
        OVERSAMPLE_MODE : boolean := FALSE;
        PCI_EXPRESS_MODE_0 : boolean := TRUE;
        PCI_EXPRESS_MODE_1 : boolean := TRUE;
        PCOMMA_10B_VALUE_0 : bit_vector := "0101111100";
        PCOMMA_10B_VALUE_1 : bit_vector := "0101111100";
        PCOMMA_DETECT_0 : boolean := TRUE;
        PCOMMA_DETECT_1 : boolean := TRUE;
        PLL_DIVSEL_FB : integer := 5;
        PLL_DIVSEL_REF : integer := 2;
        PLL_RXDIVSEL_OUT_0 : integer := 1;
        PLL_RXDIVSEL_OUT_1 : integer := 1;
        PLL_SATA_0 : boolean := FALSE;
        PLL_SATA_1 : boolean := FALSE;
        PLL_TXDIVSEL_COMM_OUT : integer := 1;
        PLL_TXDIVSEL_OUT_0 : integer := 1;
        PLL_TXDIVSEL_OUT_1 : integer := 1;
        PMA_CDR_SCAN_0 : bit_vector := X"6404034"; 
        PMA_CDR_SCAN_1 : bit_vector := X"6404034"; 
        PMA_RX_CFG_0 : bit_vector := X"09F0088";
        PMA_RX_CFG_1 : bit_vector := X"09F0088";
        PRBS_ERR_THRESHOLD_0 : bit_vector := X"11111111";
        PRBS_ERR_THRESHOLD_1 : bit_vector := X"11111111";
        RCV_TERM_GND_0 : boolean := TRUE;
        RCV_TERM_GND_1 : boolean := TRUE;
        RCV_TERM_MID_0 : boolean := FALSE;
        RCV_TERM_MID_1 : boolean := FALSE;
        RCV_TERM_VTTRX_0 : boolean := FALSE;
        RCV_TERM_VTTRX_1 : boolean := FALSE;
        RX_BUFFER_USE_0 : boolean := TRUE;
        RX_BUFFER_USE_1 : boolean := TRUE;
        RX_DECODE_SEQ_MATCH_0 : boolean := TRUE;
        RX_DECODE_SEQ_MATCH_1 : boolean := TRUE;
        RX_LOSS_OF_SYNC_FSM_0 : boolean := FALSE;
        RX_LOSS_OF_SYNC_FSM_1 : boolean := FALSE;
        RX_LOS_INVALID_INCR_0 : integer := 8;
        RX_LOS_INVALID_INCR_1 : integer := 8;
        RX_LOS_THRESHOLD_0 : integer := 128;
        RX_LOS_THRESHOLD_1 : integer := 128;
        RX_SLIDE_MODE_0 : string := "PCS";
        RX_SLIDE_MODE_1 : string := "PCS";
        RX_STATUS_FMT_0 : string := "PCIE";
        RX_STATUS_FMT_1 : string := "PCIE";
        RX_XCLK_SEL_0 : string := "RXREC";
        RX_XCLK_SEL_1 : string := "RXREC";
        SATA_BURST_VAL_0 : bit_vector := "100";
        SATA_BURST_VAL_1 : bit_vector := "100";
        SATA_IDLE_VAL_0 : bit_vector := "011";
        SATA_IDLE_VAL_1 : bit_vector := "011";
        SATA_MAX_BURST_0 : integer := 7;
        SATA_MAX_BURST_1 : integer := 7;
        SATA_MAX_INIT_0 : integer := 22;
        SATA_MAX_INIT_1 : integer := 22;
        SATA_MAX_WAKE_0 : integer := 7;
        SATA_MAX_WAKE_1 : integer := 7;
        SATA_MIN_BURST_0 : integer := 4;
        SATA_MIN_BURST_1 : integer := 4;
        SATA_MIN_INIT_0 : integer := 12;
        SATA_MIN_INIT_1 : integer := 12;
        SATA_MIN_WAKE_0 : integer := 4;
        SATA_MIN_WAKE_1 : integer := 4;
        SIM_GTPRESET_SPEEDUP : integer := 0;
        SIM_PLL_PERDIV2 : bit_vector := X"190";
        SIM_RECEIVER_DETECT_PASS0 : boolean;
        SIM_RECEIVER_DETECT_PASS1 : boolean;
        SIM_MODE : string;
        PCS_COM_CFG : bit_vector;
        TERMINATION_CTRL : bit_vector := "10100";
        TERMINATION_IMP_0 : integer := 50;
        TERMINATION_IMP_1 : integer := 50;
        TERMINATION_OVRD : boolean := FALSE;
        TRANS_TIME_FROM_P2_0 : bit_vector := X"003c";
        TRANS_TIME_FROM_P2_1 : bit_vector := X"003c";
        TRANS_TIME_NON_P2_0 : bit_vector := X"0019";
        TRANS_TIME_NON_P2_1 : bit_vector := X"0019";
        TRANS_TIME_TO_P2_0 : bit_vector := X"0064";
        TRANS_TIME_TO_P2_1 : bit_vector := X"0064";
        TXRX_INVERT_0 : bit_vector := "00001";
        TXRX_INVERT_1 : bit_vector := "00001";
        TX_BUFFER_USE_0 : boolean := TRUE;
        TX_BUFFER_USE_1 : boolean := TRUE;
        TX_DIFF_BOOST_0 : boolean := FALSE;
        TX_DIFF_BOOST_1 : boolean := FALSE;
        TX_SYNC_FILTERB : integer := 1;
        TX_XCLK_SEL_0 : string := "TXUSR";
        TX_XCLK_SEL_1 : string := "TXUSR"
   );
   port (
        DO : out std_logic_vector(15 downto 0);
        DRDY : out std_ulogic;
        PHYSTATUS0 : out std_ulogic;
        PHYSTATUS1 : out std_ulogic;
        PLLLKDET : out std_ulogic;
        REFCLKOUT : out std_ulogic;
        RESETDONE0 : out std_ulogic;
        RESETDONE1 : out std_ulogic;
        RXBUFSTATUS0 : out std_logic_vector(2 downto 0);
        RXBUFSTATUS1 : out std_logic_vector(2 downto 0);
        RXBYTEISALIGNED0 : out std_ulogic;
        RXBYTEISALIGNED1 : out std_ulogic;
        RXBYTEREALIGN0 : out std_ulogic;
        RXBYTEREALIGN1 : out std_ulogic;
        RXCHANBONDSEQ0 : out std_ulogic;
        RXCHANBONDSEQ1 : out std_ulogic;
        RXCHANISALIGNED0 : out std_ulogic;
        RXCHANISALIGNED1 : out std_ulogic;
        RXCHANREALIGN0 : out std_ulogic;
        RXCHANREALIGN1 : out std_ulogic;
        RXCHARISCOMMA0 : out std_logic_vector(1 downto 0);
        RXCHARISCOMMA1 : out std_logic_vector(1 downto 0);
        RXCHARISK0 : out std_logic_vector(1 downto 0);
        RXCHARISK1 : out std_logic_vector(1 downto 0);
        RXCHBONDO0 : out std_logic_vector(2 downto 0);
        RXCHBONDO1 : out std_logic_vector(2 downto 0);
        RXCLKCORCNT0 : out std_logic_vector(2 downto 0);
        RXCLKCORCNT1 : out std_logic_vector(2 downto 0);
        RXCOMMADET0 : out std_ulogic;
        RXCOMMADET1 : out std_ulogic;
        RXDATA0 : out std_logic_vector(15 downto 0);
        RXDATA1 : out std_logic_vector(15 downto 0);
        RXDISPERR0 : out std_logic_vector(1 downto 0);
        RXDISPERR1 : out std_logic_vector(1 downto 0);
        RXELECIDLE0 : out std_ulogic;
        RXELECIDLE1 : out std_ulogic;
        RXLOSSOFSYNC0 : out std_logic_vector(1 downto 0);
        RXLOSSOFSYNC1 : out std_logic_vector(1 downto 0);
        RXNOTINTABLE0 : out std_logic_vector(1 downto 0);
        RXNOTINTABLE1 : out std_logic_vector(1 downto 0);
        RXOVERSAMPLEERR0 : out std_ulogic;
        RXOVERSAMPLEERR1 : out std_ulogic;
        RXPRBSERR0 : out std_ulogic;
        RXPRBSERR1 : out std_ulogic;
        RXRECCLK0 : out std_ulogic;
        RXRECCLK1 : out std_ulogic;
        RXRUNDISP0 : out std_logic_vector(1 downto 0);
        RXRUNDISP1 : out std_logic_vector(1 downto 0);
        RXSTATUS0 : out std_logic_vector(2 downto 0);
        RXSTATUS1 : out std_logic_vector(2 downto 0);
        RXVALID0 : out std_ulogic;
        RXVALID1 : out std_ulogic;
        TXBUFSTATUS0 : out std_logic_vector(1 downto 0);
        TXBUFSTATUS1 : out std_logic_vector(1 downto 0);
        TXKERR0 : out std_logic_vector(1 downto 0);
        TXKERR1 : out std_logic_vector(1 downto 0);
        TXN0 : out std_ulogic;
        TXN1 : out std_ulogic;
        TXOUTCLK0 : out std_ulogic;
        TXOUTCLK1 : out std_ulogic;
        TXP0 : out std_ulogic;
        TXP1 : out std_ulogic;
        TXRUNDISP0 : out std_logic_vector(1 downto 0);
        TXRUNDISP1 : out std_logic_vector(1 downto 0);
        CLKIN : in std_ulogic;
        DADDR : in std_logic_vector(6 downto 0);
        DCLK : in std_ulogic;
        DEN : in std_ulogic;
        DI : in std_logic_vector(15 downto 0);
        DWE : in std_ulogic;
        GTPRESET : in std_ulogic;
        GTPTEST : in std_logic_vector(3 downto 0);
        INTDATAWIDTH : in std_ulogic;
        LOOPBACK0 : in std_logic_vector(2 downto 0);
        LOOPBACK1 : in std_logic_vector(2 downto 0);
        PLLLKDETEN : in std_ulogic;
        PLLPOWERDOWN : in std_ulogic;
        PRBSCNTRESET0 : in std_ulogic;
        PRBSCNTRESET1 : in std_ulogic;
        REFCLKPWRDNB : in std_ulogic;
        RXBUFRESET0 : in std_ulogic;
        RXBUFRESET1 : in std_ulogic;
        RXCDRRESET0 : in std_ulogic;
        RXCDRRESET1 : in std_ulogic;
        RXCHBONDI0 : in std_logic_vector(2 downto 0);
        RXCHBONDI1 : in std_logic_vector(2 downto 0);
        RXCOMMADETUSE0 : in std_ulogic;
        RXCOMMADETUSE1 : in std_ulogic;
        RXDATAWIDTH0 : in std_ulogic;
        RXDATAWIDTH1 : in std_ulogic;
        RXDEC8B10BUSE0 : in std_ulogic;
        RXDEC8B10BUSE1 : in std_ulogic;
        RXELECIDLERESET0 : in std_ulogic;
        RXELECIDLERESET1 : in std_ulogic;
        RXENCHANSYNC0 : in std_ulogic;
        RXENCHANSYNC1 : in std_ulogic;
        RXENELECIDLERESETB : in std_ulogic;
        RXENEQB0 : in std_ulogic;
        RXENEQB1 : in std_ulogic;
        RXENMCOMMAALIGN0 : in std_ulogic;
        RXENMCOMMAALIGN1 : in std_ulogic;
        RXENPCOMMAALIGN0 : in std_ulogic;
        RXENPCOMMAALIGN1 : in std_ulogic;
        RXENPRBSTST0 : in std_logic_vector(1 downto 0);
        RXENPRBSTST1 : in std_logic_vector(1 downto 0);
        RXENSAMPLEALIGN0 : in std_ulogic;
        RXENSAMPLEALIGN1 : in std_ulogic;
        RXEQMIX0 : in std_logic_vector(1 downto 0);
        RXEQMIX1 : in std_logic_vector(1 downto 0);
        RXEQPOLE0 : in std_logic_vector(3 downto 0);
        RXEQPOLE1 : in std_logic_vector(3 downto 0);
        RXN0 : in std_ulogic;
        RXN1 : in std_ulogic;
        RXP0 : in std_ulogic;
        RXP1 : in std_ulogic;
        RXPMASETPHASE0 : in std_ulogic;
        RXPMASETPHASE1 : in std_ulogic;
        RXPOLARITY0 : in std_ulogic;
        RXPOLARITY1 : in std_ulogic;
        RXPOWERDOWN0 : in std_logic_vector(1 downto 0);
        RXPOWERDOWN1 : in std_logic_vector(1 downto 0);
        RXRESET0 : in std_ulogic;
        RXRESET1 : in std_ulogic;
        RXSLIDE0 : in std_ulogic;
        RXSLIDE1 : in std_ulogic;
        RXUSRCLK0 : in std_ulogic;
        RXUSRCLK1 : in std_ulogic;
        RXUSRCLK20 : in std_ulogic;
        RXUSRCLK21 : in std_ulogic;
        TXBUFDIFFCTRL0 : in std_logic_vector(2 downto 0);
        TXBUFDIFFCTRL1 : in std_logic_vector(2 downto 0);
        TXBYPASS8B10B0 : in std_logic_vector(1 downto 0);
        TXBYPASS8B10B1 : in std_logic_vector(1 downto 0);
        TXCHARDISPMODE0 : in std_logic_vector(1 downto 0);
        TXCHARDISPMODE1 : in std_logic_vector(1 downto 0);
        TXCHARDISPVAL0 : in std_logic_vector(1 downto 0);
        TXCHARDISPVAL1 : in std_logic_vector(1 downto 0);
        TXCHARISK0 : in std_logic_vector(1 downto 0);
        TXCHARISK1 : in std_logic_vector(1 downto 0);
        TXCOMSTART0 : in std_ulogic;
        TXCOMSTART1 : in std_ulogic;
        TXCOMTYPE0 : in std_ulogic;
        TXCOMTYPE1 : in std_ulogic;
        TXDATA0 : in std_logic_vector(15 downto 0);
        TXDATA1 : in std_logic_vector(15 downto 0);
        TXDATAWIDTH0 : in std_ulogic;
        TXDATAWIDTH1 : in std_ulogic;
        TXDETECTRX0 : in std_ulogic;
        TXDETECTRX1 : in std_ulogic;
        TXDIFFCTRL0 : in std_logic_vector(2 downto 0);
        TXDIFFCTRL1 : in std_logic_vector(2 downto 0);
        TXELECIDLE0 : in std_ulogic;
        TXELECIDLE1 : in std_ulogic;
        TXENC8B10BUSE0 : in std_ulogic;
        TXENC8B10BUSE1 : in std_ulogic;
        TXENPMAPHASEALIGN : in std_ulogic;
        TXENPRBSTST0 : in std_logic_vector(1 downto 0);
        TXENPRBSTST1 : in std_logic_vector(1 downto 0);
        TXINHIBIT0 : in std_ulogic;
        TXINHIBIT1 : in std_ulogic;
        TXPMASETPHASE : in std_ulogic;
        TXPOLARITY0 : in std_ulogic;
        TXPOLARITY1 : in std_ulogic;
        TXPOWERDOWN0 : in std_logic_vector(1 downto 0);
        TXPOWERDOWN1 : in std_logic_vector(1 downto 0);
        TXPREEMPHASIS0 : in std_logic_vector(2 downto 0);
        TXPREEMPHASIS1 : in std_logic_vector(2 downto 0);
        TXRESET0 : in std_ulogic;
        TXRESET1 : in std_ulogic;
        TXUSRCLK0 : in std_ulogic;
        TXUSRCLK1 : in std_ulogic;
        TXUSRCLK20 : in std_ulogic;
        TXUSRCLK21 : in std_ulogic
 );
end component;

--**************************** Signal Declarations ****************************

    -- ground and tied_to_vcc_i signals
    signal  tied_to_ground_i                :   std_logic;
    signal  tied_to_ground_vec_i            :   std_logic_vector(63 downto 0);
    signal  tied_to_vcc_i                   :   std_logic;
    signal  tied_to_vcc_vec_i               :   std_logic_vector(63 downto 0);

   

    -- RX Datapath signals
    signal rxdata0_i                        :   std_logic_vector(15 downto 0);      

    -- TX Datapath signals
    signal txdata0_i                        :   std_logic_vector(15 downto 0);

    -- Electrical idle reset logic signals
    signal loopback0_i                      :   std_logic_vector(2 downto 0);
    signal rxelecidle0_i                    :   std_logic;
    signal resetdone0_i                     :   std_logic;
    signal rxelecidlereset0_i               :   std_logic;
    signal serialloopback0_i                :   std_logic;
   

    -- RX Datapath signals
    signal rxdata1_i                        :   std_logic_vector(15 downto 0);      

    -- TX Datapath signals
    signal txdata1_i                        :   std_logic_vector(15 downto 0);

    -- Electrical idle reset logic signals
    signal loopback1_i                      :   std_logic_vector(2 downto 0);
    signal rxelecidle1_i                    :   std_logic;
    signal resetdone1_i                     :   std_logic;
    signal rxelecidlereset1_i               :   std_logic;
    signal serialloopback1_i                :   std_logic;

    -- Shared Electrical Idle Reset signal
    signal rxenelecidleresetb_i                      :   std_logic;


--******************************** Main Body of Code***************************

begin                      

    ---------------------------  Static signal Assignments ---------------------   

    tied_to_ground_i                    <= '0';
    tied_to_ground_vec_i(63 downto 0)   <= (others => '0');
    tied_to_vcc_i                       <= '1';
    tied_to_vcc_vec_i(63 downto 0)      <= (others => '1');
     
    

    -------------------  GTP Datapath byte mapping  -----------------    

    -- The GTP provides little endian data (first byte received on RXDATA(7 downto 0))    
    RXDATA0_OUT    <=   rxdata0_i;

    -- The GTP transmits little endian data (TXDATA(7 downto 0) transmitted first)    
    txdata0_i    <=   TXDATA0_IN;

    -- The GTP provides little endian data (first byte received on RXDATA(7 downto 0))    
    RXDATA1_OUT    <=   rxdata1_i;

    -- The GTP transmits little endian data (TXDATA(7 downto 0) transmitted first)    
    txdata1_i    <=   TXDATA1_IN;




---------------------------  Electrical Idle Reset Circuit  ---------------
RESETDONE0_OUT       <= resetdone0_i;
loopback0_i          <= LOOPBACK0_IN;
RESETDONE1_OUT       <= resetdone1_i;
loopback1_i          <= LOOPBACK1_IN;

RXELECIDLERESET0_OUT <= rxelecidlereset0_i;
RXELECIDLERESET1_OUT <= rxelecidlereset1_i;

--Drive RXELECIDLERESET with elec idle reset enabled during normal operation when RXELECIDLE goes high
rxelecidlereset0_i <= (rxelecidle0_i and resetdone0_i) and not serialloopback0_i;
rxelecidlereset1_i <= (rxelecidle1_i and resetdone1_i) and not serialloopback1_i;
rxenelecidleresetb_i <= not (rxelecidlereset0_i or rxelecidlereset1_i);
serialloopback0_i <= not loopback0_i(0) and loopback0_i(1) and not loopback0_i(2);
serialloopback1_i <= not loopback1_i(0) and loopback1_i(1) and not loopback1_i(2);


    ----------------------------- GTP_DUAL Instance  --------------------------   

    gtp_dual_i: GTP_DUAL
    generic map
    (
        --_______________________ Simulation-Only Attributes ___________________
        SIM_RECEIVER_DETECT_PASS0   =>       TRUE,
        SIM_RECEIVER_DETECT_PASS1   =>       TRUE,
        SIM_MODE                    =>       TILE_SIM_MODE,
        SIM_GTPRESET_SPEEDUP        =>       TILE_SIM_GTPRESET_SPEEDUP,
        SIM_PLL_PERDIV2             =>       TILE_SIM_PLL_PERDIV2,

        --___________________________ Shared Attributes ________________________

        -------------------------- Tile and PLL Attributes ---------------------

        CLK25_DIVIDER               =>       5, 
        CLKINDC_B                   =>       TRUE,
        OOB_CLK_DIVIDER             =>       4,
        OVERSAMPLE_MODE             =>       FALSE,
        PLL_DIVSEL_FB               =>       2,
        PLL_DIVSEL_REF              =>       1,
        PLL_TXDIVSEL_COMM_OUT       =>       1,
        TX_SYNC_FILTERB             =>       1,   


        --____________________ Transmit Interface Attributes ___________________

        ------------------- TX Buffering and Phase Alignment -------------------   
        TX_BUFFER_USE_0             =>       TRUE,
        TX_XCLK_SEL_0               =>       "TXOUT",
        TXRX_INVERT_0               =>       "00000",        

        TX_BUFFER_USE_1             =>       TRUE,
        TX_XCLK_SEL_1               =>       "TXOUT",
        TXRX_INVERT_1               =>       "00000",        
        --------------------- TX Serial Line Rate settings ---------------------   
        PLL_TXDIVSEL_OUT_0          =>       1,
        PLL_TXDIVSEL_OUT_1          =>       1,
        --------------------- TX Driver and OOB signalling --------------------  
        TX_DIFF_BOOST_0             =>       TRUE,
        TX_DIFF_BOOST_1             =>       TRUE,
        ------------------ TX Pipe Control for PCI Express/SATA ---------------
        COM_BURST_VAL_0             =>       "1111",
        COM_BURST_VAL_1             =>       "1111",
        --_______________________ Receive Interface Attributes ________________

        ------------ RX Driver,OOB signalling,Coupling and Eq,CDR -------------  
        AC_CAP_DIS_0                =>       FALSE, --TRUE,
        OOBDETECT_THRESHOLD_0       =>       "001",
        PMA_CDR_SCAN_0              =>       x"6c07640",
        PMA_RX_CFG_0                =>       x"09f0089",
        RCV_TERM_GND_0              =>       TRUE, --FALSE,
        RCV_TERM_MID_0              =>       TRUE, --FALSE,
        RCV_TERM_VTTRX_0            =>       FALSE,
        TERMINATION_IMP_0           =>       50,

        AC_CAP_DIS_1                =>       FALSE, --TRUE,
        OOBDETECT_THRESHOLD_1       =>       "001",
        PMA_CDR_SCAN_1              =>       x"6c07640",
        PMA_RX_CFG_1                =>       x"09f0089",  
        RCV_TERM_GND_1              =>       TRUE, --FALSE,
        RCV_TERM_MID_1              =>       TRUE, --FALSE,
        RCV_TERM_VTTRX_1            =>       FALSE,
        TERMINATION_IMP_1           =>       50,

        PCS_COM_CFG                 =>       x"1680a0e",
        TERMINATION_CTRL            =>       "10100",
        TERMINATION_OVRD            =>       FALSE,

        --------------------- RX Serial Line Rate Attributes ------------------   

        PLL_RXDIVSEL_OUT_0          =>       1,
        PLL_SATA_0                  =>       FALSE,

        PLL_RXDIVSEL_OUT_1          =>       1,
        PLL_SATA_1                  =>       FALSE,

        ----------------------- PRBS Detection Attributes ---------------------  

        PRBS_ERR_THRESHOLD_0        =>       x"00000001",

        PRBS_ERR_THRESHOLD_1        =>       x"00000001",

        ---------------- Comma Detection and Alignment Attributes -------------  

        ALIGN_COMMA_WORD_0          =>       2,
        COMMA_10B_ENABLE_0          =>       "1111111111",
        COMMA_DOUBLE_0              =>       FALSE,
        DEC_MCOMMA_DETECT_0         =>       TRUE,
        DEC_PCOMMA_DETECT_0         =>       TRUE,
        DEC_VALID_COMMA_ONLY_0      =>       FALSE,
        MCOMMA_10B_VALUE_0          =>       "1010000011",
        MCOMMA_DETECT_0             =>       TRUE,
        PCOMMA_10B_VALUE_0          =>       "0101111100",
        PCOMMA_DETECT_0             =>       TRUE,
        RX_SLIDE_MODE_0             =>       "PCS",

        ALIGN_COMMA_WORD_1          =>       2,
        COMMA_10B_ENABLE_1          =>       "1111111111",
        COMMA_DOUBLE_1              =>       FALSE,
        DEC_MCOMMA_DETECT_1         =>       TRUE,
        DEC_PCOMMA_DETECT_1         =>       TRUE,
        DEC_VALID_COMMA_ONLY_1      =>       FALSE,
        MCOMMA_10B_VALUE_1          =>       "1010000011",
        MCOMMA_DETECT_1             =>       TRUE,
        PCOMMA_10B_VALUE_1          =>       "0101111100",
        PCOMMA_DETECT_1             =>       TRUE,
        RX_SLIDE_MODE_1             =>       "PCS",

        ------------------ RX Loss-of-sync State Machine Attributes -----------  

        RX_LOSS_OF_SYNC_FSM_0       =>       FALSE,
        RX_LOS_INVALID_INCR_0       =>       8,
        RX_LOS_THRESHOLD_0          =>       128,

        RX_LOSS_OF_SYNC_FSM_1       =>       FALSE,
        RX_LOS_INVALID_INCR_1       =>       8,
        RX_LOS_THRESHOLD_1          =>       128,

        -------------- RX Elastic Buffer and Phase alignment Attributes -------   

        RX_BUFFER_USE_0             =>       TRUE,
        RX_XCLK_SEL_0               =>       "RXREC",

        RX_BUFFER_USE_1             =>       TRUE,
        RX_XCLK_SEL_1               =>       "RXREC",                   

        ------------------------ Clock Correction Attributes ------------------   

        CLK_CORRECT_USE_0           =>       TRUE,
        CLK_COR_ADJ_LEN_0           =>       2,
        CLK_COR_DET_LEN_0           =>       2,
        CLK_COR_INSERT_IDLE_FLAG_0  =>       FALSE,
        CLK_COR_KEEP_IDLE_0         =>       FALSE,
        CLK_COR_MAX_LAT_0           =>       18,
        CLK_COR_MIN_LAT_0           =>       16,
        CLK_COR_PRECEDENCE_0        =>       TRUE,
        CLK_COR_REPEAT_WAIT_0       =>       0,
        CLK_COR_SEQ_1_1_0           =>       "0110111100", -- K28.5 = BC
        CLK_COR_SEQ_1_2_0           =>       "0010010101", -- D21.4 = 95
        CLK_COR_SEQ_1_3_0           =>       "0010110101",
        CLK_COR_SEQ_1_4_0           =>       "0010110101",
        CLK_COR_SEQ_1_ENABLE_0      =>       "0011",
        CLK_COR_SEQ_2_1_0           =>       "0110111100",
        CLK_COR_SEQ_2_2_0           =>       "0000110101",
        CLK_COR_SEQ_2_3_0           =>       "0010111111",
        CLK_COR_SEQ_2_4_0           =>       "0001001001",
        CLK_COR_SEQ_2_ENABLE_0      =>       "0000",
        CLK_COR_SEQ_2_USE_0         =>       FALSE,
        RX_DECODE_SEQ_MATCH_0       =>       TRUE,

        CLK_CORRECT_USE_1           =>       TRUE,
        CLK_COR_ADJ_LEN_1           =>       2,
        CLK_COR_DET_LEN_1           =>       2,
        CLK_COR_INSERT_IDLE_FLAG_1  =>       FALSE,
        CLK_COR_KEEP_IDLE_1         =>       FALSE,
        CLK_COR_MAX_LAT_1           =>       18,
        CLK_COR_MIN_LAT_1           =>       16,
        CLK_COR_PRECEDENCE_1        =>       TRUE,
        CLK_COR_REPEAT_WAIT_1       =>       0,
        CLK_COR_SEQ_1_1_1           =>       "0110111100",
        CLK_COR_SEQ_1_2_1           =>       "0010010101",
        CLK_COR_SEQ_1_3_1           =>       "0010110101",
        CLK_COR_SEQ_1_4_1           =>       "0010110101",
        CLK_COR_SEQ_1_ENABLE_1      =>       "0011",
        CLK_COR_SEQ_2_1_1           =>       "0110111100",
        CLK_COR_SEQ_2_2_1           =>       "0000110101",
        CLK_COR_SEQ_2_3_1           =>       "0010111111",
        CLK_COR_SEQ_2_4_1           =>       "0001001001",
        CLK_COR_SEQ_2_ENABLE_1      =>       "0000",
        CLK_COR_SEQ_2_USE_1         =>       FALSE,
        RX_DECODE_SEQ_MATCH_1       =>       TRUE,

        ------------------------ Channel Bonding Attributes -------------------   

        CHAN_BOND_1_MAX_SKEW_0      =>       7,
        CHAN_BOND_2_MAX_SKEW_0      =>       7,
        CHAN_BOND_LEVEL_0           =>       TILE_CHAN_BOND_LEVEL_0,
        CHAN_BOND_MODE_0            =>       TILE_CHAN_BOND_MODE_0,
        CHAN_BOND_SEQ_1_1_0         =>       "0000000000",
        CHAN_BOND_SEQ_1_2_0         =>       "0000000000",
        CHAN_BOND_SEQ_1_3_0         =>       "0000000000",
        CHAN_BOND_SEQ_1_4_0         =>       "0000000000",
        CHAN_BOND_SEQ_1_ENABLE_0    =>       "0000",
        CHAN_BOND_SEQ_2_1_0         =>       "0000000000",
        CHAN_BOND_SEQ_2_2_0         =>       "0000000000",
        CHAN_BOND_SEQ_2_3_0         =>       "0000000000",
        CHAN_BOND_SEQ_2_4_0         =>       "0000000000",
        CHAN_BOND_SEQ_2_ENABLE_0    =>       "0000",
        CHAN_BOND_SEQ_2_USE_0       =>       FALSE,  
        CHAN_BOND_SEQ_LEN_0         =>       1,
        PCI_EXPRESS_MODE_0          =>       FALSE,   
     
        CHAN_BOND_1_MAX_SKEW_1      =>       7,
        CHAN_BOND_2_MAX_SKEW_1      =>       7,
        CHAN_BOND_LEVEL_1           =>       TILE_CHAN_BOND_LEVEL_1,
        CHAN_BOND_MODE_1            =>       TILE_CHAN_BOND_MODE_1,
        CHAN_BOND_SEQ_1_1_1         =>       "0000000000",
        CHAN_BOND_SEQ_1_2_1         =>       "0000000000",
        CHAN_BOND_SEQ_1_3_1         =>       "0000000000",
        CHAN_BOND_SEQ_1_4_1         =>       "0000000000",
        CHAN_BOND_SEQ_1_ENABLE_1    =>       "0000",
        CHAN_BOND_SEQ_2_1_1         =>       "0000000000",
        CHAN_BOND_SEQ_2_2_1         =>       "0000000000",
        CHAN_BOND_SEQ_2_3_1         =>       "0000000000",
        CHAN_BOND_SEQ_2_4_1         =>       "0000000000",
        CHAN_BOND_SEQ_2_ENABLE_1    =>       "0000",
        CHAN_BOND_SEQ_2_USE_1       =>       FALSE,  
        CHAN_BOND_SEQ_LEN_1         =>       1,
        PCI_EXPRESS_MODE_1          =>       FALSE,

        ------------------ RX Attributes for PCI Express/SATA ---------------

        RX_STATUS_FMT_0             =>       "PCIE",
        SATA_BURST_VAL_0            =>       "100",
        SATA_IDLE_VAL_0             =>       "100",
        SATA_MAX_BURST_0            =>       8,
        SATA_MAX_INIT_0             =>       23,
        SATA_MAX_WAKE_0             =>       8,
        SATA_MIN_BURST_0            =>       4,
        SATA_MIN_INIT_0             =>       13,
        SATA_MIN_WAKE_0             =>       4,
        TRANS_TIME_FROM_P2_0        =>       x"003c",
        TRANS_TIME_NON_P2_0         =>       x"0019",
        TRANS_TIME_TO_P2_0          =>       x"0064",

        RX_STATUS_FMT_1             =>       "PCIE",
        SATA_BURST_VAL_1            =>       "100",
        SATA_IDLE_VAL_1             =>       "100",
        SATA_MAX_BURST_1            =>       8,
        SATA_MAX_INIT_1             =>       23,
        SATA_MAX_WAKE_1             =>       8,
        SATA_MIN_BURST_1            =>       4,
        SATA_MIN_INIT_1             =>       13,
        SATA_MIN_WAKE_1             =>       4,
        TRANS_TIME_FROM_P2_1        =>       x"003c",
        TRANS_TIME_NON_P2_1         =>       x"0019",
        TRANS_TIME_TO_P2_1          =>       x"0064"
    )
    port map 
    (
        ------------------------ Loopback and Powerdown Ports ----------------------
        LOOPBACK0                       =>      loopback0_i,
        LOOPBACK1                       =>      loopback1_i,
        RXPOWERDOWN0                    =>      RXPOWERDOWN0_IN,
        RXPOWERDOWN1                    =>      RXPOWERDOWN1_IN,
        TXPOWERDOWN0                    =>      TXPOWERDOWN0_IN,
        TXPOWERDOWN1                    =>      TXPOWERDOWN1_IN,
        ----------------------- Receive Ports - 8b10b Decoder ----------------------
        RXCHARISCOMMA0                  =>      open,
        RXCHARISCOMMA1                  =>      open,
        RXCHARISK0                      =>      RXCHARISK0_OUT,
        RXCHARISK1                      =>      RXCHARISK1_OUT,
        RXDEC8B10BUSE0                  =>      tied_to_vcc_i,
        RXDEC8B10BUSE1                  =>      tied_to_vcc_i,
        RXDISPERR0                      =>      RXDISPERR0_OUT,
        RXDISPERR1                      =>      RXDISPERR1_OUT,
        RXNOTINTABLE0                   =>      RXNOTINTABLE0_OUT,
        RXNOTINTABLE1                   =>      RXNOTINTABLE1_OUT,
        RXRUNDISP0                      =>      open,
        RXRUNDISP1                      =>      open,
        ------------------- Receive Ports - Channel Bonding Ports ------------------
        RXCHANBONDSEQ0                  =>      open,
        RXCHANBONDSEQ1                  =>      open,
        RXCHBONDI0                      =>      tied_to_ground_vec_i(2 downto 0),
        RXCHBONDI1                      =>      tied_to_ground_vec_i(2 downto 0),
        RXCHBONDO0                      =>      open,
        RXCHBONDO1                      =>      open,
        RXENCHANSYNC0                   =>      tied_to_ground_i,
        RXENCHANSYNC1                   =>      tied_to_ground_i,
        ------------------- Receive Ports - Clock Correction Ports -----------------
        RXCLKCORCNT0                    =>      open,
        RXCLKCORCNT1                    =>      open,
        --------------- Receive Ports - Comma Detection and Alignment --------------
        RXBYTEISALIGNED0                =>      open,
        RXBYTEISALIGNED1                =>      open,
        RXBYTEREALIGN0                  =>      RXBYTEREALIGN0_OUT,
        RXBYTEREALIGN1                  =>      RXBYTEREALIGN1_OUT,
        RXCOMMADET0                     =>      open,
        RXCOMMADET1                     =>      open,
        RXCOMMADETUSE0                  =>      tied_to_vcc_i,
        RXCOMMADETUSE1                  =>      tied_to_vcc_i,
        RXENMCOMMAALIGN0                =>      RXENMCOMMAALIGN0_IN,
        RXENMCOMMAALIGN1                =>      RXENMCOMMAALIGN1_IN,
        RXENPCOMMAALIGN0                =>      RXENPCOMMAALIGN0_IN,
        RXENPCOMMAALIGN1                =>      RXENPCOMMAALIGN1_IN,
        RXSLIDE0                        =>      tied_to_ground_i,
        RXSLIDE1                        =>      tied_to_ground_i,
        ----------------------- Receive Ports - PRBS Detection ---------------------
        PRBSCNTRESET0                   =>      tied_to_ground_i,
        PRBSCNTRESET1                   =>      tied_to_ground_i,
        RXENPRBSTST0                    =>      tied_to_ground_vec_i(1 downto 0),
        RXENPRBSTST1                    =>      tied_to_ground_vec_i(1 downto 0),
        RXPRBSERR0                      =>      open,
        RXPRBSERR1                      =>      open,
        ------------------- Receive Ports - RX Data Path interface -----------------
        RXDATA0                         =>      rxdata0_i,
        RXDATA1                         =>      rxdata1_i,
        RXDATAWIDTH0                    =>      tied_to_vcc_i,
        RXDATAWIDTH1                    =>      tied_to_vcc_i,
        RXRECCLK0                       =>      open,
        RXRECCLK1                       =>      open,
        RXRESET0                        =>      RXRESET0_IN,
        RXRESET1                        =>      RXRESET1_IN,
        RXUSRCLK0                       =>      RXUSRCLK0_IN,
        RXUSRCLK1                       =>      RXUSRCLK1_IN,
        RXUSRCLK20                      =>      RXUSRCLK20_IN,
        RXUSRCLK21                      =>      RXUSRCLK21_IN,
        ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        RXCDRRESET0                     =>      tied_to_ground_i,
        RXCDRRESET1                     =>      tied_to_ground_i,
        RXELECIDLE0                     =>      rxelecidle0_i,
        RXELECIDLE1                     =>      rxelecidle1_i,
        RXELECIDLERESET0                =>      rxelecidlereset0_i,
        RXELECIDLERESET1                =>      rxelecidlereset1_i,
        RXENEQB0                        =>      tied_to_vcc_i,
        RXENEQB1                        =>      tied_to_vcc_i,
        RXEQMIX0                        =>      tied_to_ground_vec_i(1 downto 0),
        RXEQMIX1                        =>      tied_to_ground_vec_i(1 downto 0),
        RXEQPOLE0                       =>      tied_to_ground_vec_i(3 downto 0),
        RXEQPOLE1                       =>      tied_to_ground_vec_i(3 downto 0),
        RXN0                            =>      RXN0_IN,
        RXN1                            =>      RXN1_IN,
        RXP0                            =>      RXP0_IN,
        RXP1                            =>      RXP1_IN,
        -------- Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        RXBUFRESET0                     =>      tied_to_ground_i,
        RXBUFRESET1                     =>      tied_to_ground_i,
        RXBUFSTATUS0                    =>      RXBUFSTATUS0_OUT,
        RXBUFSTATUS1                    =>      RXBUFSTATUS1_OUT,
        RXCHANISALIGNED0                =>      open,
        RXCHANISALIGNED1                =>      open,
        RXCHANREALIGN0                  =>      open,
        RXCHANREALIGN1                  =>      open,
        RXPMASETPHASE0                  =>      tied_to_ground_i,
        RXPMASETPHASE1                  =>      tied_to_ground_i,
        RXSTATUS0                       =>      open,
        RXSTATUS1                       =>      open,
        --------------- Receive Ports - RX Loss-of-sync State Machine --------------
        RXLOSSOFSYNC0                   =>      open,
        RXLOSSOFSYNC1                   =>      open,
        ---------------------- Receive Ports - RX Oversampling ---------------------
        RXENSAMPLEALIGN0                =>      tied_to_ground_i,
        RXENSAMPLEALIGN1                =>      tied_to_ground_i,
        RXOVERSAMPLEERR0                =>      open,
        RXOVERSAMPLEERR1                =>      open,
        -------------- Receive Ports - RX Pipe Control for PCI Express -------------
        PHYSTATUS0                      =>      open,
        PHYSTATUS1                      =>      open,
        RXVALID0                        =>      open,
        RXVALID1                        =>      open,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        RXPOLARITY0                     =>      tied_to_ground_i,
        RXPOLARITY1                     =>      tied_to_ground_i,
        ------------- Shared Ports - Dynamic Reconfiguration Port (DRP) ------------
        DADDR                           =>      tied_to_ground_vec_i(6 downto 0),
        DCLK                            =>      tied_to_ground_i,
        DEN                             =>      tied_to_ground_i,
        DI                              =>      tied_to_ground_vec_i(15 downto 0),
        DO                              =>      open,
        DRDY                            =>      open,
        DWE                             =>      tied_to_ground_i,
        --------------------- Shared Ports - Tile and PLL Ports --------------------
        CLKIN                           =>      CLKIN_IN,
        GTPRESET                        =>      GTPRESET_IN,
        GTPTEST                         =>      tied_to_ground_vec_i(3 downto 0),
        INTDATAWIDTH                    =>      tied_to_vcc_i,
        PLLLKDET                        =>      PLLLKDET_OUT,
        PLLLKDETEN                      =>      tied_to_vcc_i,
        PLLPOWERDOWN                    =>      tied_to_ground_i,
        REFCLKOUT                       =>      REFCLKOUT_OUT,
        REFCLKPWRDNB                    =>      tied_to_vcc_i,
        RESETDONE0                      =>      resetdone0_i,
        RESETDONE1                      =>      resetdone1_i,
        RXENELECIDLERESETB              =>      rxenelecidleresetb_i,
        TXENPMAPHASEALIGN               =>      tied_to_ground_i,
        TXPMASETPHASE                   =>      tied_to_ground_i,
        ---------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        TXBYPASS8B10B0                  =>      tied_to_ground_vec_i(1 downto 0),
        TXBYPASS8B10B1                  =>      tied_to_ground_vec_i(1 downto 0),
        TXCHARDISPMODE0                 =>      tied_to_ground_vec_i(1 downto 0),
        TXCHARDISPMODE1                 =>      tied_to_ground_vec_i(1 downto 0),
        TXCHARDISPVAL0                  =>      tied_to_ground_vec_i(1 downto 0),
        TXCHARDISPVAL1                  =>      tied_to_ground_vec_i(1 downto 0),
        TXCHARISK0                      =>      TXCHARISK0_IN,
        TXCHARISK1                      =>      TXCHARISK1_IN,
        TXENC8B10BUSE0                  =>      tied_to_vcc_i,
        TXENC8B10BUSE1                  =>      tied_to_vcc_i,
        TXKERR0                         =>      TXKERR0_OUT,
        TXKERR1                         =>      TXKERR1_OUT,
        TXRUNDISP0                      =>      open,
        TXRUNDISP1                      =>      open,
        ------------- Transmit Ports - TX Buffering and Phase Alignment ------------
        TXBUFSTATUS0                    =>      TXBUFSTATUS0_OUT,
        TXBUFSTATUS1                    =>      TXBUFSTATUS1_OUT,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        TXDATA0                         =>      txdata0_i,
        TXDATA1                         =>      txdata1_i,
        TXDATAWIDTH0                    =>      tied_to_vcc_i,
        TXDATAWIDTH1                    =>      tied_to_vcc_i,
        TXOUTCLK0                       =>      TXOUTCLK0_OUT,
        TXOUTCLK1                       =>      TXOUTCLK1_OUT,
        TXRESET0                        =>      TXRESET0_IN,
        TXRESET1                        =>      TXRESET1_IN,
        TXUSRCLK0                       =>      TXUSRCLK0_IN,
        TXUSRCLK1                       =>      TXUSRCLK1_IN,
        TXUSRCLK20                      =>      TXUSRCLK20_IN,
        TXUSRCLK21                      =>      TXUSRCLK21_IN,
        --------------- Transmit Ports - TX Driver and OOB signalling --------------
        TXBUFDIFFCTRL0                  =>      "000",
        TXBUFDIFFCTRL1                  =>      "000",
        TXDIFFCTRL0                     =>      "000",
        TXDIFFCTRL1                     =>      "000",
        TXINHIBIT0                      =>      tied_to_ground_i,
        TXINHIBIT1                      =>      tied_to_ground_i,
        TXN0                            =>      TXN0_OUT,
        TXN1                            =>      TXN1_OUT,
        TXP0                            =>      TXP0_OUT,
        TXP1                            =>      TXP1_OUT,
        TXPREEMPHASIS0                  =>      "000",
        TXPREEMPHASIS1                  =>      "000",
        --------------------- Transmit Ports - TX PRBS Generator -------------------
        TXENPRBSTST0                    =>      tied_to_ground_vec_i(1 downto 0),
        TXENPRBSTST1                    =>      tied_to_ground_vec_i(1 downto 0),
        -------------------- Transmit Ports - TX Polarity Control ------------------
        TXPOLARITY0                     =>      tied_to_ground_i,
        TXPOLARITY1                     =>      tied_to_ground_i,
        ----------------- Transmit Ports - TX Ports for PCI Express ----------------
        TXDETECTRX0                     =>      tied_to_ground_i,
        TXDETECTRX1                     =>      tied_to_ground_i,
        TXELECIDLE0                     =>      tied_to_ground_i,
        TXELECIDLE1                     =>      tied_to_ground_i,
        --------------------- Transmit Ports - TX Ports for SATA -------------------
        TXCOMSTART0                     =>      tied_to_ground_i,
        TXCOMSTART1                     =>      tied_to_ground_i,
        TXCOMTYPE0                      =>      tied_to_ground_i,
        TXCOMTYPE1                      =>      tied_to_ground_i

    );

end RTL;


