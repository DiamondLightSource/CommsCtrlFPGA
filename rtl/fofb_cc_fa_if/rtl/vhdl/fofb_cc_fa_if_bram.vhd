----------------------------------------------------------------------------
--  Project      : Diamond FOFB Communication Controller
--  Filename     : fofb_cc_fa_if_bram.vhd
--  Purpose      : Fast data acquision interface dual-port BRAM
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: FA data acquision interface dual-port BRAM. This module is
--  used for clock domain crossing from ADC to MGT to read fa rate data
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug
--  reports to isa.uzun@diamond.ac.uk
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity fofb_cc_fa_if_bram is
    port (
        addra   : IN std_logic_VECTOR(4 downto 0);
        addrb   : IN std_logic_VECTOR(3 downto 0);
        ena     : in std_logic;
        enb     : in std_logic;
        clka    : IN std_logic;
        clkb    : IN std_logic;
        dina    : IN std_logic_VECTOR(15 downto 0);
        doutb   : OUT std_logic_VECTOR(31 downto 0);
        wea     : IN std_logic
    );
end entity;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of fofb_cc_fa_if_bram is

-----------------------------------------------
-- Component declaration
-----------------------------------------------
component RAMB16_S18_S36
    port (
        DIA     : in std_logic_vector (15 downto 0);
        DIPA    : in std_logic_vector (1 downto 0);
        ADDRA   : in std_logic_vector (9 downto 0);
        ENA     : in std_logic;
        WEA     : in std_logic;
        SSRA    : in std_logic;
        CLKA    : in std_logic;
        DOA     : out std_logic_vector (15 downto 0);
        DOPA    : out std_logic_vector (1 downto 0);
        DIB     : in std_logic_vector (31 downto 0);
        DIPB    : in std_logic_vector (3 downto 0);
        ADDRB   : in std_logic_vector (8 downto 0);
        ENB     : in std_logic;
        WEB     : in std_logic;
        SSRB    : in std_logic;
        CLKB    : in std_logic;
        DOB     : out std_logic_vector (31 downto 0);
        DOPB    : out std_logic_vector (3 downto 0)
    );
end component;

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal  addra_i : std_logic_vector(9 downto 0);
signal  addrb_i : std_logic_vector(8 downto 0);

begin

addra_i <= "00000" & addra;
addrb_i <= "00000" & addrb;

RAMB16_S18_S36_inst : RAMB16_S18_S36
    port map (
      DOA   => open,
      DOB   => doutb,
      DOPA  => open,
      DOPB  => open,
      ADDRA => addra_i,
      ADDRB => addrb_i,
      CLKA  => clka,
      CLKB  => clkb,
      DIA   => dina,
      DIB   => (others => '0'),
      DIPA  => (others => '0'),
      DIPB  => (others => '0'),
      ENA   => ena,
      ENB   => enb,
      SSRA  => '0',
      SSRB  => '0',
      WEA   => wea,
      WEB   => '0'
    );
end;
