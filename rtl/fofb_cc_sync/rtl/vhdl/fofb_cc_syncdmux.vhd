----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : fofb_cc_syncdmux.vhd
--  Purpose      : Data mux synchroniser for data lines
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: Data mux synchroniser for data line. ctrl_i control line
--  should toggle everytime dat_i is changed.
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fofb_cc_syncdmux is
    generic (
        DW          : in  integer := 32
    );
    port (
        clk_i       : in  std_logic;
        dat_i       : in  std_logic_vector(DW-1 downto 0);
        ctrl_i      : in  std_logic;
        dat_o       : out std_logic_vector(DW-1 downto 0) := (others => '0')
    );
end fofb_cc_syncdmux;

architecture rtl of fofb_cc_syncdmux is

signal  ctrl_synced         : std_logic;
signal  ctrl_synced_prev    : std_logic;

begin

fofb_cc_syncff0 : entity work.fofb_cc_syncff
port map (
    clk_i       => clk_i,
    dat_i       => ctrl_i,
    dat_o       => ctrl_synced
);

-- Wait until ctrl_i control line settled, then
-- capture dat_i
process(clk_i)
begin
    if rising_edge(clk_i) then
        ctrl_synced_prev <= ctrl_synced;

        if ((ctrl_synced xor ctrl_synced_prev) = '1') then
            dat_o <= dat_i;
        end if;

    end if;
end process;

end rtl;

