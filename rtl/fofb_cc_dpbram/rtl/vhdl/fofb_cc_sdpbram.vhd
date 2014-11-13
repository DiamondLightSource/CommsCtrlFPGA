----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : fofb_cc_sdpbram.vhd
--  Purpose      : Generic VHDL Block RAM code
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2006 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description  : Infers user defined Dual-Port Block RAM
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug
--  reports to isa.uzun@diamond.ac.uk
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fofb_cc_sdpbram is
    generic (
        AW          : natural := 8;
        DW          : natural := 32;
        INIT        : std_logic_vector(31 downto 0) := (others => '0')
    );
    port (
        addra       : in  std_logic_vector(AW-1 downto 0);
        addrb       : in  std_logic_vector(AW-1 downto 0);
        clka        : in  std_logic;
        clkb        : in  std_logic;
        dina        : in  std_logic_vector(DW-1 downto 0);
        doutb       : out std_logic_vector(DW-1 downto 0);
        wea         : in  std_logic
    );
end fofb_cc_sdpbram;

architecture rtl of fofb_cc_sdpbram is

type mem_type is array (2**AW-1 downto 0) of std_logic_vector (DW-1 downto 0);

shared variable mem : mem_type := (others => INIT(DW-1 downto 0));

begin

process (clka)
begin
   if (clka'event and clka = '1') then
     if (wea = '1') then
        mem(to_integer(unsigned(addra))) := dina;
     end if;
   end if;
end process;

process (clkb)
begin
   if (clkb'event and clkb = '1') then
     doutb <= mem(to_integer(unsigned(addrb)));
   end if;
end process;

end rtl;

