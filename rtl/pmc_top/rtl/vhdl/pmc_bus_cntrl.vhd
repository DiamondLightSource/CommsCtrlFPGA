----------------------------------------------------------------------------
--  Project      : Diamond Communication Controller
--  Filename     : bus_cntrl.vhd
--  Purpose      : CC PMC bus interface module
--  Responsible  : Isa Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: CC PMC bus PCI local interface logic.
--  PCI interface is handled by PLX9030 device.
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug  
--  reports to isa.uzun@diamond.ac.uk.
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.fofb_cc_pkg.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity pmc_bus_cntrl is
    port (
        -- Reset Interface
        sysclk_i                : in  std_logic;
        sysreset_i              : in  std_logic;
        -- PMC Local Bus Interface
        cs_n_i                  : in  std_logic_vector(1 downto 0);
        lint_o                  : out std_logic_vector(2 downto 1);
        wr_n_i                  : in  std_logic;
        rd_n_i                  : in  std_logic;
        ads_n_i                 : in  std_logic;
        lad_io                  : inout std_logic_vector(31 downto 0);
        -- I/O connector pins
        pmc_connector_io        : inout std_logic_vector(31 downto 0);  
        -- PMC data transfer lines & time frame 
        xy_pos_buf_addr_o       : out std_logic_vector(9 downto 0);
        xy_pos_buf_dat_i        : in  std_logic_vector(31 downto 0);
        timeframe_end_rise_i    : in  std_logic;
        -- FOFB Communication Controller Configuration Interface
        fai_cfg_a_i             : in  std_logic_vector(10 downto 0);
        fai_cfg_do_o            : out std_logic_vector(31 downto 0);
        fai_cfg_di_i            : in  std_logic_vector(31 downto 0); 
        fai_cfg_we_i            : in  std_logic;
        fai_cfg_clk_i           : in  std_logic;
        fai_cfg_val_o           : out std_logic_vector(31 downto 0);
        -- PMC-CPU handshake & monitor interface
        fofb_watchdog_o         : out std_logic_vector(31 downto 0);
        fofb_event_o            : out std_logic_vector(31 downto 0);
        fofb_process_time_i     : in  std_logic_vector(15 downto 0);
        fofb_bpm_count_i        : in  std_logic_vector(7 downto 0);
        fofb_dma_ok_o           : out std_logic;
        fofb_node_mask_i        : in  std_logic_vector(NodeNum-1 downto 0);
        fofb_timestamp_val_i    : in  std_logic_vector(31 downto 0)
    );
end pmc_bus_cntrl;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of pmc_bus_cntrl is

-----------------------------------------------
-- Component declaration
-----------------------------------------------
component IOBUF
port (
    O : out STD_ULOGIC;
    IO : inout STD_ULOGIC;
    I : in STD_ULOGIC;
    T : in STD_ULOGIC
);
end component; 

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal ip_addr                  : std_logic_vector(31 downto 0);
signal ip_data_in               : std_logic_vector(31 downto 0);
signal ip_data_out              : std_logic_vector(31 downto 0);
signal dma_data_out             : std_logic_vector(31 downto 0);
signal xy_pos_buf_addr          : unsigned(9 downto 0);
signal irq_ena                  : std_logic;
signal irq_flag                 : std_logic;
signal irq_flag_clear           : std_logic;
signal fai_cfg_val              : std_logic_vector(31 downto 0);
signal fai_cfg_val_ctrl         : std_logic;
signal cfg_bram_addra           : std_logic_VECTOR(10 downto 0);
signal cfg_bram_data_out        : std_logic_VECTOR(31 downto 0);
signal cfg_bram_we              : std_logic;
signal missed_dma_cnt           : unsigned(3 downto 0);
signal fofb_dma_ok              : std_logic := '1';
signal dma_ok_flag_clear        : std_logic;
signal fofb_watchdog_cnt        : unsigned(31 downto 0);
signal fofb_watchdog_cnt_ctrl   : std_logic;
signal fofb_watchdog_val        : std_logic_vector(31 downto 0);
signal fofb_watchdog_wren       : std_logic;
signal fofb_event_val           : std_logic_vector(31 downto 0);
signal fofb_event_val_ctrl      : std_logic;
signal missed_cnt_rstb          : std_logic;
signal missed_cnt_rstb_prev     : std_logic;
signal lad_in                   : std_logic_vector(31 downto 0);
signal lad_out                  : std_logic_vector(31 downto 0);
signal lad_oe                   : std_logic;

begin

pmc_connector_io <= (others => '0');
fofb_dma_ok_o <= fofb_dma_ok;

---------------------------------------------------------------
-- Local Bus Interface
---------------------------------------------------------------
lad_oe <= rd_n_i;


lad_io_gen : for N in 0 to 31 generate
i_lad_iobuf : IOBUF
port map (
    O =>  lad_in(N),
    IO => lad_io(N),
    I =>  lad_out(N),
    T =>  lad_oe
);
end generate;

local_bus_access : process (sysclk_i)
    variable wr              : std_logic := '0';
    variable rd              : std_logic := '0';
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            lad_out <= (others => '0');
            ip_addr <= (others => '0');
            ip_data_in <= (others => '0');
        else
            -- Latch address during Read/Write cycle start
            if (ads_n_i = '0' and cs_n_i(0) = '0') then
                ip_addr <= lad_in;
            end if;

            -- Latch data input on Write cycle
            if (wr_n_i = '0') then
                ip_data_in <= lad_in;
            end if;

            -- Read access Multiplexer from PMC
            if (rd_n_i = '0') then
                if (cs_n_i(0) = '0') then  -- BAR2
                    if (ip_addr(12) = '0') then
                        lad_out <= ip_data_out;
                    else
                        lad_out <= cfg_bram_data_out;
                    end if;
                end if;

                if cs_n_i(1) = '0' then    -- BAR3
                    lad_out <= dma_data_out;
                end if;
            end if;
        end if;
    end if;
end process;

------------------------------------------------
-- Position BRAM accesson BAR3
------------------------------------------------
XYPosRam_access : process(sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        -- Load beginning address, and increment for busrt transfers
        if (ads_n_i = '0' and cs_n_i(1) = '0') then
            xy_pos_buf_addr <= unsigned(lad_in(11 downto 2));
        else
            xy_pos_buf_addr <= xy_pos_buf_addr + 1;
        end if;
    end if;
end process;

--
-- Position data and addr interface
--
xy_pos_buf_addr_o <= std_logic_vector(xy_pos_buf_addr);
dma_data_out <= xy_pos_buf_dat_i;

------------------------------------------------
-- READ access on BAR2
------------------------------------------------
bar2_read_access : process (sysclk_i)
    variable data_rd         : std_logic_vector(31 downto 0);
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            ip_data_out <= (others => '0');
        else
            data_rd := (others => '0');
            ip_data_out <= data_rd;

            -- Data read multiplexer
            case ip_addr(6 downto 2) is
                when "00010" =>
                    data_rd     := X"0000" & fofb_process_time_i;
                when "00011" =>
                    data_rd     := X"000000" & fofb_bpm_count_i;
                when "00100" =>
                    data_rd     := fofb_watchdog_val;
                when "00101" =>
                    data_rd     := fofb_event_val;
                when "00110" =>
                    data_rd     := X"0000000" & std_logic_vector(missed_dma_cnt);
                when "00111" =>
                    data_rd     := fofb_timestamp_val_i;
                when "01000" =>
                    data_rd(1)  := irq_ena;
                    data_rd(0)  := irq_flag;
                --
                when "01001" => 
                    data_rd     := fofb_node_mask_i(31 downto 0);
                when "01010" => 
                    data_rd     := fofb_node_mask_i(63 downto 32);
                when "01011" => 
                    data_rd     := fofb_node_mask_i(95 downto 64);
                when "01100" => 
                    data_rd     := fofb_node_mask_i(127 downto 96);
                when "01101" => 
                    data_rd     := fofb_node_mask_i(159 downto 128);
                when "01110" => 
                    data_rd     := fofb_node_mask_i(191 downto 160);
                when "01111" => 
                    data_rd     := fofb_node_mask_i(223 downto 192);
                when "10000" => 
                    data_rd     := fofb_node_mask_i(255 downto 224);

                when others  =>
                    data_rd     := X"00000000";
            end case;
        end if;
    end if;
end process;


-----------------------------------------------------
-- WRITE access on BAR2
-- Address space on BAR2 is divided into 2 regions
-----------------------------------------------------
bar2_write_access : process (sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            irq_ena <= '0';
            fofb_watchdog_val <= X"00000005";
            fofb_event_val <= (others => '0');
            fofb_event_val_ctrl <= '0';
            irq_flag_clear <= '0';
            fofb_watchdog_wren <= '0';
            fai_cfg_val <= (others => '0');
            fai_cfg_val_ctrl <= '0';
            cfg_bram_we <= '0';
        else
            --
            -- Write Access to the Register Space on BAR2
            --
            irq_flag_clear <= '0';
            fofb_watchdog_wren <= '0';

            if (wr_n_i = '0' and cs_n_i(0) = '0' and ip_addr(12) = '0') then
                -- CC Config Register
                if (ip_addr(6 downto 2) = "00001") then
                    fai_cfg_val <= ip_data_in;
                    fai_cfg_val_ctrl <= not fai_cfg_val_ctrl;
                end if;
                -- FOFB watchdog counter
                if (ip_addr(6 downto 2) = "00100") then
                    fofb_watchdog_val <= ip_data_in;
                    fofb_watchdog_wren <= '1';
                end if;
                -- FOFB Event
                if (ip_addr(6 downto 2) = "00101") then
                    fofb_event_val <= ip_data_in;
                    fofb_event_val_ctrl <= not fofb_event_val_ctrl;
                end if;
                -- IRQ enable and clear flag from console
                if (ip_addr(6 downto 2) = "01000") then
                    irq_ena <= ip_data_in(1);
                    irq_flag_clear <= ip_data_in(0);
                end if;
            end if;

            --
            -- Write Access to the Config BRAM on BAR2
            --
            cfg_bram_we <= '0';
            if (wr_n_i = '0' and cs_n_i(0) = '0' and ip_addr(12) = '1') then
                cfg_bram_we <= not wr_n_i;
            end if;
        end if;
    end if;
end process;

--
-- DMux synchronisers for signals going to fofb_cc_top
--
fofb_cc_syncdmux0 : entity work.fofb_cc_syncdmux
port map (
    clk_i   => fai_cfg_clk_i,
    dat_i   => std_logic_vector(fofb_watchdog_cnt),
    ctrl_i  => fofb_watchdog_cnt_ctrl,
    dat_o   => fofb_watchdog_o
);

fofb_cc_syncdmux1 : entity work.fofb_cc_syncdmux
port map (
    clk_i   => fai_cfg_clk_i,
    dat_i   => fofb_event_val,
    ctrl_i  => fofb_event_val_ctrl,
    dat_o   => fofb_event_o
);

fofb_cc_syncdmux2 : entity work.fofb_cc_syncdmux
port map (
    clk_i   => fai_cfg_clk_i,
    dat_i   => fai_cfg_val,
    ctrl_i  => fai_cfg_val_ctrl,
    dat_o   => fai_cfg_val_o
);

-----------------------------------------------------------------
-- Rising edge triggers IRQ flag if DMA ok flag is set by CPU.
-- IRQ clear flag is set by CPU in interrupt handler
-----------------------------------------------------------------
interrupt: process (sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            irq_flag <= '0';
        else
            if (irq_ena = '1') then
                if (timeframe_end_rise_i = '1' and fofb_dma_ok = '1') then
                    irq_flag <= '1';
                elsif (irq_flag_clear = '1') then
                    irq_flag <= '0';
                end if;
            else
                irq_flag <= '0';
            end if;
        end if;
    end if;
end process; 

lint_o(1) <= irq_flag;   -- INTA on PCI
lint_o(2) <= '0';        -- not used

------------------------------------------------
-- Missed counter reading by the CPU, also clears
-- DMA ok flag. Missed counter has to be read after
-- completing the DMA transfer by CPU.
------------------------------------------------
dma_ok_flag_clear <= missed_cnt_rstb and not missed_cnt_rstb_prev;

process (sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            missed_cnt_rstb <= '0';
            missed_cnt_rstb_prev <= '0';
        else
            if (irq_ena = '1') then
                missed_cnt_rstb_prev <= missed_cnt_rstb;

                if (rd_n_i = '0' and cs_n_i(0) = '0' and ip_addr(12) = '0' and 
                            ip_addr(6 downto 2) = "00110") then
                    missed_cnt_rstb <= '1';
                else
                    missed_cnt_rstb <= '0';
                end if;
            else
                missed_cnt_rstb_prev <= '0';
                missed_cnt_rstb <= '0';
            end if;

        end if;
    end if;
end process;

------------------------------------------------
-- DMA handshaking
-- dma_ok flag indicates that CPU is ready to receive
-- an interrupt. This signal is also used in fofb_cc_fod
-- module to switch double buffers
------------------------------------------------
process(sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            fofb_dma_ok   <= '1';
        else
            if (irq_ena = '1') then
                -- Here is the tricky part. If dma_ok_clear, and timeframe_end_rise_i
                -- signals arrive on the same clock cycle, dma_clear has priorty.
                if (dma_ok_flag_clear = '1') then
                    fofb_dma_ok   <= '1';
                elsif (timeframe_end_rise_i = '1') then
                    fofb_dma_ok   <= '0';
                end if;
            else
                fofb_dma_ok <= '1';
            end if;
        end if;
    end if;
end process;

process(sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            missed_dma_cnt  <= (others => '0');
        else
            if (irq_ena = '1') then
                -- This takes care of missed counter when dma_ok_clear, and timeframe_end_rise_i signals arrive on the same clock cycle. It sets missed counter to 1, rather than0, because dma_clear_flag has overrides timeframe_end_rise_i signal
                if (timeframe_end_rise_i = '1' and fofb_dma_ok = '0') then
                    if (dma_ok_flag_clear = '1') then
                        missed_dma_cnt <= "0001";
                    else
                        missed_dma_cnt  <= missed_dma_cnt + 1;
                    end if;
                elsif (dma_ok_flag_clear = '1') then
                    missed_dma_cnt  <= (others => '0');
                end if;
            else
                missed_dma_cnt <= (others => '0');
            end if;
        end if;
    end if;
end process;

------------------------------------------------
-- DMA Watchdog counter
------------------------------------------------
process (sysclk_i)
begin
    if (sysclk_i'event and sysclk_i = '1') then
        if (sysreset_i = '1') then
            fofb_watchdog_cnt <= (others => '0');
            fofb_watchdog_cnt_ctrl <= '0';
        else
            if (irq_ena = '1') then
                if (fofb_watchdog_wren = '1') then
                    fofb_watchdog_cnt <= unsigned(fofb_watchdog_val);
                    fofb_watchdog_cnt_ctrl <= not fofb_watchdog_cnt_ctrl;
                elsif (fofb_watchdog_cnt /= X"00000000" and timeframe_end_rise_i = '1') then
                    fofb_watchdog_cnt <= fofb_watchdog_cnt - 1;
                    fofb_watchdog_cnt_ctrl <= not fofb_watchdog_cnt_ctrl;
                end if;
            else
                fofb_watchdog_cnt <= X"00000005";
                fofb_watchdog_cnt_ctrl <= not fofb_watchdog_cnt_ctrl;
            end if;
        end if;
    end if;
end process;

-------------------------------------------------------------
--PMC Configuration BRAM Access
-------------------------------------------------------------
cfg_bram_addra <='0' & ip_addr(11 downto 2);    -- 1K of it is used

i_fofb_cc_cfg_bram : entity work.fofb_cc_dpbram
    generic map (
        AW          => 11,
        DW          => 32
    )
    port map (
        addra       => cfg_bram_addra,
        addrb       => fai_cfg_a_i,
        clka        => sysclk_i,
        clkb        => fai_cfg_clk_i,
        dina        => ip_data_in,
        dinb        => fai_cfg_di_i,
        douta       => cfg_bram_data_out,
        doutb       => fai_cfg_do_o,
        wea         => cfg_bram_we,
        web         => fai_cfg_we_i
    );


--
-- Chipscope interface
--
--icon : icon
--port map (
--    control0    => control0
--);
--
--ila : ila
--port map (
--    control     => control0,
--    clk         => sysclk_i,
--    trig0       => trig0,
--    data        => data
--);
--
--trig0(0)            <= ads_n_i;
--trig0(1)            <= cs_n_i(0);
--trig0(2)            <= wr_n_i;
--trig0(7 downto 3)   <= (others => '0');
--
--data(0)             <= ads_n_i;
--data(1)             <= cs_n_i(0);
--data(2)             <= cs_n_i(1);
--data(3)             <= wr_n_i;
--data(4)             <= ip_addr(12);
--data(5)             <= cfg_bram_we;
--data(9 downto 6)    <= (others => '0');
--data(10)            <= rd_n_i;
--data(14 downto 11)  <= lbe_n_i;
--data(15)            <= fofb_event_val_ctrl;
--data(20 downto 16)  <= ip_addr(6 downto 2);
--data(255 downto 21) <= (others => '0');

end rtl;
