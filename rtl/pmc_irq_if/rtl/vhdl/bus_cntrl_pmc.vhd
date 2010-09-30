----------------------------------------------------------------------------
--  Project      : Diamond Communication Controller                                               
--  Filename     : bus_cntrl.vhd                                                        
--  Purpose      : CC PMC bus interface module 											   
--  Responsible  : Isa Uzun                                                            
----------------------------------------------------------------------------
--  Copyright (c) 2007 Diamond Light Source Ltd.                                                
--  All rights reserved.                                                                          
----------------------------------------------------------------------------
--  Description: CC PMC bus PCI local interface logic.									
--  PCI interface is handled by PLX9030 device.										
----------------------------------------------------------------------------
--  Limitations & Assumptions:                                            
----------------------------------------------------------------------------
--  Known Errors: This design is still under test. Please send any bug	  
--	reports to isa.uzun@diamond.ac.uk.							          
----------------------------------------------------------------------------

library ieee;
use	ieee.std_logic_1164.all;
use	ieee.std_logic_arith.all;
use	ieee.std_logic_unsigned.all;

library unisim;
use unisim.all;

use work.fofb_cc_pkg.all;	-- Diamond FOFB package

-----------------------------------------------
--  Entity declaration
-----------------------------------------------
entity bus_cntrl_pmc is
	port (
		-- Reset Interface
        sys_rst	  		    : in  std_logic;
        mgt_rst	  		    : in  std_logic;
		-- PMC Local Bus Interface
        clk60     		    : in  std_logic;
        nCS       		    : in  std_logic_vector(1 downto 0);
        nLBE      	    	: in  std_logic_vector(3 downto 0);
        LINTi       		: out std_logic_vector(2 downto 1);
        LWnR          		: in  std_logic;
        nWR       	    	: in  std_logic;
        nRD       		    : in  std_logic;
        nBLAST  		    : in  std_logic;
        nADS      		    : in  std_logic;
        ALE       		    : in  std_logic;
        LAD       		    : inout std_logic_vector(31 downto 0);
        -- I/O connector pins
		PMCIO               : inout std_logic_vector(31 downto 0)		
	);
end bus_cntrl_pmc;

-----------------------------------------------
--  Architecture declaration
-----------------------------------------------
architecture rtl of bus_cntrl_pmc is

component icon
port
(
  control0    :   out std_logic_vector(35 downto 0)
);
end component;

component ila
port
(
  control     : in    std_logic_vector(35 downto 0);
  clk         : in    std_logic;
  data        : in    std_logic_vector(255 downto 0);
  trig0       : in    std_logic_vector(31 downto 0)
);
end component;

signal control0       : std_logic_vector(35 downto 0);
signal data       : std_logic_vector(255 downto 0);
signal trig0      : std_logic_vector(31 downto 0);

-----------------------------------------------
--  Signal declaration
-----------------------------------------------
signal ip_addr              : std_logic_vector(31 downto 0);
signal ip_data_in           : std_logic_vector(31 downto 0);
signal ip_data_out          : std_logic_vector(31 downto 0);
signal dma_data_out         : std_logic_vector(31 downto 0);
signal ip_wr                : std_logic_vector(3 downto 0);
signal bram_addr            : std_logic_vector(9 downto 0);
signal irq_ena              : std_logic;
signal irq_flag             : std_logic;
signal irq_flag_clear       : std_logic;
signal time_frame_end       : std_logic	:= '0';
signal time_frame_end_reg   : std_logic := '0';
signal time_frame_end_rise  : std_logic := '0';
signal PMCIO_data           : std_logic_vector(31 downto 0) := X"00000000";  
signal dma_cycle            : std_logic := '0';
signal fai_cfg_val_i        : std_logic_vector(31 downto 0);
signal fofb_heart_beat_i    : std_logic;
signal fofb_heart_beat_reg  : std_logic;
signal fofb_heart_beat_val  : std_logic;
signal fofb_event_i         : std_logic_vector(31 downto 0);
signal cfg_bram_addra		: std_logic_VECTOR(10 downto 0);
signal cfg_bram_data_out	: std_logic_VECTOR(31 downto 0);
signal cfg_bram_we			: std_logic;
signal fofb_process_time_i  : std_logic_vector(15 downto 0);
signal fofb_bpm_count_i     : std_logic_vector(7 downto 0);
signal nADS_reg             : std_logic := '1';
signal nBLAST_reg           : std_logic := '1';
signal nCS_0_reg            : std_logic := '1';
signal missed_dma_cnt       : std_logic_vector(3 downto 0) := (others => '0');
signal fofb_dma_ok_i        : std_logic := '1';
signal dma_ok_flag_clear    : std_logic := '0';
signal fofb_node_mask_i     : std_logic_vector(NodeNum-1 downto 0);
signal two_bit_cnt          : std_logic_vector(1 downto 0) := "00";

begin
 
---------------------------------------------------------------
-- Local Bus Interface
---------------------------------------------------------------
local_bus_access : process (clk60)
    variable wr              : std_logic := '0';
    variable rd              : std_logic := '0';
begin
    if (clk60'event and clk60 = '1') then
    
        -- Latch address during Read/Write cycle start
        if (nADS = '0' and nCS(0) = '0') then
            ip_addr <= LAD;
        end if;   
    
        -- Config BRAM write enable
        cfg_bram_we <= '0';
        
        if nWR = '0' then
            ip_data_in <= LAD;
            if (ip_addr(12) = '1') then
                cfg_bram_we <= not nWR;
            end if;
        end if;
	
        -- Write Byte enables
        ip_wr <= "0000";
        
        if nWR = '0' then
            ip_wr(0) <= not nLBE(0);
            ip_wr(1) <= not nLBE(1);
            ip_wr(2) <= not nLBE(2);
            ip_wr(3) <= not nLBE(3);
        end if;

	    -- Read access from PMC
        LAD <= (others => 'Z');

        if nRD = '0' then
            if (nCS(0) = '0') then		-- BAR2
                if (ip_addr(12) = '0') then
                    LAD <= ip_data_out;
                else
                    LAD <= cfg_bram_data_out;			
                end if;
            end if;
						
            if nCS(1) = '0' then	-- BAR3
                LAD <= dma_data_out;
            end if;	
        end if; 	  
    end if;
end process;

------------------------------------------------
--	Register access on BAR2
------------------------------------------------
ip_access : process (clk60)
    variable data_rd         : std_logic_vector(31 downto 0);
begin
    if (clk60'event and clk60 = '1') then
        if (sys_rst = '1') then
            irq_ena             <= '0';
            irq_flag_clear      <= '0';
        else
            data_rd := (others => '0');
        
            -- Data read 
            case ip_addr(6 downto 2) is
                when "01000" =>
                    data_rd(1)  := irq_ena;
                    data_rd(0)  := irq_flag;
                when others  =>
                    data_rd     := X"00000000";		   
            end case;

            ip_data_out 	    <= data_rd;         
            irq_flag_clear      <= '0';
            
            -- Data write 
            if (ip_addr(12) = '0') then
                case ip_addr(6 downto 2) is		
                   -- IRQ enable and clear flag from console
                    when "01000" => 
                        if ip_wr(0) = '1' then
                            irq_ena         <= ip_data_in(1);
                            irq_flag_clear 	<= ip_data_in(0);
                        end if;
                    when others =>
                end case;
            end if;
        end if;
    end if;
end process;

interrupt: process (clk60)
    variable counter : std_logic_vector(31 downto 0);
begin
    if (clk60'event and clk60 = '1') then
      if irq_ena = '1' then
	        if (counter = X"00001770") then -- 10usec
	            counter := (others => '0');
	        else
	            counter := counter + 1;
	        end if;
      else
	        counter := (others => '0');      
      end if;
      
      if (counter = X"00001770") then
          irq_flag <= '1';
      elsif (irq_flag_clear = '1' or irq_ena = '0' or sys_rst = '1') then
	        irq_flag <= '0';
      end if;
    end if;
end process;

LINTi(1) <= irq_flag;	-- INTA on PCI
LINTi(2) <= '0';		-- not used

--process (clk60)
--begin
--    if (clk60'event and clk60 = '1') then
--        if (sys_rst = '1') then
--            two_bit_cnt <= "00";
--            PMCIO <= X"00000000";
--            PMCIO_data <= X"00000000";
--        else
--            PMCIO_data(11) <= two_bit_cnt(0);
--            PMCIO_data(12) <= two_bit_cnt(1);
--            PMCIO_data(13) <= two_bit_cnt(0);
--            PMCIO_data(14) <= two_bit_cnt(1);
--            PMCIO <= PMCIO_data;
--            two_bit_cnt <= two_bit_cnt + '1';
--        end if;
--    end if;
--end process;

PMCIO_data(11) <= irq_flag;
PMCIO_data(12) <= irq_flag_clear;
PMCIO_data(13) <= irq_flag;
PMCIO_data(14) <= irq_flag_clear;
PMCIO          <= PMCIO_data;

i_icon : icon
port map
(
  control0    => control0
);

-------------------------------------------------------------------
--
--  ILA core instance
--
-------------------------------------------------------------------
i_ila : ila
port map
(
  control   => control0,
  clk       => clk60,
  data      => data,
  trig0     => trig0
);

trig0(0) <= irq_flag;
trig0(1) <= irq_flag_clear;
trig0(2) <= irq_ena;

data(0) <= irq_flag;
data(1) <= irq_flag_clear;
data(2) <= irq_ena;
data(4 downto 3) <= PMCIO_data(12 downto 11);
data(6 downto 5) <= two_bit_cnt;

end rtl;
