-------------------------------------------------------------------------
--  Project      : Diamond FFS BPM				                           
--  Filename     : dcm_lclk
--  Purpose      : 60MHz local clock DCM on PMC
--  Responsible  : Isa Servan Uzun                                     
--------------------------------------------------------------------------
--  Copyright (c) 2005 Diamond Light Source Ltd.                      
--  All rights reserved.                                             
---------------------------------------------------------------------------
--  Description: 
----------------------------------------------------------------------------
--  Limitations & Assumptions:                                            
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug	  
--	 reports to isa.uzun@diamond.ac.uk.							          
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.ALL;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity dcm_lclk is
   port ( CLKIN_IN        : in    std_logic; 
          RST_IN          : in    std_logic; 
          CLKIN_IBUFG_OUT : out   std_logic; 
          CLK0_OUT        : out   std_logic; 
          LOCKED_OUT      : out   std_logic
   );
end dcm_lclk;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture BEHAVIORAL of dcm_lclk is

-----------------------------------------------
--  Signal declaration
-----------------------------------------------

signal CLKFB_IN        : std_logic;
signal CLKIN_IBUFG     : std_logic;
signal CLK0_BUF        : std_logic;
signal GND             : std_logic;
   
begin

GND             <= '0';
CLKIN_IBUFG_OUT <= CLKIN_IBUFG;
CLK0_OUT        <= CLKFB_IN;

CLKIN_IBUFG_INST : IBUFG
   port map (
      I=>CLKIN_IN,
      O=>CLKIN_IBUFG
   );

CLK0_BUFG_INST : BUFG
   port map (
      I=>CLK0_BUF,
      O=>CLKFB_IN
   );

DCM_INST : DCM
   generic map ( 
      CLK_FEEDBACK         => "1X",
      CLKDV_DIVIDE         => 2.000000,
      CLKFX_DIVIDE         => 1,
      CLKFX_MULTIPLY       => 4,
      CLKIN_DIVIDE_BY_2    => FALSE,
      CLKIN_PERIOD         => 16.666700,
      CLKOUT_PHASE_SHIFT   => "NONE",
      DESKEW_ADJUST        => "SYSTEM_SYNCHRONOUS",
      DFS_FREQUENCY_MODE   => "LOW",
      DLL_FREQUENCY_MODE   => "LOW",
      DUTY_CYCLE_CORRECTION=> TRUE,
      FACTORY_JF           => x"C080",
      PHASE_SHIFT          => 0,
      STARTUP_WAIT         => FALSE
   )
   port map (
      CLKFB    => CLKFB_IN,
      CLKIN    => CLKIN_IBUFG,
      DSSEN    => GND,
      PSCLK    => GND,
      PSEN     => GND,
      PSINCDEC => GND,
      RST      => RST_IN,
      CLKDV    => open,
      CLKFX    => open,
      CLKFX180 => open,
      CLK0     => CLK0_BUF,
      CLK2X    => open,
      CLK2X180 => open,
      CLK90    => open,
      CLK180   => open,
      CLK270   => open,
      LOCKED   => LOCKED_OUT,
      PSDONE   => open,
      STATUS   => open
   );
   
end BEHAVIORAL;


