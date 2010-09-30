----------------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     : fofb_cc_fa_intf.vhd
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
entity fofb_cc_fa_intf is
    port ( 
        mgt_clk             : in  std_logic;
        adc_clk             : in  std_logic;
        adc_rst             : in  std_logic;
        mgt_rst             : in  std_logic;
        fa_block_start      : in  std_logic;                     -- Block start, 32 ccycles long
        fa_data_valid       : in  std_logic;                     -- fa_data_valid
        fa_data             : in  std_logic_vector(15 downto 0); -- Fast acquisition data block
        time_frame_start    : out std_logic;                     -- frame start pulse
        bpm_cc_x_pos        : out std_logic_vector(31 downto 0); -- x-pos to be sent
        bpm_cc_y_pos        : out std_logic_vector(31 downto 0)  -- y-pos to be sent
    );
end fofb_cc_fa_intf;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_fa_intf is

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal fa_wea               : std_logic;
signal fa_data_reg          : std_logic_vector(15 downto 0);
signal addra                : unsigned(4 downto 0);
signal addrb                : unsigned(3 downto 0);
signal addrb_prev           : unsigned(3 downto 0);
signal doutb                : std_logic_vector(31 downto 0);
signal block_start          : std_logic;
signal block_start_prev     : std_logic;
signal block_start_fall     : std_logic;
signal bpm_cc_xpos_i        : std_logic_vector(31 downto 0);
signal bpm_cc_ypos_i        : std_logic_vector(31 downto 0);
signal time_frame_start_i   : std_logic;

begin

-- Register input data
process(adc_clk)
begin
    if (adc_clk'event and adc_clk = '1') then
        fa_wea <= fa_data_valid and fa_block_start; -- Write enable to FIFO
        fa_data_reg <= fa_data;                     -- Write data to FIFO
    end if;
end process;

-- Register outputs
process(mgt_clk)
begin
    if (mgt_clk 'event and mgt_clk = '1') then
        if (mgt_rst = '1') then
            bpm_cc_x_pos <=  (others => '0');
            bpm_cc_y_pos <=  (others => '0');
            time_frame_start <= '0';
        else
            bpm_cc_x_pos <=  bpm_cc_xpos_i;
            bpm_cc_y_pos <=  bpm_cc_ypos_i;
            time_frame_start <= time_frame_start_i;
        end if;
    end if;
end process;

-- 2DFF cdc for fa_block_start
i_block_start_syncff : entity work.fofb_cc_syncff
port map (
    clk_i      => mgt_clk,
    dat_i      => fa_block_start,
    dat_o      => block_start
);

process(mgt_clk)
begin
    if (mgt_clk 'event and mgt_clk = '1') then
        block_start_prev <= block_start;
        block_start_fall <= not block_start and block_start_prev;
    end if;
end process;

---------------------------------------------------
-- FIFO is used to handle CDC between ADC clock rate
-- and CC clock rate.
---------------------------------------------------
i_fofb_cc_fa_intf_bram: entity work.fofb_cc_fa_intf_bram
port map(
    addra       => std_logic_vector(addra),
    addrb       => std_logic_vector(addrb),
    ena         => '1',
    enb         => '1',
    clka        => adc_clk,
    clkb        => mgt_clk,
    dina        => fa_data_reg, 
    doutb       => doutb,
    wea         => fa_wea
);

-- addr generator
process(adc_clk, adc_rst)
begin
    if (adc_clk'event and adc_clk='1') then
        if (adc_rst = '1') then
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
process(mgt_clk)
begin
    if (mgt_clk'event and mgt_clk='1') then
        if (mgt_rst = '1') then
            addrb <= "0000";
            time_frame_start_i <= '0';
            bpm_cc_xpos_i <= (others => '0');
            bpm_cc_ypos_i <= (others => '0');
            addrb_prev <= "0000";
        else
            -- register addr to read
            addrb_prev <= addrb;

            -- if data write is finished, read address 14 and 15
            -- for x and y values
            if (block_start_fall = '1') then
                addrb <= "1110";
            else
                if (addrb /= "0000") then
                    addrb <= addrb + 1;
                end if;
            end if;

            -- read x position
            if (addrb_prev = "1110") then
                bpm_cc_xpos_i <= doutb;
            end if; 

            -- read y position
            if (addrb_prev = "1111") then
                bpm_cc_ypos_i <= doutb;
            end if; 

            -- own bpm position data is ready and can generate internal time frame pulse
            if (addrb = "1111") then
                time_frame_start_i <= '1';
            else
                time_frame_start_i <= '0';
            end if;
        end if;
    end if;
end process;

end rtl;
