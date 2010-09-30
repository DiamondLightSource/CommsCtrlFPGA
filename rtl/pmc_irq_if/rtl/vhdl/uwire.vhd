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
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity uwire is
    port (
        clk           : in std_logic;
        data          : in std_logic_vector(31 downto 0);
        wr            : in std_logic;
        data_readback : out std_logic_vector(31 downto 0);
        reload        : in std_logic;
        reset         : in std_logic;
        -- Micrel SY87729L serial bus signals
        CGSK          : out std_logic;
        CGDI          : out std_logic;
        CGCS          : out std_logic
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

-- Local bus data interface
local_data: process (clk, data, wr, serial_data, reset)
    begin
        data_readback <= serial_data;
        if clk'event and clk = '1' then
          if wr = '1' then
              serial_data <= data;
          end if;
          
          if reset = '1' then
            serial_data <= X"049E81AD";
          end if;
      end if;
end process;
  
-- SY87729L Programming via MicroWire
refclk_programming: process (clk, serial_data, reload, reset)
    variable prescaler : natural range 0 to 15;
    variable bit_counter : natural range 0 to 31;
    variable end_of_count : std_logic;
begin
    if clk'event and clk = '1' then
        CGDI <= serial_data(31 - bit_counter);
        if prescaler = 15 then
            if bit_counter = 31 then
                end_of_count := '1';
            else
                bit_counter := bit_counter + 1;
            end if;
        end if;

        prescaler := prescaler + 1;
        CGCS <= not end_of_count;

        if reset = '1' or reload = '1' then
            prescaler     := 0;
            bit_counter   := 0;
            end_of_count  := '0';
            CGCS          <= '0';
        end if;

        CGSK <= '0';
    
        if prescaler > 8 and end_of_count = '0' then
            CGSK <= '1';
        end if;
    end if;
end process;

end rtl;
