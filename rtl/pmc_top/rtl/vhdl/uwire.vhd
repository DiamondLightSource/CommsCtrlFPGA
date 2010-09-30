----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : uwire.vhd
--  Purpose      : Micrel SY87729L/SY87739L interface 
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description  : Micrel SY87729L/SY87739L MicroWire serial configuration 
--  logic
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug
--  reports to isa.uzun@diamond.ac.uk.
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity uwire is
    port (
        clk_i           : in std_logic;
        dat_i           : in std_logic_vector(31 downto 0);
        wr_i            : in std_logic;
        data_rdback_o   : out std_logic_vector(31 downto 0);
        reload_i        : in std_logic;
        reset_i         : in std_logic;
        -- Micrel SY87729L serial bus signals
        cgsk_o          : out std_logic;
        cgdi_o          : out std_logic;
        cgcs_o          : out std_logic
    );
end uwire;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of uwire is

-----------------------------------------------
--  Signal declaration
-----------------------------------------------
signal serial_data : std_logic_vector(31 downto 0);

begin

data_rdback_o <= serial_data;

-- Local bus data interface
local_data: process (clk_i)
    begin
        if (clk_i'event and clk_i = '1') then
            if (reset_i = '1') then
                serial_data <= X"049E81AD";
            else
                if (wr_i = '1') then
                    serial_data <= dat_i;
                end if;
            end if;
      end if;
end process;
  
-- SY87729L Programming via MicroWire
refclk_programming: process (clk_i)
    variable prescaler : natural range 0 to 15;
    variable bit_counter : natural range 0 to 31;
    variable end_of_count : std_logic;
begin
    if (clk_i'event and clk_i = '1') then
        if (reset_i = '1') then
            prescaler := 0;
            bit_counter := 0;
            end_of_count := '0';
            cgcs_o <= '0';
            cgsk_o <= '0';
            cgdi_o <= '0';
        else
            if (reload_i = '1') then
                prescaler := 0;
                bit_counter := 0;
                end_of_count := '0';
                cgcs_o <= '0';
                cgsk_o <= '0';
                cgdi_o <= '0';
            end if;

            cgdi_o <= serial_data(31 - bit_counter);
            if prescaler = 15 then
                if (bit_counter = 31) then
                    end_of_count := '1';
                else
                    bit_counter := bit_counter + 1;
                end if;
            end if;

            prescaler := prescaler + 1;
            cgcs_o <= not end_of_count;

            cgsk_o <= '0';

            if (prescaler > 8 and end_of_count = '0') then
                cgsk_o <= '1';
            end if;
        end if;

    end if;
end process;

end rtl;

