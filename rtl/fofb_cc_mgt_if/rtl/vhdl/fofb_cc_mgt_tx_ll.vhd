----------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     :
--  Purpose      : MGT TX interface
--  Responsible  : Isa S. Uzun
----------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------
--  Description: This module handles TX data flow from CC interface to
--  MGT. It is responsible from:
--      * TX link initialisation
--      * Data flow control from CC TX FIFO to MGT
--      * Error detection including CRC32
----------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------
--  Known Errors: Please send any bug reports to isa.uzun@diamond.ac.uk
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_mgt_tx_ll is
    generic (
        TX_IDLE_NUM             : natural := 16;    --32767 cc
        SEND_ID_NUM             : natural := 14     --8191 cc
    );
    port (
        mgtclk_i                : in  std_logic;
        mgtreset_i              : in  std_logic;
        txreset_o               : out std_logic;
        powerdown_i             : in  std_logic;
        -- time frame sync
        timeframe_end_i         : in std_logic;
        bpmid_i                 : in  std_logic_vector(7 downto 0);
        -- status information
        tx_link_up_o            : out std_logic;
        txpck_cnt_o             : out std_logic_vector(15 downto 0);
        -- tx/rx state machine status for reset operation
        tx_sm_busy_o            : out std_logic;
        -- TX FIFO interface
        txf_d_i                 : in  std_logic_vector(15 downto 0);
        txf_empty_i             : in  std_logic;
        txf_rd_en_o             : out std_logic;
        --
        tx_d_o                  : out std_logic_vector(15 downto 0);
        txcharisk_o             : out std_logic_vector(1 downto 0);
        --
        txkerr_i                : in  std_logic_vector(1 downto 0);
        txbuferr_i              : in  std_logic;
        --
        tx_harderror_o          : out std_logic
    );
end fofb_cc_mgt_tx_ll;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_mgt_tx_ll is

constant IDLE           : std_logic_vector (15 downto 0) := X"BC95"; --/K28.5
constant SOP            : std_logic_vector (15 downto 0) := X"5CFB"; --/K28.2/K27.7/
constant EOP            : std_logic_vector (15 downto 0) := X"FDFE"; --/K29.7/K30.7/·
constant SENDID         : std_logic_vector (7 downto 0)  := X"F7";   --/K23.7/

-- state machine declarations
type tx_state_type is (tx_rst, tx_sync, tx_init, tx_dly, tx_idle, tx_sop, tx_payload, tx_crc_holder, tx_eop, tx_wait);
signal tx_state         : tx_state_type;

signal counter_idle_tx          : unsigned(TX_IDLE_NUM-1 downto 0);
signal send_id_cnt              : unsigned(SEND_ID_NUM-1 downto 0);
signal error_detect_ena         : std_logic;
signal counter4bit              : unsigned(3 downto 0);
signal txpck_cnt                : unsigned(15 downto 0);
signal tx_harderror             : std_logic;
signal txf_rd_en                : std_logic;
signal tx_count                 : unsigned(4 downto 0);
signal crc_cnt                  : unsigned(2 downto 0);
signal wait_cnt                 : unsigned(2 downto 0);

begin

txf_rd_en_o  <= txf_rd_en;
tx_harderror_o <= tx_harderror;
txpck_cnt_o <= std_logic_Vector(txpck_cnt);

process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i = '1') then
        if (mgtreset_i = '1') then
            txpck_cnt <= X"0000";
        else
            if (tx_state = tx_eop) then
                txpck_cnt <= txpck_cnt + 1;
            end if;
        end if;
    end if;
end process;

------------------------------------------
-- TX state machine
------------------------------------------
gen_tx_data : process(mgtclk_i, mgtreset_i)
begin
    if (mgtclk_i'event and mgtclk_i = '1') then

        if ((mgtreset_i or tx_harderror or powerdown_i) = '1') then
            tx_state            <= tx_rst;
            tx_d_o              <= (others => '0');
            txcharisk_o         <= "00";
            tx_count            <= (others => '0');
            txf_rd_en           <= '0'; 
            tx_link_up_o        <= '0';
            counter_idle_tx     <= (others => '0');
            counter4bit         <= (others => '0');
            error_detect_ena    <= '0';
            tx_link_up_o        <= '0';
            send_id_cnt         <=  (others => '0');
            tx_sm_busy_o        <= '0';
            txreset_o           <= '1';
            crc_cnt             <= "000";
            wait_cnt            <= "000";

        else
            case tx_state is

                -- RocketIO TX reset for 7 clock cycles
                when tx_rst  =>
                    txreset_o <= '1';
                    if (counter4bit(3) = '1') then  
                        tx_state <= tx_sync;
                        txreset_o <= '0';
                    end if;

                    counter4bit <= counter4bit + 1;

                -- send IDLE characters for synchronisation
                when tx_sync    =>
                    tx_d_o           <= IDLE;
                    txcharisk_o         <= "10";
                    counter_idle_tx     <= counter_idle_tx + 1;

                    if (counter_idle_tx(TX_IDLE_NUM-1) = '1') then
                        tx_state        <= tx_idle;
                    end if;

                -- start TX operation
                when tx_idle  =>
                    -- If TX_FIFO has packets, start...
                    -- TX_FIFO_EMPTY is set to '1' during FIFO reset.
                    if (txf_empty_i = '0' and timeframe_end_i = '0') then
                        tx_state         <= tx_sop;
                        txf_rd_en      <= '1';    
                        tx_sm_busy_o     <= '1';        --tx fifo can not be reset...
                    else
                        tx_state         <= tx_idle;
                        txf_rd_en      <= '0';
                        tx_sm_busy_o     <= '0';
                    end if;

                    -- Inject owm BPM ID periodically only in tx_idle state
                    if (send_id_cnt(SEND_ID_NUM-1) = '1') then
                        tx_d_o         <= SENDID & bpmid_i;
                        send_id_cnt    <=  (others => '0');
                    else
                        tx_d_o         <= IDLE;
                        send_id_cnt    <=  send_id_cnt + 1;
                    end if;

                    txcharisk_o        <= "10";
                    tx_link_up_o       <= '1';
                    error_detect_ena   <= '1'; 

                -- Start packet encapsulation
                when tx_sop =>
                    tx_d_o   <= SOP;
                    tx_state    <= tx_payload;
                    txcharisk_o <= "11";

                -- Inject payload
                when tx_payload => 

                    tx_d_o   <= txf_d_i;
                    txcharisk_o <= "00";

                    if (tx_count = 7) then
                        tx_count       <= (others => '0');
                        tx_state       <= tx_crc_holder;
                    else
                        tx_count       <= tx_count + 1;
                        tx_state       <= tx_payload;
                    end if;

                    if (tx_count = 6) then
                        txf_rd_en      <= '0';
                    end if;

                -- Inject 4 byte CRC holder
                when tx_crc_holder =>
                    txcharisk_o <= "00";
                    tx_d_o   <= X"0000";

                    if (crc_cnt = 3) then
                        tx_state  <= tx_eop;
                        crc_cnt   <= "000";
                    else
                        tx_state  <= tx_crc_holder;
                        crc_cnt   <= crc_cnt + 1;
                    end if;

                -- stop encapsulation
                when tx_eop =>
                    tx_d_o       <= EOP;
                    txcharisk_o     <= "11";
                    tx_state        <= tx_wait;

                -- wait for 4 clock cycles before next package (MGT requirement)
                when tx_wait =>
                    txcharisk_o <= "10";
                    tx_d_o   <= IDLE;

                    if (wait_cnt = 3) then
                        if (txf_empty_i = '0' and timeframe_end_i = '0') then
                            tx_state     <= tx_sop;
                            txf_rd_en    <= '1';
                        else
                            tx_state     <= tx_idle;
                            txf_rd_en    <= '0';
                        end if;
                        wait_cnt     <= "000";
                    else
                        tx_state  <= tx_wait;
                        wait_cnt     <= wait_cnt + 1;
                    end if;

                when others =>
                    tx_d_o   <= IDLE;
                    txcharisk_o <= "10";
                    tx_state        <= tx_idle;
                    txf_rd_en <= '0';
                    tx_count        <= (others => '0');
            end case;
        end if;
    end if;
end process;

-------------------------------------------------------
-- TX error handling
--------------------------------------------------------
process (mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i = '1') then

        if (mgtreset_i = '1') then
            tx_harderror   <= '0';
        else
            -- Detect hard error, asserted for 1 cc.
            if (error_detect_ena = '1') then
                if (txkerr_i /= "00" or txbuferr_i = '1') then
                    tx_harderror <= '1';
                end if;
            else
                tx_harderror <= '0';
            end if;

        end if;
    end if;
end process;

end rtl;
