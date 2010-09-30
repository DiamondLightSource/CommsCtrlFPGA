----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : fofb_cc_arbmux.vhd
--  Purpose      : Beam Position Monitor Input Arbiter / Multiplexer
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: This block implements Round-Robin algorithm for input
--  arbitration. A time slot of (LaneCount x PacketSize) clock cycles are
--  allocated for each channel. If the channel has no packet to be processed,
--  it moves to next channel
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.fofb_cc_pkg.all;   -- Diamond FOFB package

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_arbmux is
generic (
    LaneCount               : integer := 4
);
port (
    -- mgt_clk
    mgt_clk                 : in std_logic;
    -- System Reset (Active high)
    mgt_rst                 : in std_logic;
    -- Input Data structure (LaneCount x 128-bit wide)
    data_in                 : in std_logic_2d_128(LaneCount-1 downto 0);
    -- DataRdy in for each channel
    data_in_rdy             : in std_logic_vector(LaneCount-1 downto 0);
    -- Read enable output to RX FIFO
    rx_fifo_rd_en           : out std_logic_vector(LaneCount-1 downto 0);
    -- Control ports
    channel_up              : in std_logic_vector(LaneCount-1 downto 0);
    -- Output data (1 x (32*PacketSize)-bit wide)
    data_out                : out std_logic_vector((32*PacketSize-1) downto 0);
    -- Output Data ready signal. Active for 1 cc during first word of packet.
    data_out_rdy            : out std_logic;
    -- time frame start 
    timeframe_start_i       : in std_logic;
    -- time frame finished
    timeframe_end_i         : in std_logic
);
end fofb_cc_arbmux;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_arbmux is

-----------------------------------------------
--  Signal declaration
-----------------------------------------------
signal data_in_reg          : std_logic_2d_128(LaneCount-1 downto 0);
signal data_in_rdy_reg      : std_logic_vector(LaneCount-1 downto 0);
signal timeframe_start_prev : std_logic;    
signal timeframe_end_prev   : std_logic;
signal timeframe_end_rise   : std_logic;

-- Mux state machine
type mux_state_type is (mux_start, mux_idle, mux_transfer, mux_register);
signal mux_state                : mux_state_type;

begin

data_in_reg         <= data_in; 
data_in_rdy_reg     <= data_in_rdy;

timeframe_end_rise <= timeframe_end_i and not timeframe_end_prev;

arbmux: process (mgt_clk)

variable ActiveInputIndex_v     : integer range 0 to (LaneCount-1):= 0;
variable StoredInputIndex_v     : integer range 0 to (LaneCount-1):= 0;
variable PacketCount            : integer range 0 to LaneCount := 0;

begin
--------------------------------------------
--  Arbitrer state machine
--------------------------------------------
if (mgt_clk'event and mgt_clk='1') then
    if (mgt_rst = '1') then
        ActiveInputIndex_v   := 0;
        PacketCount          := 0; 
        mux_state            <= mux_start;
        rx_fifo_rd_en        <= (others => '0');
        data_out_rdy         <= '0';
        data_out             <= (others => '0');
        timeframe_start_prev <= '0';
        timeframe_end_prev   <= '0';
    else
        -- Delay start by 1 clock cycle for sync
        timeframe_start_prev <= timeframe_start_i;
        timeframe_end_prev <= timeframe_end_i;

        -- Registered output
        data_out            <= data_in_reg(ActiveInputIndex_v);

        case mux_state is

            when mux_start =>       -- start state  

                -- Wait for TimeFrameStart
                if (timeframe_start_prev = '1') then
                    mux_state   <= mux_idle;
                else    
                    mux_state   <= mux_start;
                end if; 

                data_out_rdy                      <= '0';
                rx_fifo_rd_en(ActiveInputIndex_v) <= '0';
                PacketCount := 0;

            when mux_idle =>        -- Idle State
                data_out_rdy  <= '0';

                -- Frame timeout go back to idle state and wait for new time frame
                if (timeframe_end_rise = '1') then  
                    mux_state <= mux_start;
                -- Look for Active Channels with Packet being ready in the RX fifo
                elsif (data_in_rdy_reg(ActiveInputIndex_v) = '1' and channel_up(ActiveInputIndex_v) = '1') then 
                    mux_state <= mux_register;
                    rx_fifo_rd_en(ActiveInputIndex_v) <= '1';
                -- Go on other channels
                else    
                    if (ActiveInputIndex_v = LaneCount-1) then
                        ActiveInputIndex_v := 0;
                    else    
                        ActiveInputIndex_v := ActiveInputIndex_v + 1;
                    end if;
                    mux_state                         <= mux_idle;
                    rx_fifo_rd_en(ActiveInputIndex_v) <= '0';
                    PacketCount := 0;
                end if;

            when mux_register =>
                -- Frame timeout go back to idle state and wait for new time frame
                if (timeframe_end_rise = '1') then  
                    mux_state <= mux_start;
                else
                -- wait for 1cc to read from RX FIFO
                    mux_state <= mux_transfer;
                end if;

                data_out_rdy <= '0';
                rx_fifo_rd_en(ActiveInputIndex_v) <= '0';
                PacketCount := PacketCount + 1;

            when mux_transfer =>        -- Start Packet Transfer
                data_out_rdy <= '1';

                -- Frame timeout go back to idle state and wait for new time frame
                if (timeframe_end_rise = '1') then  
                    mux_state <= mux_start;
                -- Check timeslot/data ready/link status to continue on the same link.
                elsif (not (PacketCount = LaneCount) and data_in_rdy_reg(ActiveInputIndex_v)='1' and channel_up(ActiveInputIndex_v) = '1') then
                    mux_state <= mux_register;
                    rx_fifo_rd_en(ActiveInputIndex_v) <= '1';
                else    -- Go on to next available link
                    StoredInputIndex_v := ActiveInputIndex_v;
                    if (ActiveInputIndex_v = LaneCount-1) then
                        ActiveInputIndex_v := 0;
                    else
                        ActiveInputIndex_v := ActiveInputIndex_v + 1;
                    end if;
                    mux_state   <= mux_idle;
                    PacketCount := 0;
                    rx_fifo_rd_en(StoredInputIndex_v) <= '0';
                end if;

            when others =>
                null;

        end case;
    end if;
end if;
end process;
end rtl;

