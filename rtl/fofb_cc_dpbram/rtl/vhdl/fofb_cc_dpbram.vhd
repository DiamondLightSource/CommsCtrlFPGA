----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : fofb_cc_dpbram.vhd
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

entity fofb_cc_dpbram is
    generic (
        AW          : integer := 11;
        DW          : integer := 32
    );
    port (
        addra       : in  std_logic_vector(AW-1 downto 0);
        addrb       : in  std_logic_vector(AW-1 downto 0);
        clka        : in  std_logic;
        clkb        : in  std_logic;
        dina        : in  std_logic_vector(DW-1 downto 0);
        dinb        : in  std_logic_vector(DW-1 downto 0);
        douta       : out std_logic_vector(DW-1 downto 0);
        doutb       : out std_logic_vector(DW-1 downto 0);
        wea         : in  std_logic;
        web         : in  std_logic
    );
end fofb_cc_dpbram;

architecture rtl OF fofb_cc_dpbram is

type mem_type is array (2**AW-1 downto 0) of std_logic_vector (DW-1 downto 0);
shared variable mem : mem_type := (others => (others => '0'));

begin

PortA : process (clka)
begin
    if (clka'event and clka = '1') then
        -- read first
        douta <= mem(to_integer(unsigned(addra)));
        if (wea = '1') then
            mem(to_integer(unsigned(addra))) := dina;
        end if;
   end if;
end process;

PortB : process (clkb)
begin
    if (clkb'event and clkb = '1') then
        -- read first
        doutb <= mem(to_integer(unsigned(addrb)));
        if (web = '1') then
            mem(to_integer(unsigned(addrb))) := dinb;
        end if;
    end if;
end process;

end rtl;

