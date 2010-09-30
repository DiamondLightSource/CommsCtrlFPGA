----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : fofb_cc_syncff.vhd
--  Purpose      : 2 DFF single-bit synchroniser
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: 2 DFF single-bit synchroniser. A VHDL attribute is used to preserve
--  signals so that they will be implemented using hard DFFs in the Virtex Slices,
--  not LUTs.
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fofb_cc_syncff is
    port (
        clk_i       : in  std_logic;
        dat_i       : in  std_logic;
        dat_o       : out std_logic
    );
end fofb_cc_syncff;

architecture rtl of fofb_cc_syncff is

signal stage1   : std_logic;
signal stage2   : std_logic;

attribute keep : string;
attribute keep of stage1, stage2: signal is "true";

begin

process(clk_i)
begin
    if rising_edge(clk_i) then
        stage1 <= dat_i;
        stage2 <= stage1;
    end if;
end process;

dat_o <= stage2;

end rtl;

