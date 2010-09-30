----------------------------------------------------------------------------
--  Project     : Diamond FOFB Communication Controller
--  Filename    : fofb_cc_fifo_rst.vhd
--  Purpose     : Fifo reset signals generation module
--  Author      : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: When frame time out occurs, both tx and rx fifos are   
--  flushed.
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_fifo_rst is
    port (
        mgtclk_i            : in std_logic;
        mgtreset_i          : in std_logic;
        rx_linkup_i         : in std_logic;
        tx_linkup_i         : in std_logic;
        timeframe_end_i     : in std_logic;     -- frame time out
        tx_sm_busy_i        : in std_logic;     -- tx state machine status flag, 1: reset possible, 0; wait
        rx_sm_busy_i        : in std_logic;     -- rx state machine status flag, 1: reset possible, 0; wait
        txfifo_reset_o      : out std_logic;    -- tx reset
        rxfifo_reset_o      : out std_logic     -- rx reset
    );
end fofb_cc_fifo_rst;
-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_fifo_rst is

-----------------------------------------
-- Signal declarations
-----------------------------------------
signal tx_rst_cnt               : unsigned(1 downto 0);
signal tx_rst_cnt_en            : std_logic;
signal rx_rst_cnt               : unsigned(1 downto 0);
signal rx_rst_cnt_en            : std_logic;
signal timeframe_end_reg        : std_logic;
signal timeframe_end_rise       : std_logic;

begin

txfifo_reset_o <= not tx_linkup_i or (tx_rst_cnt_en and not tx_sm_busy_i);
rxfifo_reset_o <= not rx_linkup_i or (rx_rst_cnt_en and not rx_sm_busy_i);

timeframe_end_rise <= timeframe_end_i and not timeframe_end_reg;

process(mgtclk_i)
begin
    if(mgtclk_i'event and mgtclk_i = '1')then

        if (mgtreset_i = '1') then
            timeframe_end_reg <= '0';
            tx_rst_cnt         <= "11";
            tx_rst_cnt_en      <= '0';
            rx_rst_cnt         <= "11";
            rx_rst_cnt_en      <= '0';
        else

            timeframe_end_reg  <= timeframe_end_i;

            -- fifo reset must be 4 clock cycles in length.
            if (timeframe_end_rise = '1') then
                tx_rst_cnt_en   <= '1';
            elsif (tx_rst_cnt = 0) then
                tx_rst_cnt_en   <= '0';
            end if;

            -- check state machine status
            if (tx_rst_cnt_en = '1' and tx_sm_busy_i = '0') then 
                tx_rst_cnt <= tx_rst_cnt - 1;
            end if; 

            -- fifo reset must be 4 clock cycles in length.
            if (timeframe_end_rise = '1') then
                rx_rst_cnt_en <= '1';
            elsif (rx_rst_cnt = 0) then
                rx_rst_cnt_en <= '0';
            end if;

            -- check state machine status
            if (rx_rst_cnt_en = '1' and rx_sm_busy_i = '0') then
                rx_rst_cnt <= rx_rst_cnt - 1;
            end if; 
        end if; 
    end if;
end process;

end;
