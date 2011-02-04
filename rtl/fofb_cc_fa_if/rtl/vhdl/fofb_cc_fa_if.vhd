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

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_fa_if is
    port (
        mgtclk_i                : in  std_logic;
        adcclk_i                : in  std_logic;
        adcreset_i              : in  std_logic;
        mgtreset_i              : in  std_logic;
        fa_block_start_i        : in  std_logic;                     -- fa block start, 32 cc
        fa_data_valid_i         : in  std_logic;                     -- fa data valid
        fa_dat_i                : in  std_logic_vector(15 downto 0); -- fa data block
        fa_x_psel_i             : in  std_logic_vector(3 downto 0);  --
        fa_y_psel_i             : in  std_logic_vector(3 downto 0);  --
        timeframe_start_o       : out std_logic;                     -- frame start pulse
        bpm_cc_xpos_o           : out std_logic_vector(31 downto 0); -- x-pos payload
        bpm_cc_ypos_o           : out std_logic_vector(31 downto 0)  -- y-pos payload
    );
end fofb_cc_fa_if;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_fa_if is

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal fa_wea                   : std_logic;
signal fa_dat_prev              : std_logic_vector(15 downto 0);
signal addra                    : unsigned(4 downto 0);
signal addrb                    : unsigned(3 downto 0);
signal addrb_prev               : unsigned(3 downto 0);
signal doutb                    : std_logic_vector(31 downto 0);
signal block_start              : std_logic;
signal block_start_prev         : std_logic;
signal block_start_fall         : std_logic;
signal bpm_cc_xpos              : std_logic_vector(31 downto 0);
signal bpm_cc_ypos              : std_logic_vector(31 downto 0);
signal timeframe_start          : std_logic;
signal addrb_cnt_en             : std_logic;

begin

-- Register input data
process(adcclk_i)
begin
    if (adcclk_i'event and adcclk_i = '1') then
        fa_wea <= fa_data_valid_i and fa_block_start_i; -- Write enable to FIFO
        fa_dat_prev <= fa_dat_i;                     -- Write data to FIFO
    end if;
end process;

-- Register outputs
process(mgtclk_i)
begin
    if (mgtclk_i 'event and mgtclk_i = '1') then
        bpm_cc_xpos_o <=  bpm_cc_xpos;
        bpm_cc_ypos_o <=  bpm_cc_ypos;
        timeframe_start_o <= timeframe_start;
    end if;
end process;

-- 2DFF cdc for fa_block_start_i
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

---------------------------------------------------
-- FIFO is used to handle CDC between ADC clock rate
-- and CC clock rate.
---------------------------------------------------
i_fofb_cc_fa_if_bram: entity work.fofb_cc_fa_if_bram
port map(
    addra       => std_logic_vector(addra),
    addrb       => std_logic_vector(addrb),
    ena         => '1',
    enb         => '1',
    clka        => adcclk_i,
    clkb        => mgtclk_i,
    dina        => fa_dat_prev,
    doutb       => doutb,
    wea         => fa_wea
);

-- addr generator
process(adcclk_i)
begin
    if (adcclk_i'event and adcclk_i='1') then
        if (adcreset_i = '1') then
            addra <= (others => '0');
        else
            -- if incoming data, increment addr
            if (fa_wea = '1') then
                addra <= addra + 1;
            end if;
        end if; 
    end if;
end process;

-- fa data read in done in mgt clock domain
process(mgtclk_i)
begin
    if (mgtclk_i'event and mgtclk_i='1') then
        if (mgtreset_i = '1') then
            timeframe_start <= '0';
            bpm_cc_xpos <= (others => '0');
            bpm_cc_ypos <= (others => '0');
            addrb <= "0000";
            addrb_prev <= "0000";
            addrb_cnt_en <= '0';
        else
            -- register addr to read
            addrb_prev <= addrb;

            if (block_start_fall = '1') then
                addrb_cnt_en <= '1';
            elsif (addrb = "1111") then
                addrb_cnt_en <= '0';
            end if;

            if (addrb_cnt_en = '1') then
                addrb <= addrb + 1;
            end if;

            -- read x position
            if (addrb_prev = unsigned(fa_x_psel_i)) then
                bpm_cc_xpos <= doutb;
            end if; 

            -- read y position
            if (addrb_prev = unsigned(fa_y_psel_i)) then
                bpm_cc_ypos <= doutb;
            end if; 

            -- own bpm position data is ready and can generate internal time frame pulse
            if (addrb = "1111") then
                timeframe_start <= '1';
            else
                timeframe_start <= '0';
            end if;
        end if;
    end if;
end process;

end rtl;
