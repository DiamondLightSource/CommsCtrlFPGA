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
        DEVICE                  : device_t := PMC;
        LaneCount               : integer  := 4
    );
    port (
        mgtclk_i                : in  std_logic;
        sysclk_i                : in  std_logic;
        mgtreset_i              : in  std_logic; 
        -- Frame start (1cc long)
        timeframe_start_i       : in  std_logic;
        -- Channel up between channels
        linksup_i               : in  std_logic_vector(LaneCount-1 downto 0);
        -- Incoming data for arbmux to be Forwarded or Discarded
        fod_dat_i               : in  std_logic_vector((PacketSize*32-1) downto 0);
        fod_dat_val_i           : in  std_logic;
        -- Injected or Forwarded Data
        fod_dat_o               : out std_logic_vector((PacketSize*32-1) downto 0);
        fod_dat_val_o           : out std_logic_vector(LaneCount-1 downto 0);
        -- Frame status data
        timeframe_val_i         : in  std_logic_vector(31 downto 0);
        timeframe_end_i         : in  std_logic;
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
        xy_buf_addr_i           : in  std_logic_vector(8 downto 0);
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
type fod_state_type is (fod_idle, fod_inject, fod_forward);
signal fod_state                    : fod_state_type;

signal pload_header                 : std_logic_vector(31 downto 0);
signal pload_header_1               : std_logic_vector(31 downto 0);
signal bpm_cnt                      : unsigned(7 downto 0);
signal timeframe_start_d1           : std_logic;
signal timeframe_start_d2           : std_logic;
signal bpm_xpos_val                 : std_logic_vector(31 downto 0);
signal bpm_ypos_val                 : std_logic_vector(31 downto 0);
-- input connections
signal fod_idat                     : std_logic_vector((PacketSize*32-1) downto 0);
-- position memory connections
signal time_stamp_cnt               : unsigned(15 downto 0);
signal timeframe_end_prev           : std_logic;
signal timeframe_end_rise           : std_logic;
signal fod_completed                : std_logic;
signal fod_completed_prev           : std_logic;
signal fod_idat_val                 : std_logic;
signal fod_odat_val                 : std_logic_vector(LaneCount-1 downto 0);

signal buffer_write_sw              : std_logic := '0';
signal buffer_read_sw               : std_logic := '1';
signal xpos_to_read                 : std_logic_vector(31 downto 0);
signal ypos_to_read                 : std_logic_vector(31 downto 0);
signal own_packet_to_inject         : std_logic_vector(127 downto 0);
signal own_xpos_to_store            : std_logic_vector(31 downto 0);
signal own_ypos_to_store            : std_logic_vector(31 downto 0);
signal xpos_to_store                : std_logic_vector(31 downto 0);
signal ypos_to_store                : std_logic_vector(31 downto 0);
signal timeframe_end_sys            : std_logic;
signal timeframe_end_sys_prev       : std_logic;
signal timeframe_end_sys_rise       : std_logic;
signal xy_buf_dout                  : std_logic_vector(63 downto 0);
signal xy_buf_addr_prev             : std_logic_vector(8 downto 0);
signal fofb_nodemask_buffer         : std_logic_vector(NodeNum-1 downto 0);
signal fofb_nodemask_ctrl           : std_logic;
signal posmem_wea                   : std_logic;
signal posmem_addra                 : std_logic_vector(8 downto 0);
signal posmem_addrb                 : std_logic_vector(8 downto 0);
signal pbpm_xpos_0                  : std_logic_vector(31 downto 0);
signal pbpm_ypos_0                  : std_logic_vector(31 downto 0);
signal pbpm_xpos_1                  : std_logic_vector(31 downto 0);
signal pbpm_ypos_1                  : std_logic_vector(31 downto 0);
signal fofb_nodemask_buffer_synced  : std_logic_vector(NodeNum-1 downto 0);
signal bpmid                        : std_logic_vector(9 downto 0);
signal bpmid_1                      : std_logic_vector(9 downto 0);
signal own_id                       : std_logic_vector(NodeNumIndexWidth-1 downto 0);
signal fod_id                       : std_logic_vector(NodeNumIndexWidth-1 downto 0);
signal fod_xpos                     : std_logic_vector(31 downto 0);
signal fod_ypos                     : std_logic_vector(31 downto 0);

signal fod_posmem_wea               : std_logic;
signal bpm_count_prev               : unsigned(7 downto 0);

begin

-- Outputs to top-level are already synced to SYS clock domain.
timeframe_end_rise_o <= timeframe_end_sys_rise;
fofb_node_mask_o <= fofb_nodemask_buffer_synced;

-- Sniffer devide does not inject and forwards any packets to the network
fod_dat_val_o <= fod_odat_val;
--fod_dat_val_o <= fod_odat_val when (DEVICE /= SNIFFER_V5) else (others => '0');

-- Latch input data when it is valid
process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i='1') then
        if (mgtreset_i = '1') then
            fod_idat <= (others => '0');
            fod_idat_val <= '0';
        else
            if (fod_dat_val_i = '1') then
                fod_idat <= fod_dat_i;
            end if;
            fod_idat_val <= fod_dat_val_i;
        end if;
    end if;
end process;

-- Extract information needed from incoming packet
fod_id <= fod_idat(NodeNumIndexWidth+95 downto 96);
fod_xpos <= fod_idat(95 downto 64);
fod_ypos <= fod_idat(63 downto 32);

--
-- Data output from FOD module
-- Clear TimeFrameStart bit for forwarded packets
--
data_out_mux : process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i = '1') then
        if (mgtreset_i = '1') then
            fod_dat_o <= (others => '0');
        else
            -- Inject own data at the start of time frame
            if (fod_state = fod_idle or fod_state = fod_inject) then
                fod_dat_o <= own_packet_to_inject;
            -- Then, start forwarding incoming packets
            else
                fod_dat_o <= fod_idat(127 downto 112) & '0' & fod_idat(110 downto 0);
            end if;
        end if;
    end if;
end process;

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
            bpm_xpos_val <= timeframe_val_i;
            bpm_ypos_val <= timeframe_val_i;
            pbpm_xpos_0 <= timeframe_val_i;
            pbpm_ypos_0 <= timeframe_val_i;
            pbpm_xpos_1 <= timeframe_val_i;
            pbpm_ypos_1 <= timeframe_val_i;
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

own_id <= bpmid(NodeNumIndexWidth-1 downto 0) when (fod_state = fod_idle) else bpmid_1(NodeNumIndexWidth-1 downto 0);
pload_header(9 downto 0) <= bpmid when (fod_state = fod_idle) else bpmid_1;
pload_header(14 downto 10) <= "00000";
pload_header(15) <= '1' when (DEVICE = BPM) else '0';
pload_header(31 downto 16) <= timeframe_val_i(15 downto 0);

--
-- Device dependent compile-time assignments
--  1/ own data packet (4 x 32-bit words)
--  2/ positions to store for processing
--
process(timeframe_val_i, bpm_ypos_val, bpm_xpos_val, pload_header, fofb_watchdog_i, fofb_event_i,timestamp_val_i, pbpm_xpos_0, pbpm_ypos_0, pbpm_xpos_1, pbpm_ypos_1, pload_header_1)
begin
    case DEVICE is
        when BPM =>
            own_packet_to_inject <= pload_header & bpm_xpos_val & bpm_ypos_val & timeframe_val_i;
            own_xpos_to_store   <= bpm_xpos_val;
            own_ypos_to_store   <= bpm_ypos_val;
        when PMC =>
            own_packet_to_inject <= pload_header & fofb_watchdog_i & fofb_event_i & timeframe_val_i;
            own_xpos_to_store   <= fofb_watchdog_i;
            own_ypos_to_store   <= fofb_event_i;
        when SNIFFER_V5 =>
            own_packet_to_inject <= pload_header & X"00000000" & X"00000000" & timeframe_val_i;
            own_xpos_to_store   <= timestamp_val_i;
            own_ypos_to_store   <= timestamp_val_i;
        when SNIFFER_V6 =>
            own_packet_to_inject <= pload_header & X"00000000" & X"00000000" & timeframe_val_i;
            own_xpos_to_store   <= timestamp_val_i;
            own_ypos_to_store   <= timestamp_val_i;
        when PBPM =>
            if (fod_state = fod_idle) then
                own_packet_to_inject <= pload_header & pbpm_xpos_0 & pbpm_ypos_0 & timeframe_val_i;
                own_xpos_to_store   <= pbpm_xpos_0;
                own_ypos_to_store   <= pbpm_ypos_0;
            else
                own_packet_to_inject <= pload_header & pbpm_xpos_1 & pbpm_ypos_1 & timeframe_val_i;
                own_xpos_to_store   <= pbpm_xpos_1;
                own_ypos_to_store   <= pbpm_ypos_1;
            end if;
        when others =>
    end case;
end process;

--
--  Forward or Discard state machine
--

timeframe_end_rise  <= timeframe_end_i and not timeframe_end_prev;

FodProcess : process(mgtclk_i)
    variable AlreadySentBitArray_v  : std_logic_vector(NodeNum-1 downto 0);
begin
    if (mgtclk_i'event and mgtclk_i = '1') then
        if (mgtreset_i = '1') then
            fod_odat_val <= (others => '0');
            bpm_cnt <= (others => '0');
            fod_state <= fod_idle;
            timeframe_start_d1 <= '0';
            timeframe_start_d2 <= '0';
            fofb_nodemask_buffer <= (others => '0');
            AlreadySentBitArray_v := (others => '0');
            fofb_nodemask_ctrl <= '0';
            timeframe_end_prev <= '0';
            fod_posmem_wea <= '0';
        else
            -- controlled by time_out signal
            timeframe_end_prev <= timeframe_end_i;

            -- Delay start by 1 clock cycle for sync
            timeframe_start_d1 <= timeframe_start_i;
            timeframe_start_d2 <= timeframe_start_d1;

            case (fod_state) is
                when fod_idle   =>
                    fod_odat_val <= (others => '0');
                    fod_posmem_wea <= '0';
                    bpm_cnt <= (others => '0');

                    if (timeframe_start_d1 = '1') then
                        if (DEVICE = PBPM) then
                            fod_state <= fod_inject;
                        else
                            fod_state <= fod_forward;
                        end if;
                        bpm_cnt <= bpm_cnt + 1;
                        fod_odat_val <= (not txf_full_i and linksup_i);
                    end if;

                -- Second packet has to be injected in PBPM configuration
                when fod_inject =>
                    bpm_cnt <= bpm_cnt + 1;
                    fod_odat_val <= (not txf_full_i and linksup_i);
                    fod_state <= fod_forward;

                when fod_forward   =>
                    fod_odat_val <= (others => '0');
                    fod_posmem_wea <= '0';

                    if (timeframe_end_rise = '1') then
                        fod_state <= fod_idle;
                    elsif (fod_idat_val = '1') then
                        --Logic-based AlreadySentBitArray implementation
                        if (AlreadySentBitArray_v(to_integer(unsigned(fod_id))) = '0') then
                            fod_odat_val <= (not txf_full_i and linksup_i);
                            bpm_cnt <= bpm_cnt + 1;
                            fod_posmem_wea <= '1';
                        end if;
                        fod_state <= fod_forward;
                    end if;
                when others =>
            end case;

            -- Logic-based implementation of AlreadySentBitArray
            -- AlreadySentBitArray variable keeps track of BPM IDs where a packet
            -- is received from. It is cleared at the end of each time frame.
            if (fod_state = fod_idle) then
                if (timeframe_start_d1 = '1') then
                    AlreadySentBitArray_v(to_integer(unsigned(own_id))) := '1';
                else
                    AlreadySentBitArray_v := (others => '0');
                end if;
            elsif (fod_state = fod_inject) then
                AlreadySentBitArray_v(to_integer(unsigned(own_id))) := '1';
            else -- fod_state = fod_forward
                if (fod_idat_val = '1') then
                    AlreadySentBitArray_v(to_integer(unsigned(fod_id))) := '1';
                end if; 
            end if;

            -- It is also latched at the end of the time frame in PMC design, this
            -- information is used as a node mask in feedback processing. And toggle
            -- the control line
            if (fod_state = fod_forward and timeframe_end_rise = '1') then
                fofb_nodemask_buffer <= AlreadySentBitArray_v;
                fofb_nodemask_ctrl <= not fofb_nodemask_ctrl;
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
--      timeframe_end_sys_rise is also used to generate IRQ on the
--      PMC.
-------------------------------------------------------------------
i1_syncff : entity work.fofb_cc_syncff
port map (
    clk_i      => sysclk_i,
    dat_i      => timeframe_end_i,
    dat_o      => timeframe_end_sys
);

process(sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        timeframe_end_sys_prev  <= timeframe_end_sys;
        timeframe_end_sys_rise <= timeframe_end_sys and not timeframe_end_sys_prev;

        -- buffer_read_sw is used to switch double buffers for DMA to PMC.
        if (timeframe_end_sys_rise = '1' and fofb_dma_ok_i = '1') then
            buffer_write_sw <= not buffer_write_sw;
            buffer_read_sw  <= not buffer_read_sw;
        end if;
    end if;
end process;


xpos_to_store <= own_xpos_to_store when (fod_state = fod_idle or fod_state = fod_inject) else fod_xpos;

ypos_to_store <= own_ypos_to_store when (fod_state = fod_idle or fod_state = fod_inject) else fod_ypos;

posmem_addra <= buffer_write_sw & own_id when (fod_state = fod_idle or fod_state = fod_inject) else buffer_write_sw & fod_id;

posmem_wea <= (timeframe_start_d1 or timeframe_start_d1) when (fod_state = fod_idle or fod_state = fod_inject) else fod_posmem_wea;


-------------------------------------------------
-- Double Buffering for FoD control
-- buffer_write_sw = '0'    => Lower is used
-- buffer_write_sw = '1'    => Upper is used
-------------------------------------------------
posmem_addrb <= buffer_read_sw & xy_buf_addr_i(7 downto 0);

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
fofb_cc_syncdmux0 : entity work.fofb_cc_syncdmux
generic map (
    DW          => NodeNum
)
port map (
    clk_i       => sysclk_i,
    dat_i       => fofb_nodemask_buffer,
    ctrl_i      => fofb_nodemask_ctrl,
    dat_o       => fofb_nodemask_buffer_synced
);

process(sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        xy_buf_addr_prev <= xy_buf_addr_i;
    end if;
end process; 

-- PMC DMA engine has 32-bit data interface
GEN_POS_DAQ_SERIAL : if (DEVICE /= SNIFFER_V5) generate
    dma_access: process(xy_buf_addr_i, xpos_to_read, ypos_to_read, fofb_nodemask_buffer_synced, xy_buf_addr_prev)
        variable  xy_buf_read_ptr : integer range 0 to NodeNum-1;
    begin
        xy_buf_read_ptr := to_integer(unsigned(xy_buf_addr_prev(NodeNumIndexWidth-1 downto 0)));

        if (xy_buf_addr_i(8) = '0') then
            xy_buf_dout <= X"00000000" & xpos_to_read;
        else
            xy_buf_dout <= X"00000000" & ypos_to_read;
        end if;

        if (fofb_nodemask_buffer_synced(xy_buf_read_ptr) = '1' ) then
            xy_buf_dout_o <= xy_buf_dout;
        else
            xy_buf_dout_o <= (others => '0');
        end if;

    end process;

end generate;

-- PCI-E DMA engine has 64-bit data interface.
GEN_POS_DAQ_PARALLEL : if (DEVICE = SNIFFER_V5) generate
    dma_access: process(xpos_to_read, ypos_to_read, fofb_nodemask_buffer_synced, xy_buf_addr_prev)
        variable xy_buf_read_ptr : integer range 0 to NodeNum-1;
    begin
        xy_buf_read_ptr := to_integer(unsigned(xy_buf_addr_prev(NodeNumIndexWidth-1 downto 0)));

        if (fofb_nodemask_buffer_synced(xy_buf_read_ptr) = '1' ) then
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
            if (timeframe_end_rise = '1') then
                bpm_count_prev <= bpm_cnt;
            end if;

            -- fod process finished
            if (bpm_cnt = bpm_count_prev and timeframe_end_i = '0') then 
                fod_completed <= '1';
            elsif (timeframe_start_i = '1') then
                fod_completed <= '0';
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
