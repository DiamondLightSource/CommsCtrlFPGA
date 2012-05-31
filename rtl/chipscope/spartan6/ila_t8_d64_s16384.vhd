-------------------------------------------------------------------------------
-- Copyright (c) 2012 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 13.4
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : ila_t8_d64_s16384.vhd
-- /___/   /\     Timestamp  : Wed May 30 15:11:29 BST 2012
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY ila_t8_d64_s16384 IS
  port (
    CONTROL: inout std_logic_vector(35 downto 0);
    CLK: in std_logic;
    DATA: in std_logic_vector(63 downto 0);
    TRIG0: in std_logic_vector(7 downto 0));
END ila_t8_d64_s16384;

ARCHITECTURE ila_t8_d64_s16384_a OF ila_t8_d64_s16384 IS
BEGIN

END ila_t8_d64_s16384_a;
