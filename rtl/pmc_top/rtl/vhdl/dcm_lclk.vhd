-------------------------------------------------------------------------
--  project      : diamond ffs bpm
--  filename     : dcm_lclk
--  purpose      : 60mhz local clock dcm on pmc
--  responsible  : isa servan uzun
--------------------------------------------------------------------------
--  copyright (c) 2005 diamond light source ltd.
--  all rights reserved.
---------------------------------------------------------------------------
--  description: 
----------------------------------------------------------------------------
--  limitations & assumptions:
----------------------------------------------------------------------------
--  known errors: this design is still under test. please send any bug    
--   reports to isa.uzun@diamond.ac.uk.
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- synthesis translate_off
library unisim;
use unisim.all;
-- synthesis translate_on

-----------------------------------------------
--  entity declaration
-----------------------------------------------
entity dcm_lclk is
   port (
        clk_i               : in    std_logic;
        reset_i             : in    std_logic;
        clkin_ibufg_o       : out   std_logic;
        clk0_o              : out   std_logic;
        dcm_locked_o        : out   std_logic
   );
end dcm_lclk;

-----------------------------------------------
--  architecture declaration
-----------------------------------------------
architecture rtl of dcm_lclk is

-----------------------------------------------
--  Component declaration
-----------------------------------------------
component IBUFG
port (
    O : out STD_ULOGIC;
    I : in STD_ULOGIC
);
end component;

component BUFG
port (
    O : out STD_ULOGIC;
    I : in STD_ULOGIC
);
end component;

component DCM
port (
    CLK0 : out STD_ULOGIC;
    CLK180 : out STD_ULOGIC;
    CLK270 : out STD_ULOGIC;
    CLK2X : out STD_ULOGIC;
    CLK2X180 : out STD_ULOGIC;
    CLK90 : out STD_ULOGIC;
    CLKDV : out STD_ULOGIC;
    CLKFX : out STD_ULOGIC;
    CLKFX180 : out STD_ULOGIC;
    LOCKED : out STD_ULOGIC;
    PSDONE : out STD_ULOGIC;
    STATUS : out STD_LOGIC_VECTOR (7 downto 0);
    CLKFB : in STD_ULOGIC;
    CLKIN : in STD_ULOGIC;
    DSSEN : in STD_ULOGIC;
    PSCLK : in STD_ULOGIC;
    PSEN : in STD_ULOGIC;
    PSINCDEC : in STD_ULOGIC;
    RST : in STD_ULOGIC
);
end component;

-----------------------------------------------
-- Signal declaration
-----------------------------------------------
signal clkfb_in        : std_logic;
signal clkin_ibufg     : std_logic;
signal clk0_buf        : std_logic;
signal gnd             : std_logic;

begin

gnd             <= '0';
clkin_ibufg_o   <= clkin_ibufg;
clk0_o          <= clkfb_in;

clkin_ibufg_inst : ibufg
port map (
    I                       => clk_i,
    O                       => clkin_ibufg
);


clk0_bufg_inst : bufg
port map (
    I                       => clk0_buf,
    O                       => clkfb_in
);

DCM_INST : DCM
port map (
    CLKFB                   => clkfb_in,
    CLKIN                   => clkin_ibufg,
    DSSEN                   => gnd,
    PSCLK                   => gnd,
    PSEN                    => gnd,
    PSINCDEC                => gnd,
    RST                     => reset_i,
    CLKDV                   => open,
    CLKFX                   => open,
    CLKFX180                => open,
    CLK0                    => clk0_buf,
    CLK2X                   => open,
    CLK2X180                => open,
    CLK90                   => open,
    CLK180                  => open,
    CLK270                  => open,
    LOCKED                  => dcm_locked_o,
    PSDONE                  => open,
    STATUS                  => open
);

end rtl;


