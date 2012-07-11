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
    mgt_clk                 : in std_logic;
    mgt_rst                 : in std_logic;
    -- Input Data structure (LaneCount x 128-bit wide)
    data_in                 : in std_logic_2d_128(LaneCount-1 downto 0);
    data_in_rdy             : in std_logic_vector(LaneCount-1 downto 0);
    -- Read enable output to RX FIFO
    rx_fifo_rd_en           : out std_logic_vector(LaneCount-1 downto 0);
    -- Control ports
    channel_up              : in std_logic_vector(LaneCount-1 downto 0);
    -- Output data (1 x (32*PacketSize)-bit wide)
    data_out                : out std_logic_vector((32*PacketSize-1) downto 0);
    data_out_rdy            : out std_logic;
    -- time frame valid
    timeframe_valid_i       : in std_logic
);
end fofb_cc_arbmux;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_arbmux is

-----------------------------------------------
--  Signal declaration
-----------------------------------------------
signal packet_counter       : integer range 0 to LaneCount-1;
signal channel_counter      : integer range 0 to LaneCount-1;
signal linkup               : std_logic;
signal data_valid           : std_logic;
signal fifo_rd_en           : std_logic;

begin

linkup <= channel_up(channel_counter);
data_valid <= data_in_rdy(channel_counter);

process (mgt_clk)
begin
    if (mgt_clk'event and mgt_clk = '1') then
        if (mgt_rst = '1') then
            packet_counter <= 0;
            channel_counter <= 0;
        else
            if (timeframe_valid_i = '1') then
                if (linkup = '1' and data_valid = '1') then
                    if (packet_counter = LaneCount-1) then
                        if (channel_counter = LaneCount-1) then
                            channel_counter <= 0;
                        else
                            channel_counter <= channel_counter + 1;
                        end if;
                        packet_counter <= 0;
                    else
                        if (packet_counter = LaneCount-1) then
                        channel_counter <= 0;
                        else
                            packet_counter <= packet_counter + 1;
                        end if;
                    end if;
                else
                    if (channel_counter = LaneCount-1) then
                        channel_counter <= 0;
                    else
                        channel_counter <= channel_counter + 1;
                    end if;
                    packet_counter <= 0;
                end if;
            else
                packet_counter <= 0;
                channel_counter <= 0;
            end if;
        end if;
    end if;
end process;

-- FIFO read enable output multiplexer
fifo_rd_en <= '1' when (timeframe_valid_i = '1' and linkup = '1' and data_valid = '1')
                  else '0';

process(fifo_rd_en, channel_counter)
begin
    for I in 0 to LaneCount-1 loop
        if (I = channel_counter) then
            rx_fifo_rd_en(I) <= fifo_rd_en;
        else
            rx_fifo_rd_en(I) <= '0';
        end if;
    end loop;
end process;

-- Register outputs
process (mgt_clk)
begin
    if (mgt_clk'event and mgt_clk = '1') then
        data_out <= data_in(channel_counter);
        data_out_rdy <= fifo_rd_en;
    end if;
end process;

end rtl;

