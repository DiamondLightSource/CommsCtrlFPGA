----------------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     : fofb_cc_fod.vhd
--  Purpose      : CC Forward or Discard Module
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: This block implements the CC  Forward Or Discard module.
--  It accepts incoming packets along with fod_idat_val_prev signal and
--  forwards or discards it
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.fofb_cc_pkg.all;           -- Diamond FOFB package

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_fod is
    generic (
        -- Design Configuration Options
        DEVICE                  : device_t := BPM;
        LaneCount               : integer  := 4
    );
    port (
        mgtclk_i                : in  std_logic;
        sysclk_i                : in  std_logic;
        mgtreset_i              : in  std_logic; 
        -- Frame start (1cc long)
        timeframe_valid_i       : in  std_logic;
        timeframe_start_i       : in  std_logic;
        timeframe_end_i         : in  std_logic;
        -- Channel up between channels
        linksup_i               : in  std_logic_vector(LaneCount-1 downto 0);
        -- Incoming data for arbmux to be Forwarded or Discarded
        fod_dat_i               : in  std_logic_vector((PacketSize*32-1) downto 0);
        fod_dat_val_i           : in  std_logic;
        -- Injected or Forwarded Data
        fod_dat_o               : out std_logic_vector((PacketSize*32-1) downto 0);
        fod_dat_val_o           : out std_logic_vector(LaneCount-1 downto 0);
        -- Frame status data
        timeframe_cntr_i        : in  std_logic_vector(31 downto 0);
        timestamp_val_i         : in  std_logic_vector(31 downto 0);
        timeframe_end_rise_o    : out std_logic;
        -- Packet information coming from Libera interface
        bpm_x_pos_i             : in  std_logic_vector(31 downto 0);
        bpm_y_pos_i             : in  std_logic_vector(31 downto 0);
        -- Dummy/Real position data select
        pos_datsel_i            : in  std_logic;
        -- TX FIFO full status
        txf_full_i              : in  std_logic_vector(LaneCount-1 downto 0);
        -- CC Configuration registers
        bpmid_i                 : in  std_logic_vector(9 downto 0);
        -- X and Y pos out to CEP and PMC Interface
        xy_buf_dout_o           : out std_logic_vector(63 downto 0);
        xy_buf_addr_i           : in  std_logic_vector(NodeNumIndexWidth downto 0);
        -- status info
        fodprocess_time_o       : out std_logic_vector(15 downto 0);
        bpm_count_o             : out std_logic_vector(7 downto 0);
        -- golden orbit
        golden_orb_x_i          : in  std_logic_vector(31 downto 0);
        golden_orb_y_i          : in  std_logic_vector(31 downto 0);
        -- fofb system heartbeat and event (go, stop) signals
        fofb_watchdog_i         : in  std_logic_vector(31 downto 0);     -- FOFB Watchdog
        fofb_event_i            : in  std_logic_vector(31 downto 0);     -- FOFB Go
        -- PMC-CPU DMA handshake interface
        fofb_dma_ok_i           : in std_logic;
        -- Received node mask (Not used in BPMs)
        fofb_node_mask_o        : out  std_logic_vector(NodeNum-1 downto 0);
        -- 2x PBPM position data interface
        pbpm_xpos_0_i           : in  std_logic_vector(31 downto 0);
        pbpm_ypos_0_i           : in  std_logic_vector(31 downto 0);
        pbpm_xpos_1_i           : in  std_logic_vector(31 downto 0);
        pbpm_ypos_1_i           : in  std_logic_vector(31 downto 0)
    );
end entity;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_fod is

------------------------------------------------------------------
--  Signal declarations
-------------------------------------------------------------------
signal pload_header                 : std_logic_vector(31 downto 0);
signal bpm_cnt                      : unsigned(7 downto 0);
signal timeframe_start_d1           : std_logic;
signal timeframe_start_d2           : std_logic;
signal bpm_xpos_val                 : std_logic_vector(31 downto 0);
signal bpm_ypos_val                 : std_logic_vector(31 downto 0);
-- input connections
signal fod_idat                     : std_logic_vector((PacketSize*32-1) downto 0);
-- position memory connections
signal time_stamp_cnt               : unsigned(15 downto 0);
signal fod_completed                : std_logic;
signal fod_completed_prev           : std_logic;
signal fod_idat_val                 : std_logic;
signal fod_odat                     : std_logic_vector((PacketSize*32-1) downto 0);
signal fod_odat_val                 : std_logic;

signal buffer_write_sw              : std_logic := '0';
signal buffer_read_sw               : std_logic := '1';
signal xpos_to_read                 : std_logic_vector(31 downto 0);
signal ypos_to_read                 : std_logic_vector(31 downto 0);
signal own_packet_to_inject         : std_logic_vector(127 downto 0);
signal own_xpos_to_store            : std_logic_vector(31 downto 0);
signal own_ypos_to_store            : std_logic_vector(31 downto 0);
signal own_packet_to_inject_1       : std_logic_vector(127 downto 0):= (others =>'0');
signal own_xpos_to_store_1          : std_logic_vector(31 downto 0):= (others => '0');
signal own_ypos_to_store_1          : std_logic_vector(31 downto 0):= (others => '0');
signal xpos_to_store                : std_logic_vector(31 downto 0);
signal ypos_to_store                : std_logic_vector(31 downto 0);
signal xy_buf_addr                  : std_logic_vector(NodeNumIndexWidth downto 0);
signal xy_buf_addr_prev             : std_logic_vector(NodeNumIndexWidth downto 0);
signal xy_buf_dout                  : std_logic_vector(63 downto 0);
signal fofb_nodemask                : std_logic_vector(NodeNum-1 downto 0):= (others => '0');
signal fofb_nodemask_sys            : std_logic_vector(NodeNum-1 downto 0):= (others => '0');
signal posmem_wea                   : std_logic;
signal posmem_addra                 : std_logic_vector(NodeNumIndexWidth downto 0);
signal posmem_addrb                 : std_logic_vector(NodeNumIndexWidth downto 0);
signal pbpm_xpos_0                  : std_logic_vector(31 downto 0);
signal pbpm_ypos_0                  : std_logic_vector(31 downto 0);
signal pbpm_xpos_1                  : std_logic_vector(31 downto 0);
signal pbpm_ypos_1                  : std_logic_vector(31 downto 0);
signal bpmid                        : std_logic_vector(9 downto 0);
signal bpmid_1                      : std_logic_vector(9 downto 0);
signal fod_id                       : std_logic_vector(NodeNumIndexWidth-1 downto 0);
signal fod_id_prev                  : std_logic_vector(NodeNumIndexWidth-1 downto 0);
signal fod_xpos                     : std_logic_vector(31 downto 0);
signal fod_ypos                     : std_logic_vector(31 downto 0);

signal fod_posmem_wea               : std_logic;
signal bpm_count_prev               : unsigned(7 downto 0);

signal maskmem_sw                   : std_logic;
signal maskmem_addra                : std_logic_vector(NodeNumIndexWidth-1
downto 0);
signal maskmem_addrb                : std_logic_vector(NodeNumIndexWidth-1
downto 0);
signal maskmem_dina                 : std_logic_vector(1 downto 0);
signal maskmem_doutb                : std_logic_vector(1 downto 0);
signal maskmem_wea                  : std_logic;
signal fod_ok_n                     : std_logic;
signal timeframe_end_sys            : std_logic;
signal fodid_repeat                 : std_logic;

begin

-- Outputs to top-level are already synced to SYS clock domain.
timeframe_end_rise_o <= timeframe_end_sys;
fofb_node_mask_o <= fofb_nodemask_sys;

-- Sniffer devide does not inject and forwards any packets to the network
fod_dat_o <= fod_odat;
fod_dat_val_o <= (others => '0') when (DEVICE = SNIFFER) else
                 (LaneCount-1 downto 0 => fod_odat_val) and  not txf_full_i and linksup_i;

-- Register input data when it is valid
-- Filters consecutive packets from the same ID
fodid_repeat <= '1' when (fod_dat_i(NodeNumIndexWidth+95 downto 96) =
                fod_id_prev) else '0';

process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i='1') then
        if (fod_dat_val_i = '1') then
             fod_id_prev <= fod_dat_i(NodeNumIndexWidth+95 downto 96);
        end if;

        fod_idat <= fod_dat_i;
        fod_idat_val <= fod_dat_val_i and not fodid_repeat;
    end if;
end process;

-- Extract information needed from incoming packet
fod_id <= fod_idat(NodeNumIndexWidth+95 downto 96);
fod_xpos <= fod_idat(95 downto 64);
fod_ypos <= fod_idat(63 downto 32);

--
-- Position data select
--
process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i='1') then
        if (pos_datsel_i = '0') then
            bpm_xpos_val <=  std_logic_vector(signed(bpm_x_pos_i) - signed(golden_orb_x_i));
            bpm_ypos_val <=  std_logic_vector(signed(bpm_y_pos_i) - signed(golden_orb_y_i));
            pbpm_xpos_0 <= pbpm_xpos_0_i;
            pbpm_ypos_0 <= pbpm_ypos_0_i;
            pbpm_xpos_1 <= pbpm_xpos_1_i;
            pbpm_ypos_1 <= pbpm_ypos_1_i;
        else
            -- Inject synth. pos data for debugging
            bpm_xpos_val <= timeframe_cntr_i;
            bpm_ypos_val <= timeframe_cntr_i;
            pbpm_xpos_0 <= timeframe_cntr_i;
            pbpm_ypos_0 <= timeframe_cntr_i;
            pbpm_xpos_1 <= timeframe_cntr_i;
            pbpm_ypos_1 <= timeframe_cntr_i;
        end if;
    end if;
end process;

--
-- BPM/PMC Header Data (32 bits)
-- When DEVICE=BPM, a time frame start bit is placed onto
-- payload header bit15
--
bpmid <= bpmid_i;
bpmid_1 <= std_logic_vector(unsigned(bpmid_i) + 1);

pload_header(9 downto 0) <= bpmid when (timeframe_start_d1 = '1') else bpmid_1;
pload_header(14 downto 10) <= "00000";
pload_header(15) <= '1' when (DEVICE = BPM) else '0';
pload_header(31 downto 16) <= timeframe_cntr_i(15 downto 0);

--
-- Device dependent compile-time assignments
--  1/ own data packet (4 x 32-bit words)
--  2/ positions to store for processing
--
process(timeframe_cntr_i, bpm_ypos_val, bpm_xpos_val, pload_header, fofb_watchdog_i, fofb_event_i,timestamp_val_i, pbpm_xpos_0, pbpm_ypos_0, pbpm_xpos_1, pbpm_ypos_1)
begin
    case DEVICE is
        when BPM =>
            own_packet_to_inject <= pload_header & bpm_xpos_val & bpm_ypos_val & timeframe_cntr_i;
            own_xpos_to_store   <= bpm_xpos_val;
            own_ypos_to_store   <= bpm_ypos_val;
        when PMC =>
            own_packet_to_inject <= pload_header & fofb_watchdog_i & fofb_event_i & timeframe_cntr_i;
            own_xpos_to_store   <= fofb_watchdog_i;
            own_ypos_to_store   <= fofb_event_i;
        when PMCEVR =>
            own_packet_to_inject <= pload_header & fofb_watchdog_i & fofb_event_i & timeframe_cntr_i;
            own_xpos_to_store   <= fofb_watchdog_i;
            own_ypos_to_store   <= fofb_event_i;
        when SNIFFER =>
            own_packet_to_inject <= pload_header & X"00000000" & X"00000000" & timeframe_cntr_i;
            own_xpos_to_store   <= timestamp_val_i;
            own_ypos_to_store   <= timestamp_val_i;
        when PBPM =>
            own_packet_to_inject <= pload_header & pbpm_xpos_0 & pbpm_ypos_0 & timeframe_cntr_i;
            own_xpos_to_store   <= pbpm_xpos_0;
            own_ypos_to_store   <= pbpm_ypos_0;

            own_packet_to_inject_1 <= pload_header & pbpm_xpos_1 & pbpm_ypos_1 & timeframe_cntr_i;
            own_xpos_to_store_1   <= pbpm_xpos_1;
            own_ypos_to_store_1   <= pbpm_ypos_1;
        when others =>
    end case;
end process;

--
--  Forward or Discard state machine
--  Arbiter blocks incoming data outside the timeframe
--
FodMaskMem : entity work.fofb_cc_sdpbram
generic map (
    AW          => NodeNumIndexWidth,
    DW          => 2
)
port map (
    addra       => maskmem_addra,
    addrb       => maskmem_addrb,
    clka        => mgtclk_i,
    clkb        => mgtclk_i,
    dina        => maskmem_dina,
    doutb       => maskmem_doutb,
    wea         => maskmem_wea
);

-- Writing and clearing takes place at the same time
maskmem_addra <= posmem_addra(NodeNumIndexWidth-1 downto 0);
maskmem_addrb <= fod_dat_i(NodeNumIndexWidth+95 downto 96);
maskmem_dina <= "01" when (maskmem_sw = '0') else "10";
maskmem_wea   <= posmem_wea;

fod_ok_n <= maskmem_doutb(0) when (maskmem_sw = '0') else maskmem_doutb(1);

FodProcess : process(mgtclk_i)
begin
if (mgtclk_i'event and mgtclk_i = '1') then
    if (mgtreset_i = '1') then
        fod_odat <= (others => '0');
        fod_odat_val <= '0';
        xpos_to_store <= (others => '0');
        ypos_to_store <= (others => '0');
        bpm_cnt <= (others => '0');
        maskmem_sw <= '0';
        posmem_addra <= (others => '0');
        posmem_wea <= '0';
    else
        timeframe_start_d1 <= timeframe_start_i;
        timeframe_start_d2 <= timeframe_start_d1;

        if (timeframe_end_i = '1') then
            maskmem_sw <= not maskmem_sw;
        end if;

        if (timeframe_start_i = '1') then
            bpm_cnt <= (others => '0');
            fofb_nodemask <= (others => '0');
        elsif (timeframe_start_d1 = '1') then
            -- 1./ Output data
            fod_odat <= own_packet_to_inject;
            fod_odat_val <= '1';
            -- 2./ Position data to store
            xpos_to_store <= own_xpos_to_store;
            ypos_to_store <= own_ypos_to_store;
            -- 3./ Position memory control signals
            posmem_addra <= buffer_write_sw & bpmid(NodeNumIndexWidth-1 downto 0);
            posmem_wea <= '1';
            --
            fofb_nodemask(to_integer(unsigned(bpmid(NodeNumIndexWidth-1 downto 0)))) <= '1';
            --
            bpm_cnt <= bpm_cnt + 1;
        elsif (timeframe_start_d2 = '1' and DEVICE = PBPM) then
            fod_odat <= own_packet_to_inject_1;
            fod_odat_val <= '1';
            xpos_to_store <= own_xpos_to_store_1;
            ypos_to_store <= own_ypos_to_store_1;
            posmem_addra <= buffer_write_sw & bpmid_1(NodeNumIndexWidth-1 downto 0);
            posmem_wea <= '1';
            fofb_nodemask(to_integer(unsigned(bpmid_1(NodeNumIndexWidth-1 downto 0)))) <= '1';
            bpm_cnt <= bpm_cnt + 1;
        elsif (fod_idat_val = '1') then
            fod_odat <= fod_idat(127 downto 112)
                         & '0'
                         & fod_idat(110 downto 0);
            xpos_to_store <= fod_xpos;
            ypos_to_store <= fod_ypos;

            posmem_addra <= buffer_write_sw & fod_id;

            -- Forward only once
            if (fod_ok_n = '0') then
                fod_odat_val <= '1';
                posmem_wea <= '1';
                bpm_cnt <= bpm_cnt + 1;
                fofb_nodemask(to_integer(unsigned(fod_id(NodeNumIndexWidth-1 downto 0)))) <= '1';
            end if;

        else
            fod_odat_val <= '0';
            posmem_wea <= '0';
        end if;
    end if;
end if;
end process;

-------------------------------------------------------------------
-- SYS Clock Domain:
--      At the end of each time frame, switch for writing is toggled
--      in mgtclk_i domain (if previoud dma is completed succesfully).
--      timeframe_end signal is synced to sysclk, and then used
--      to switch reading.
--      timeframe_end_sys is also used to generate IRQ on the
--      PMC.
-------------------------------------------------------------------
fofb_cc_p2p_inst : entity work.fofb_cc_p2p
port map (
    in_clk              => mgtclk_i,
    out_clk             => sysclk_i,
    rst                 => '0',
    pulsein             => timeframe_end_i,
    inbusy              => open,
    pulseout            => timeframe_end_sys
);

process(sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        -- buffer_read_sw is used to switch double buffers for DMA to PMC.
        if (timeframe_end_sys = '1' and fofb_dma_ok_i = '1') then
            buffer_write_sw <= not buffer_write_sw;
            buffer_read_sw  <= not buffer_read_sw;
        end if;

        if (timeframe_end_sys = '1' and fofb_dma_ok_i = '1') then
            fofb_nodemask_sys <= fofb_nodemask;
        end if;
    end if;
end process;

-------------------------------------------------
-- Double Buffering for FoD control
-- buffer_write_sw = '0'    => Lower is used
-- buffer_write_sw = '1'    => Upper is used
-------------------------------------------------
posmem_addrb <= buffer_read_sw & xy_buf_addr(NodeNumIndexWidth-1 downto 0);

XPosMem : entity work.fofb_cc_sdpbram
    generic map (
        AW          => (NodeNumIndexWidth+1),
        DW          => 32
    )
    port map (
        addra       => posmem_addra,
        addrb       => posmem_addrb,
        clka        => mgtclk_i,
        clkb        => sysclk_i,
        dina        => xpos_to_store,
        doutb       => xpos_to_read,
        wea         => posmem_wea
    );

YPosMem : entity work.fofb_cc_sdpbram
    generic map (
        AW          => (NodeNumIndexWidth+1),
        DW          => 32
    )
    port map (
        addra       => posmem_addra,
        addrb       => posmem_addrb,
        clka        => mgtclk_i,
        clkb        => sysclk_i,
        dina        => ypos_to_store,
        doutb       => ypos_to_read,
        wea         => posmem_wea
    );

---------------------------------------------------------------------
-- Following Generate statements handle Parallel or Serial
-- x&y position data read to PMC or PCI-E.
---------------------------------------------------------------------
process(sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        xy_buf_addr_prev <= xy_buf_addr;
    end if;
end process; 

-- PMC DMA engine has 32-bit data interface
-- PMC transfers only frist 256-node's data
-- This requires following address mapping
-- sys_addr[8:7]---buf_addr[8:7]
--    00        -->   00
--    01        -->   10
--
GEN_POS_DAQ_SERIAL : if (DEVICE /= SNIFFER) generate
    dma_access: process(xy_buf_addr_i, xpos_to_read, ypos_to_read, fofb_nodemask_sys, xy_buf_addr_prev)
        variable  xy_buf_read_ptr : integer range 0 to NodeNum-1;
    begin

        -- Read only first 256-nodes
        xy_buf_addr <= "00" & xy_buf_addr_i(7 downto 0);

        xy_buf_read_ptr := to_integer(unsigned(xy_buf_addr_prev(NodeNumIndexWidth-1 downto 0)));

        if (xy_buf_addr_i(NodeNumIndexWidth-1) = '0') then
            xy_buf_dout <= X"00000000" & xpos_to_read;
        else
            xy_buf_dout <= X"00000000" & ypos_to_read;
        end if;

        if (fofb_nodemask_sys(xy_buf_read_ptr) = '1' ) then
            xy_buf_dout_o <= xy_buf_dout;
        else
            xy_buf_dout_o <= (others => '0');
        end if;

    end process;

end generate;

-- PCI-E DMA engine has 64-bit data interface.
GEN_POS_DAQ_PARALLEL : if (DEVICE = SNIFFER) generate
    dma_access: process(xpos_to_read, ypos_to_read, fofb_nodemask_sys, xy_buf_addr_prev)
        variable xy_buf_read_ptr : integer range 0 to NodeNum-1;
    begin

        xy_buf_addr <= xy_buf_addr_i;

        xy_buf_read_ptr := to_integer(unsigned(xy_buf_addr_prev(NodeNumIndexWidth-1 downto 0)));

        if (fofb_nodemask_sys(xy_buf_read_ptr) = '1' ) then
            xy_buf_dout_o <= ypos_to_read & xpos_to_read;
        else
            xy_buf_dout_o <= (others => '0');
        end if;
    end process;

end generate;

---------------------------------------------------------------------
--  Time Stamp Counter
---------------------------------------------------------------------
process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i = '1') then
        if (mgtreset_i = '1') then
            time_stamp_cnt <= (others => '0');
        else
            if (timeframe_start_i = '1') then
                time_stamp_cnt <= (others => '0');
            else
                time_stamp_cnt <= time_stamp_cnt + 1;
            end if;
        end if;
    end if;
end process;

---------------------------------------------------------------------
-- Fod process is finished in the TimeFrame
---------------------------------------------------------------------
bpm_count_o <= std_logic_vector(bpm_count_prev);

FodCompletedGen: process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i = '1') then
        if (mgtreset_i = '1') then
            fodprocess_time_o <= (others => '0');
            bpm_count_prev <= X"01";
            fod_completed <= '0';
            fod_completed_prev <= '0';
        else
            -- Update bpm_count_o in each time frame
            if (timeframe_end_i = '1') then
                bpm_count_prev <= bpm_cnt;
            end if;

            -- fod process finished
            if (timeframe_start_i = '1') then
                fod_completed <= '0';
            elsif (bpm_cnt = bpm_count_prev and timeframe_valid_i = '1') then
                fod_completed <= '1';
            elsif (fod_completed = '0' and timeframe_end_i = '1') then
                fod_completed <= '1';
            end if;

            -- Latch current fod time
            fod_completed_prev <= fod_completed;
            if ((fod_completed and not fod_completed_prev) = '1') then
                fodprocess_time_o  <= std_logic_vector(time_stamp_cnt);
            end if;

        end if;
    end if;
end process;

end rtl;
