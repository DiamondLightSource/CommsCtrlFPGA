----------------------------------------------------------------------------
--  Project      : Diamond Diamond FOFB Communication Controller
--  Filename     : pmc_irq_if.vhd
--  Purpose      : PMC-SFP top level design
--  Author       : Isa S. Uzun
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.
--  All rights reserved.
----------------------------------------------------------------------------
--  Description: Top level design file for PMC-SFP module including
--  CC instantiation.
----------------------------------------------------------------------------
--  Limitations & Assumptions:
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug
--  reports to isa.uzun@diamond.ac.uk.
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.fofb_cc_pkg.all;   -- DLS FOFB package
use work.fofb_cc_conf.all;  -- CC configuration package

library unisim;
use unisim.vcomponents.all;

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity pmc_irq_if is
    port (
        -- Local Bus Signals
        LCLK                    : in std_logic;
        nCS                     : in std_logic_vector(1 downto 0);
        nREADY                  : out std_logic;
        nLBE                    : in std_logic_vector(3 downto 0);
        nBTERM                  : out std_logic;
        LINTi                   : out std_logic_vector(2 downto 1);
        LWnR                    : in std_logic;
        nWR                     : in std_logic;
        nRD                     : in std_logic;
        nBLAST                  : in std_logic;
        nADS                    : in std_logic;
        ALE                     : in std_logic;
        LAD                     : inout std_logic_vector(31 downto 0);
        -- I/O connector pins
        PMCIO                   : inout std_logic_vector(31 downto 0);
        nPIF                    : in std_logic_vector(3 downto 0);
        nPIFHANDLE              : in std_logic;
        PMCIFON                 : out std_logic;
        -- LEDS
        nLED                    : out std_logic_vector(3 downto 0);
        -- Micrel SY87739L programming signals
        CGLOCK                  : in std_logic;
        CGSK                    : out std_logic;
        CGDI                    : out std_logic;
        CGCS                    : out std_logic
    );
end pmc_irq_if;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------

architecture rtl of pmc_irq_if is

-----------------------------------------------
-- Component declaration
-----------------------------------------------

component uwire is
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
end component;

component dcm_lclk
  port ( 
    CLKIN_IN        : in    std_logic; 
    CLKIN_IBUFG_OUT : out   std_logic; 
    RST_IN          : in    std_logic; 
    CLK0_OUT        : out   std_logic; 
    LOCKED_OUT      : out   std_logic
  );
end component;

component bus_cntrl_pmc
  port (
    -- System Interface 
    sys_rst           : in std_logic;
    mgt_rst           : in std_logic;
    clk60             : in std_logic;
    nCS               : in std_logic_vector(1 downto 0);
    nLBE              : in std_logic_vector(3 downto 0);
    LINTi             : out std_logic_vector(2 downto 1);
    LWnR              : in std_logic;
    nWR               : in std_logic;
    nRD               : in std_logic;
    nBLAST            : in std_logic;
    nADS              : in std_logic;
    ALE               : in std_logic;
    LAD               : inout std_logic_vector(31 downto 0);
    PMCIO             : inout std_logic_vector(31 downto 0)    
  );
end component;

-----------------------------------------------
--  Signal declaration
-----------------------------------------------
signal sys_clk            : std_logic;
signal sys_rst_i          : std_logic;
signal sys_rst            : std_logic;
signal dcm_rst_so         : std_logic := '0';
signal sys_dcm_locked     : std_logic := '0';
signal lclk_int           : std_logic := '0';
signal uwire_wr           : std_logic;
signal uwire_data_out     : std_logic_vector(31 downto 0);
signal uwire_reload       : std_logic := '0';
signal int_cnt            : std_logic_vector(31 downto 0);
signal Q                  : std_logic_vector(31 downto 0);  

begin

nREADY  <= '1';
nBTERM  <= '1';
PMCIFON <= '0';
sys_rst <=  not sys_rst_i;

---------------------------------------------------------
-- Reset logic for PMC-CC
-- main reset - while asserted (0), hold DCM in reset
-- when it de-asserts, wait for DCM locks and release
-- internal resets
---------------------------------------------------------
i0_SRL16_dcm_rst : SRL16
  port map (
     Q  => dcm_rst_so,
     A0   => '1',    
     A1   => '1',        
     A2   => '1',        
     A3   => '1',        
     CLK  => lclk_int,     
     D  => '1'           
  );

i_SRL16_sys_rst : SRL16
  port map (
     Q  => sys_rst_i,     
     A0   => '1',    
     A1   => '1',       
     A2   => '1',        
     A3   => '1',         
     CLK  => sys_clk,      
     D  => sys_dcm_locked  
  );

-----------------------------------
-- System clock Interface (60 MHz)
-----------------------------------
i_lclk : dcm_lclk
  port map (
    CLKIN_IN        => LCLK,
    CLKIN_IBUFG_OUT => lclk_int,
    RST_IN          => not dcm_rst_so,
    CLK0_OUT        => sys_clk,
    LOCKED_OUT      => sys_dcm_locked
  );

i_uwire : uwire
  port map (
    clk           => sys_clk,
    data          => (others=>'0'),
    wr            => uwire_wr,
    data_readback => uwire_data_out,
    reload        => uwire_reload,
    reset         => sys_rst,
    CGSK          => CGSK,
    CGDI          => CGDI,
    CGCS          => CGCS
);

--------------------------------------------------
-- PMC module bus control interface       --
-------------------------------------------------- 
i_bus_cntrl_pmc: bus_cntrl_pmc 
  port map(
    sys_rst           => sys_rst,
    mgt_rst           => '0',
    clk60             => sys_clk,
    nCS               => nCS,
    nLBE              => nLBE,
    LINTi             => LINTi,
    LWnR              => LWnR,
    nWR               => nWR,
    nRD               => nRD,
    nBLAST            => nBLAST,
    nADS              => nADS,
    ALE               => ALE,
    LAD               => LAD,
    PMCIO             => PMCIO
);

nLED  <= "1111";

end rtl;
