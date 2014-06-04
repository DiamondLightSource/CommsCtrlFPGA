----------------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     : fofb_cc_fa_if.vhd
--  Purpose      : FA rate data interface to Libera core
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: This module handles Fast Acquisition interface from Libera
--  core. An independent clock Bram is used for CDC. Data is written into Bram
--  at ADC clock rate and read by CC at mgt clock
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.fofb_cc_pkg.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_fa_if is
    generic (
        -- FA input data stream bit width
        BLK_DW                  : integer := 16;
        -- FA input data stream content
        BLK_SIZE                : integer := 16;
        -- Number of BPMS
        BPMS                    : integer := 1;
        -- FA stream Read/Write ratio
        DMUX                    : integer := 2
    );
    port (
        mgtclk_i                : in  std_logic;
        mgtreset_i              : in  std_logic;
        adcclk_i                : in  std_logic;
        adcreset_i              : in  std_logic;

        fa_block_start_i        : in  std_logic;
        fa_data_valid_i         : in  std_logic;
        fa_dat_i                : in  std_logic_vector(BLK_DW-1 downto 0);
        fa_psel_i               : in  std_logic_vector(31 downto 0);

        timeframe_start_o       : out std_logic;
        bpm_cc_xpos_o           : out std_logic_2d_32(BPMS-1 downto 0);
        bpm_cc_ypos_o           : out std_logic_2d_32(BPMS-1 downto 0)
    );
end fofb_cc_fa_if;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_fa_if is

constant WR_SIZE            : integer := BLK_SIZE * DMUX * BPMS;
constant WR_AW              : integer := integer(ceil(log2(real(WR_SIZE))));

constant RD_SIZE            : integer := WR_SIZE / DMUX;
constant RD_AW              : integer := integer(ceil(log2(real(RD_SIZE))));

constant BLK_AW             : integer := integer(ceil(log2(real(BLK_SIZE))));
-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal addra                : unsigned(WR_AW-1 downto 0);
signal addrb                : unsigned(RD_AW-1 downto 0);

signal read_addr            : unsigned(BLK_AW-1 downto 0);
signal doutb                : std_logic_vector(31 downto 0);
signal block_start          : std_logic;
signal block_start_prev     : std_logic;
signal block_start_fall     : std_logic;
signal addrb_cnt_en         : std_logic;

signal bpm_cc_xpos          : std_logic_2d_32(BPMS-1 downto 0);
signal bpm_cc_ypos          : std_logic_2d_32(BPMS-1 downto 0);

begin

---------------------------------------------------
-- FIFO is used to handle CDC between ADC clock rate
-- and CC clock rate.
---------------------------------------------------

-- Write Address Generator
process(adcclk_i)
begin
    if (adcclk_i'event and adcclk_i='1') then
        if (adcreset_i = '1') then
            addra <= (others => '0');
        else
            -- If incoming data, increment addr
            if (fa_data_valid_i = '1') then
                addra <= addra + 1;
            end if;
        end if; 
    end if;
end process;

i_fofb_cc_fa_if_bram: entity work.fofb_cc_fa_if_bram
generic map (
    WR_AW       => WR_AW,
    RD_AW       => RD_AW,
    DMUX        => DMUX
)
port map(
    addra       => std_logic_vector(addra),
    addrb       => std_logic_vector(addrb),
    ena         => '1',
    enb         => '1',
    clka        => adcclk_i,
    clkb        => mgtclk_i,
    dina        => fa_dat_i,
    doutb       => doutb,
    wea         => fa_data_valid_i
);

-- Falling edge of fa_block_start_i signals all data stream
-- is written into buffer, and reading out can start in FAI
-- clock domain.

-- 2DFF CDC for fa_block_start_i
i_block_start_syncff : entity work.fofb_cc_syncff
port map (
    clk_i      => mgtclk_i,
    dat_i      => fa_block_start_i,
    dat_o      => block_start
);

process(mgtclk_i)
begin
    if (mgtclk_i 'event and mgtclk_i = '1') then
        block_start_prev <= block_start;
        block_start_fall <= not block_start and block_start_prev;
    end if;
end process;


-- Fa Data Read is done in FAI clock domain
process(mgtclk_i)
    variable bpm_cnt    : integer range 0 to BPMS-1;
begin
if (mgtclk_i'event and mgtclk_i='1') then
    if (mgtreset_i = '1') then
        timeframe_start_o <= '0';
        bpm_cc_xpos <= (others => (others => '0'));
        bpm_cc_ypos <= (others => (others => '0'));
        bpm_cc_xpos_o <= (others => (others => '0'));
        bpm_cc_ypos_o <= (others => (others => '0'));
        addrb <= (others => '0');
        read_addr <= (others => '0');
        addrb_cnt_en <= '0';
    else
        -- Count until BLK_SIZE x BPMS
       if (block_start_fall = '1') then
            addrb_cnt_en <= '1';
        elsif (addrb = (addrb'range => '1')) then
            addrb_cnt_en <= '0';
        end if;

        if (addrb_cnt_en = '1') then
            addrb <= addrb + 1;
        end if;

        read_addr <= addrb(BLK_AW-1 downto 0);

        -- We need to keep track of BPM number within incoming
        -- FA datastream
        if (block_start_fall = '1') then
            bpm_cnt := 0;
        elsif (read_addr = (read_addr'range => '1') and bpm_cnt /= BPMS-1) then
            bpm_cnt := bpm_cnt + 1;
        end if;

        -- Read X-position for each BPM based on selected payload
        if (read_addr = unsigned(fa_psel_i(bpm_cnt*8+3 downto bpm_cnt*8))) then
            bpm_cc_xpos(bpm_cnt) <= doutb;
        end if;

        -- Read Y-position for each BPM based on selected payload
        if (read_addr = unsigned(fa_psel_i(bpm_cnt*8+7 downto bpm_cnt*8+4))) then
            bpm_cc_ypos(bpm_cnt) <= doutb;
        end if; 

        -- Own bpm position data is latched and can generate internal
        -- time frame pulse
        if (addrb = (addrb'range => '1')) then
            timeframe_start_o <= '1';
            bpm_cc_xpos_o <= bpm_cc_xpos;
            bpm_cc_ypos_o <= bpm_cc_ypos;
        else
            timeframe_start_o <= '0';
        end if;
    end if;
end if;
end process;

end rtl;
