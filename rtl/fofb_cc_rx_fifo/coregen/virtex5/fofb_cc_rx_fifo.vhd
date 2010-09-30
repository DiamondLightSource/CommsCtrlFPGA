--------------------------------------------------------------------------------
-- Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: M.53d
--  \   \         Application: netgen
--  /   /         Filename: fofb_cc_rx_fifo.vhd
-- /___/   /\     Timestamp: Thu Jul 22 09:42:27 2010
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl ./tmp/_cg/fofb_cc_rx_fifo.ngc ./tmp/_cg/fofb_cc_rx_fifo.vhd 
-- Device	: 5vlx50tff1136-1
-- Input file	: ./tmp/_cg/fofb_cc_rx_fifo.ngc
-- Output file	: ./tmp/_cg/fofb_cc_rx_fifo.vhd
-- # of Entities	: 1
-- Design Name	: fofb_cc_rx_fifo
-- Xilinx	: /dls_sw/apps/FPGA/Xilinx/12.1/ISE_DS/ISE
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity fofb_cc_rx_fifo is
  port (
    rd_en : in STD_LOGIC := 'X'; 
    wr_en : in STD_LOGIC := 'X'; 
    full : out STD_LOGIC; 
    empty : out STD_LOGIC; 
    wr_clk : in STD_LOGIC := 'X'; 
    rst : in STD_LOGIC := 'X'; 
    rd_clk : in STD_LOGIC := 'X'; 
    dout : out STD_LOGIC_VECTOR ( 127 downto 0 ); 
    din : in STD_LOGIC_VECTOR ( 15 downto 0 ) 
  );
end fofb_cc_rx_fifo;

architecture STRUCTURE of fofb_cc_rx_fifo is
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000067_313 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000242_312 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000224_311 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000190_310 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000125_309 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000033_308 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000036_307 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000176_306 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000126_305 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000086_304 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_tmp_ram_rd_en : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_295 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_294 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_292 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_290 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_288 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_286 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_284 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_7_rt_282 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count7 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0006 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0005 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_167 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_166 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d1_165 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_164 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_163 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_162 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_161 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_RST_FULL_GEN_160 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d3_159 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_158 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rst_d2_157 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_155 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000 : STD_LOGIC; 
  signal BU2_N1 : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED : STD_LOGIC;
 
  signal din_2 : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal dout_3 : STD_LOGIC_VECTOR ( 127 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d2 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d1 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_d1 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 7 downto 3 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin : STD_LOGIC_VECTOR ( 7 downto 3 ); 
  signal BU2_U0_grf_rf_rstblk_wr_rst_reg : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_rstblk_rd_rst_reg : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal BU2_rd_data_count : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  dout(127) <= dout_3(127);
  dout(126) <= dout_3(126);
  dout(125) <= dout_3(125);
  dout(124) <= dout_3(124);
  dout(123) <= dout_3(123);
  dout(122) <= dout_3(122);
  dout(121) <= dout_3(121);
  dout(120) <= dout_3(120);
  dout(119) <= dout_3(119);
  dout(118) <= dout_3(118);
  dout(117) <= dout_3(117);
  dout(116) <= dout_3(116);
  dout(115) <= dout_3(115);
  dout(114) <= dout_3(114);
  dout(113) <= dout_3(113);
  dout(112) <= dout_3(112);
  dout(111) <= dout_3(111);
  dout(110) <= dout_3(110);
  dout(109) <= dout_3(109);
  dout(108) <= dout_3(108);
  dout(107) <= dout_3(107);
  dout(106) <= dout_3(106);
  dout(105) <= dout_3(105);
  dout(104) <= dout_3(104);
  dout(103) <= dout_3(103);
  dout(102) <= dout_3(102);
  dout(101) <= dout_3(101);
  dout(100) <= dout_3(100);
  dout(99) <= dout_3(99);
  dout(98) <= dout_3(98);
  dout(97) <= dout_3(97);
  dout(96) <= dout_3(96);
  dout(95) <= dout_3(95);
  dout(94) <= dout_3(94);
  dout(93) <= dout_3(93);
  dout(92) <= dout_3(92);
  dout(91) <= dout_3(91);
  dout(90) <= dout_3(90);
  dout(89) <= dout_3(89);
  dout(88) <= dout_3(88);
  dout(87) <= dout_3(87);
  dout(86) <= dout_3(86);
  dout(85) <= dout_3(85);
  dout(84) <= dout_3(84);
  dout(83) <= dout_3(83);
  dout(82) <= dout_3(82);
  dout(81) <= dout_3(81);
  dout(80) <= dout_3(80);
  dout(79) <= dout_3(79);
  dout(78) <= dout_3(78);
  dout(77) <= dout_3(77);
  dout(76) <= dout_3(76);
  dout(75) <= dout_3(75);
  dout(74) <= dout_3(74);
  dout(73) <= dout_3(73);
  dout(72) <= dout_3(72);
  dout(71) <= dout_3(71);
  dout(70) <= dout_3(70);
  dout(69) <= dout_3(69);
  dout(68) <= dout_3(68);
  dout(67) <= dout_3(67);
  dout(66) <= dout_3(66);
  dout(65) <= dout_3(65);
  dout(64) <= dout_3(64);
  dout(63) <= dout_3(63);
  dout(62) <= dout_3(62);
  dout(61) <= dout_3(61);
  dout(60) <= dout_3(60);
  dout(59) <= dout_3(59);
  dout(58) <= dout_3(58);
  dout(57) <= dout_3(57);
  dout(56) <= dout_3(56);
  dout(55) <= dout_3(55);
  dout(54) <= dout_3(54);
  dout(53) <= dout_3(53);
  dout(52) <= dout_3(52);
  dout(51) <= dout_3(51);
  dout(50) <= dout_3(50);
  dout(49) <= dout_3(49);
  dout(48) <= dout_3(48);
  dout(47) <= dout_3(47);
  dout(46) <= dout_3(46);
  dout(45) <= dout_3(45);
  dout(44) <= dout_3(44);
  dout(43) <= dout_3(43);
  dout(42) <= dout_3(42);
  dout(41) <= dout_3(41);
  dout(40) <= dout_3(40);
  dout(39) <= dout_3(39);
  dout(38) <= dout_3(38);
  dout(37) <= dout_3(37);
  dout(36) <= dout_3(36);
  dout(35) <= dout_3(35);
  dout(34) <= dout_3(34);
  dout(33) <= dout_3(33);
  dout(32) <= dout_3(32);
  dout(31) <= dout_3(31);
  dout(30) <= dout_3(30);
  dout(29) <= dout_3(29);
  dout(28) <= dout_3(28);
  dout(27) <= dout_3(27);
  dout(26) <= dout_3(26);
  dout(25) <= dout_3(25);
  dout(24) <= dout_3(24);
  dout(23) <= dout_3(23);
  dout(22) <= dout_3(22);
  dout(21) <= dout_3(21);
  dout(20) <= dout_3(20);
  dout(19) <= dout_3(19);
  dout(18) <= dout_3(18);
  dout(17) <= dout_3(17);
  dout(16) <= dout_3(16);
  dout(15) <= dout_3(15);
  dout(14) <= dout_3(14);
  dout(13) <= dout_3(13);
  dout(12) <= dout_3(12);
  dout(11) <= dout_3(11);
  dout(10) <= dout_3(10);
  dout(9) <= dout_3(9);
  dout(8) <= dout_3(8);
  dout(7) <= dout_3(7);
  dout(6) <= dout_3(6);
  dout(5) <= dout_3(5);
  dout(4) <= dout_3(4);
  dout(3) <= dout_3(3);
  dout(2) <= dout_3(2);
  dout(1) <= dout_3(1);
  dout(0) <= dout_3(0);
  din_2(15) <= din(15);
  din_2(14) <= din(14);
  din_2(13) <= din(13);
  din_2(12) <= din(12);
  din_2(11) <= din(11);
  din_2(10) <= din(10);
  din_2(9) <= din(9);
  din_2(8) <= din(8);
  din_2(7) <= din(7);
  din_2(6) <= din(6);
  din_2(5) <= din(5);
  din_2(4) <= din(4);
  din_2(3) <= din(3);
  din_2(2) <= din(2);
  din_2(1) <= din(1);
  din_2(0) <= din(0);
  VCC_0 : VCC
    port map (
      P => NLW_VCC_P_UNCONNECTED
    );
  GND_1 : GND
    port map (
      G => NLW_GND_G_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP : RAMB36_EXP
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_FILE => "NONE",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 4,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "ALL",
      SIM_MODE => "SAFE",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 4,
      WRITE_WIDTH_B => 36,
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ENAU => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENAL => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENBU => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      ENBL => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRAU => BU2_rd_data_count(0),
      SSRAL => BU2_rd_data_count(0),
      SSRBU => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      SSRBL => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      CLKAU => wr_clk,
      CLKAL => wr_clk,
      CLKBU => rd_clk,
      CLKBL => rd_clk,
      REGCLKAU => wr_clk,
      REGCLKAL => wr_clk,
      REGCLKBU => rd_clk,
      REGCLKBL => rd_clk,
      REGCEAU => BU2_rd_data_count(0),
      REGCEAL => BU2_rd_data_count(0),
      REGCEBU => BU2_rd_data_count(0),
      REGCEBL => BU2_rd_data_count(0),
      CASCADEINLATA => BU2_rd_data_count(0),
      CASCADEINLATB => BU2_rd_data_count(0),
      CASCADEINREGA => BU2_rd_data_count(0),
      CASCADEINREGB => BU2_rd_data_count(0),
      CASCADEOUTLATA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED
,
      CASCADEOUTLATB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED
,
      CASCADEOUTREGA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED
,
      CASCADEOUTREGB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED
,
      DIA(31) => BU2_rd_data_count(0),
      DIA(30) => BU2_rd_data_count(0),
      DIA(29) => BU2_rd_data_count(0),
      DIA(28) => BU2_rd_data_count(0),
      DIA(27) => BU2_rd_data_count(0),
      DIA(26) => BU2_rd_data_count(0),
      DIA(25) => BU2_rd_data_count(0),
      DIA(24) => BU2_rd_data_count(0),
      DIA(23) => BU2_rd_data_count(0),
      DIA(22) => BU2_rd_data_count(0),
      DIA(21) => BU2_rd_data_count(0),
      DIA(20) => BU2_rd_data_count(0),
      DIA(19) => BU2_rd_data_count(0),
      DIA(18) => BU2_rd_data_count(0),
      DIA(17) => BU2_rd_data_count(0),
      DIA(16) => BU2_rd_data_count(0),
      DIA(15) => BU2_rd_data_count(0),
      DIA(14) => BU2_rd_data_count(0),
      DIA(13) => BU2_rd_data_count(0),
      DIA(12) => BU2_rd_data_count(0),
      DIA(11) => BU2_rd_data_count(0),
      DIA(10) => BU2_rd_data_count(0),
      DIA(9) => BU2_rd_data_count(0),
      DIA(8) => BU2_rd_data_count(0),
      DIA(7) => BU2_rd_data_count(0),
      DIA(6) => BU2_rd_data_count(0),
      DIA(5) => BU2_rd_data_count(0),
      DIA(4) => BU2_rd_data_count(0),
      DIA(3) => din_2(15),
      DIA(2) => din_2(14),
      DIA(1) => din_2(13),
      DIA(0) => din_2(12),
      DIPA(3) => BU2_rd_data_count(0),
      DIPA(2) => BU2_rd_data_count(0),
      DIPA(1) => BU2_rd_data_count(0),
      DIPA(0) => BU2_rd_data_count(0),
      DIB(31) => BU2_rd_data_count(0),
      DIB(30) => BU2_rd_data_count(0),
      DIB(29) => BU2_rd_data_count(0),
      DIB(28) => BU2_rd_data_count(0),
      DIB(27) => BU2_rd_data_count(0),
      DIB(26) => BU2_rd_data_count(0),
      DIB(25) => BU2_rd_data_count(0),
      DIB(24) => BU2_rd_data_count(0),
      DIB(23) => BU2_rd_data_count(0),
      DIB(22) => BU2_rd_data_count(0),
      DIB(21) => BU2_rd_data_count(0),
      DIB(20) => BU2_rd_data_count(0),
      DIB(19) => BU2_rd_data_count(0),
      DIB(18) => BU2_rd_data_count(0),
      DIB(17) => BU2_rd_data_count(0),
      DIB(16) => BU2_rd_data_count(0),
      DIB(15) => BU2_rd_data_count(0),
      DIB(14) => BU2_rd_data_count(0),
      DIB(13) => BU2_rd_data_count(0),
      DIB(12) => BU2_rd_data_count(0),
      DIB(11) => BU2_rd_data_count(0),
      DIB(10) => BU2_rd_data_count(0),
      DIB(9) => BU2_rd_data_count(0),
      DIB(8) => BU2_rd_data_count(0),
      DIB(7) => BU2_rd_data_count(0),
      DIB(6) => BU2_rd_data_count(0),
      DIB(5) => BU2_rd_data_count(0),
      DIB(4) => BU2_rd_data_count(0),
      DIB(3) => BU2_rd_data_count(0),
      DIB(2) => BU2_rd_data_count(0),
      DIB(1) => BU2_rd_data_count(0),
      DIB(0) => BU2_rd_data_count(0),
      DIPB(3) => BU2_rd_data_count(0),
      DIPB(2) => BU2_rd_data_count(0),
      DIPB(1) => BU2_rd_data_count(0),
      DIPB(0) => BU2_rd_data_count(0),
      ADDRAL(15) => BU2_rd_data_count(0),
      ADDRAL(14) => BU2_rd_data_count(0),
      ADDRAL(13) => BU2_rd_data_count(0),
      ADDRAL(12) => BU2_rd_data_count(0),
      ADDRAL(11) => BU2_rd_data_count(0),
      ADDRAL(10) => BU2_rd_data_count(0),
      ADDRAL(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAL(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAL(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAL(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAL(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAL(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAL(1) => BU2_rd_data_count(0),
      ADDRAL(0) => BU2_rd_data_count(0),
      ADDRAU(14) => BU2_rd_data_count(0),
      ADDRAU(13) => BU2_rd_data_count(0),
      ADDRAU(12) => BU2_rd_data_count(0),
      ADDRAU(11) => BU2_rd_data_count(0),
      ADDRAU(10) => BU2_rd_data_count(0),
      ADDRAU(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAU(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAU(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAU(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAU(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAU(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAU(1) => BU2_rd_data_count(0),
      ADDRAU(0) => BU2_rd_data_count(0),
      ADDRBL(15) => BU2_rd_data_count(0),
      ADDRBL(14) => BU2_rd_data_count(0),
      ADDRBL(13) => BU2_rd_data_count(0),
      ADDRBL(12) => BU2_rd_data_count(0),
      ADDRBL(11) => BU2_rd_data_count(0),
      ADDRBL(10) => BU2_rd_data_count(0),
      ADDRBL(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBL(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBL(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBL(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBL(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBL(4) => BU2_rd_data_count(0),
      ADDRBL(3) => BU2_rd_data_count(0),
      ADDRBL(2) => BU2_rd_data_count(0),
      ADDRBL(1) => BU2_rd_data_count(0),
      ADDRBL(0) => BU2_rd_data_count(0),
      ADDRBU(14) => BU2_rd_data_count(0),
      ADDRBU(13) => BU2_rd_data_count(0),
      ADDRBU(12) => BU2_rd_data_count(0),
      ADDRBU(11) => BU2_rd_data_count(0),
      ADDRBU(10) => BU2_rd_data_count(0),
      ADDRBU(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBU(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBU(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBU(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBU(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBU(4) => BU2_rd_data_count(0),
      ADDRBU(3) => BU2_rd_data_count(0),
      ADDRBU(2) => BU2_rd_data_count(0),
      ADDRBU(1) => BU2_rd_data_count(0),
      ADDRBU(0) => BU2_rd_data_count(0),
      WEAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEBU(7) => BU2_rd_data_count(0),
      WEBU(6) => BU2_rd_data_count(0),
      WEBU(5) => BU2_rd_data_count(0),
      WEBU(4) => BU2_rd_data_count(0),
      WEBU(3) => BU2_rd_data_count(0),
      WEBU(2) => BU2_rd_data_count(0),
      WEBU(1) => BU2_rd_data_count(0),
      WEBU(0) => BU2_rd_data_count(0),
      WEBL(7) => BU2_rd_data_count(0),
      WEBL(6) => BU2_rd_data_count(0),
      WEBL(5) => BU2_rd_data_count(0),
      WEBL(4) => BU2_rd_data_count(0),
      WEBL(3) => BU2_rd_data_count(0),
      WEBL(2) => BU2_rd_data_count(0),
      WEBL(1) => BU2_rd_data_count(0),
      WEBL(0) => BU2_rd_data_count(0),
      DOA(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED,
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED,
      DOB(31) => dout_3(15),
      DOB(30) => dout_3(14),
      DOB(29) => dout_3(13),
      DOB(28) => dout_3(12),
      DOB(27) => dout_3(31),
      DOB(26) => dout_3(30),
      DOB(25) => dout_3(29),
      DOB(24) => dout_3(28),
      DOB(23) => dout_3(47),
      DOB(22) => dout_3(46),
      DOB(21) => dout_3(45),
      DOB(20) => dout_3(44),
      DOB(19) => dout_3(63),
      DOB(18) => dout_3(62),
      DOB(17) => dout_3(61),
      DOB(16) => dout_3(60),
      DOB(15) => dout_3(79),
      DOB(14) => dout_3(78),
      DOB(13) => dout_3(77),
      DOB(12) => dout_3(76),
      DOB(11) => dout_3(95),
      DOB(10) => dout_3(94),
      DOB(9) => dout_3(93),
      DOB(8) => dout_3(92),
      DOB(7) => dout_3(111),
      DOB(6) => dout_3(110),
      DOB(5) => dout_3(109),
      DOB(4) => dout_3(108),
      DOB(3) => dout_3(127),
      DOB(2) => dout_3(126),
      DOB(1) => dout_3(125),
      DOB(0) => dout_3(124),
      DOPB(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED,
      DOPB(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED,
      DOPB(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED,
      DOPB(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_3_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP : RAMB36_EXP
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_FILE => "NONE",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 4,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "ALL",
      SIM_MODE => "SAFE",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 4,
      WRITE_WIDTH_B => 36,
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ENAU => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENAL => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENBU => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      ENBL => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRAU => BU2_rd_data_count(0),
      SSRAL => BU2_rd_data_count(0),
      SSRBU => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      SSRBL => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      CLKAU => wr_clk,
      CLKAL => wr_clk,
      CLKBU => rd_clk,
      CLKBL => rd_clk,
      REGCLKAU => wr_clk,
      REGCLKAL => wr_clk,
      REGCLKBU => rd_clk,
      REGCLKBL => rd_clk,
      REGCEAU => BU2_rd_data_count(0),
      REGCEAL => BU2_rd_data_count(0),
      REGCEBU => BU2_rd_data_count(0),
      REGCEBL => BU2_rd_data_count(0),
      CASCADEINLATA => BU2_rd_data_count(0),
      CASCADEINLATB => BU2_rd_data_count(0),
      CASCADEINREGA => BU2_rd_data_count(0),
      CASCADEINREGB => BU2_rd_data_count(0),
      CASCADEOUTLATA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED
,
      CASCADEOUTLATB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED
,
      CASCADEOUTREGA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED
,
      CASCADEOUTREGB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED
,
      DIA(31) => BU2_rd_data_count(0),
      DIA(30) => BU2_rd_data_count(0),
      DIA(29) => BU2_rd_data_count(0),
      DIA(28) => BU2_rd_data_count(0),
      DIA(27) => BU2_rd_data_count(0),
      DIA(26) => BU2_rd_data_count(0),
      DIA(25) => BU2_rd_data_count(0),
      DIA(24) => BU2_rd_data_count(0),
      DIA(23) => BU2_rd_data_count(0),
      DIA(22) => BU2_rd_data_count(0),
      DIA(21) => BU2_rd_data_count(0),
      DIA(20) => BU2_rd_data_count(0),
      DIA(19) => BU2_rd_data_count(0),
      DIA(18) => BU2_rd_data_count(0),
      DIA(17) => BU2_rd_data_count(0),
      DIA(16) => BU2_rd_data_count(0),
      DIA(15) => BU2_rd_data_count(0),
      DIA(14) => BU2_rd_data_count(0),
      DIA(13) => BU2_rd_data_count(0),
      DIA(12) => BU2_rd_data_count(0),
      DIA(11) => BU2_rd_data_count(0),
      DIA(10) => BU2_rd_data_count(0),
      DIA(9) => BU2_rd_data_count(0),
      DIA(8) => BU2_rd_data_count(0),
      DIA(7) => BU2_rd_data_count(0),
      DIA(6) => BU2_rd_data_count(0),
      DIA(5) => BU2_rd_data_count(0),
      DIA(4) => BU2_rd_data_count(0),
      DIA(3) => din_2(11),
      DIA(2) => din_2(10),
      DIA(1) => din_2(9),
      DIA(0) => din_2(8),
      DIPA(3) => BU2_rd_data_count(0),
      DIPA(2) => BU2_rd_data_count(0),
      DIPA(1) => BU2_rd_data_count(0),
      DIPA(0) => BU2_rd_data_count(0),
      DIB(31) => BU2_rd_data_count(0),
      DIB(30) => BU2_rd_data_count(0),
      DIB(29) => BU2_rd_data_count(0),
      DIB(28) => BU2_rd_data_count(0),
      DIB(27) => BU2_rd_data_count(0),
      DIB(26) => BU2_rd_data_count(0),
      DIB(25) => BU2_rd_data_count(0),
      DIB(24) => BU2_rd_data_count(0),
      DIB(23) => BU2_rd_data_count(0),
      DIB(22) => BU2_rd_data_count(0),
      DIB(21) => BU2_rd_data_count(0),
      DIB(20) => BU2_rd_data_count(0),
      DIB(19) => BU2_rd_data_count(0),
      DIB(18) => BU2_rd_data_count(0),
      DIB(17) => BU2_rd_data_count(0),
      DIB(16) => BU2_rd_data_count(0),
      DIB(15) => BU2_rd_data_count(0),
      DIB(14) => BU2_rd_data_count(0),
      DIB(13) => BU2_rd_data_count(0),
      DIB(12) => BU2_rd_data_count(0),
      DIB(11) => BU2_rd_data_count(0),
      DIB(10) => BU2_rd_data_count(0),
      DIB(9) => BU2_rd_data_count(0),
      DIB(8) => BU2_rd_data_count(0),
      DIB(7) => BU2_rd_data_count(0),
      DIB(6) => BU2_rd_data_count(0),
      DIB(5) => BU2_rd_data_count(0),
      DIB(4) => BU2_rd_data_count(0),
      DIB(3) => BU2_rd_data_count(0),
      DIB(2) => BU2_rd_data_count(0),
      DIB(1) => BU2_rd_data_count(0),
      DIB(0) => BU2_rd_data_count(0),
      DIPB(3) => BU2_rd_data_count(0),
      DIPB(2) => BU2_rd_data_count(0),
      DIPB(1) => BU2_rd_data_count(0),
      DIPB(0) => BU2_rd_data_count(0),
      ADDRAL(15) => BU2_rd_data_count(0),
      ADDRAL(14) => BU2_rd_data_count(0),
      ADDRAL(13) => BU2_rd_data_count(0),
      ADDRAL(12) => BU2_rd_data_count(0),
      ADDRAL(11) => BU2_rd_data_count(0),
      ADDRAL(10) => BU2_rd_data_count(0),
      ADDRAL(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAL(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAL(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAL(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAL(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAL(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAL(1) => BU2_rd_data_count(0),
      ADDRAL(0) => BU2_rd_data_count(0),
      ADDRAU(14) => BU2_rd_data_count(0),
      ADDRAU(13) => BU2_rd_data_count(0),
      ADDRAU(12) => BU2_rd_data_count(0),
      ADDRAU(11) => BU2_rd_data_count(0),
      ADDRAU(10) => BU2_rd_data_count(0),
      ADDRAU(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAU(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAU(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAU(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAU(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAU(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAU(1) => BU2_rd_data_count(0),
      ADDRAU(0) => BU2_rd_data_count(0),
      ADDRBL(15) => BU2_rd_data_count(0),
      ADDRBL(14) => BU2_rd_data_count(0),
      ADDRBL(13) => BU2_rd_data_count(0),
      ADDRBL(12) => BU2_rd_data_count(0),
      ADDRBL(11) => BU2_rd_data_count(0),
      ADDRBL(10) => BU2_rd_data_count(0),
      ADDRBL(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBL(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBL(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBL(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBL(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBL(4) => BU2_rd_data_count(0),
      ADDRBL(3) => BU2_rd_data_count(0),
      ADDRBL(2) => BU2_rd_data_count(0),
      ADDRBL(1) => BU2_rd_data_count(0),
      ADDRBL(0) => BU2_rd_data_count(0),
      ADDRBU(14) => BU2_rd_data_count(0),
      ADDRBU(13) => BU2_rd_data_count(0),
      ADDRBU(12) => BU2_rd_data_count(0),
      ADDRBU(11) => BU2_rd_data_count(0),
      ADDRBU(10) => BU2_rd_data_count(0),
      ADDRBU(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBU(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBU(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBU(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBU(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBU(4) => BU2_rd_data_count(0),
      ADDRBU(3) => BU2_rd_data_count(0),
      ADDRBU(2) => BU2_rd_data_count(0),
      ADDRBU(1) => BU2_rd_data_count(0),
      ADDRBU(0) => BU2_rd_data_count(0),
      WEAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEBU(7) => BU2_rd_data_count(0),
      WEBU(6) => BU2_rd_data_count(0),
      WEBU(5) => BU2_rd_data_count(0),
      WEBU(4) => BU2_rd_data_count(0),
      WEBU(3) => BU2_rd_data_count(0),
      WEBU(2) => BU2_rd_data_count(0),
      WEBU(1) => BU2_rd_data_count(0),
      WEBU(0) => BU2_rd_data_count(0),
      WEBL(7) => BU2_rd_data_count(0),
      WEBL(6) => BU2_rd_data_count(0),
      WEBL(5) => BU2_rd_data_count(0),
      WEBL(4) => BU2_rd_data_count(0),
      WEBL(3) => BU2_rd_data_count(0),
      WEBL(2) => BU2_rd_data_count(0),
      WEBL(1) => BU2_rd_data_count(0),
      WEBL(0) => BU2_rd_data_count(0),
      DOA(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED,
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED,
      DOB(31) => dout_3(11),
      DOB(30) => dout_3(10),
      DOB(29) => dout_3(9),
      DOB(28) => dout_3(8),
      DOB(27) => dout_3(27),
      DOB(26) => dout_3(26),
      DOB(25) => dout_3(25),
      DOB(24) => dout_3(24),
      DOB(23) => dout_3(43),
      DOB(22) => dout_3(42),
      DOB(21) => dout_3(41),
      DOB(20) => dout_3(40),
      DOB(19) => dout_3(59),
      DOB(18) => dout_3(58),
      DOB(17) => dout_3(57),
      DOB(16) => dout_3(56),
      DOB(15) => dout_3(75),
      DOB(14) => dout_3(74),
      DOB(13) => dout_3(73),
      DOB(12) => dout_3(72),
      DOB(11) => dout_3(91),
      DOB(10) => dout_3(90),
      DOB(9) => dout_3(89),
      DOB(8) => dout_3(88),
      DOB(7) => dout_3(107),
      DOB(6) => dout_3(106),
      DOB(5) => dout_3(105),
      DOB(4) => dout_3(104),
      DOB(3) => dout_3(123),
      DOB(2) => dout_3(122),
      DOB(1) => dout_3(121),
      DOB(0) => dout_3(120),
      DOPB(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED,
      DOPB(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED,
      DOPB(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED,
      DOPB(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP : RAMB36_EXP
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_FILE => "NONE",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 4,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "ALL",
      SIM_MODE => "SAFE",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 4,
      WRITE_WIDTH_B => 36,
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ENAU => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENAL => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENBU => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      ENBL => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRAU => BU2_rd_data_count(0),
      SSRAL => BU2_rd_data_count(0),
      SSRBU => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      SSRBL => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      CLKAU => wr_clk,
      CLKAL => wr_clk,
      CLKBU => rd_clk,
      CLKBL => rd_clk,
      REGCLKAU => wr_clk,
      REGCLKAL => wr_clk,
      REGCLKBU => rd_clk,
      REGCLKBL => rd_clk,
      REGCEAU => BU2_rd_data_count(0),
      REGCEAL => BU2_rd_data_count(0),
      REGCEBU => BU2_rd_data_count(0),
      REGCEBL => BU2_rd_data_count(0),
      CASCADEINLATA => BU2_rd_data_count(0),
      CASCADEINLATB => BU2_rd_data_count(0),
      CASCADEINREGA => BU2_rd_data_count(0),
      CASCADEINREGB => BU2_rd_data_count(0),
      CASCADEOUTLATA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED
,
      CASCADEOUTLATB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED
,
      CASCADEOUTREGA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED
,
      CASCADEOUTREGB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED
,
      DIA(31) => BU2_rd_data_count(0),
      DIA(30) => BU2_rd_data_count(0),
      DIA(29) => BU2_rd_data_count(0),
      DIA(28) => BU2_rd_data_count(0),
      DIA(27) => BU2_rd_data_count(0),
      DIA(26) => BU2_rd_data_count(0),
      DIA(25) => BU2_rd_data_count(0),
      DIA(24) => BU2_rd_data_count(0),
      DIA(23) => BU2_rd_data_count(0),
      DIA(22) => BU2_rd_data_count(0),
      DIA(21) => BU2_rd_data_count(0),
      DIA(20) => BU2_rd_data_count(0),
      DIA(19) => BU2_rd_data_count(0),
      DIA(18) => BU2_rd_data_count(0),
      DIA(17) => BU2_rd_data_count(0),
      DIA(16) => BU2_rd_data_count(0),
      DIA(15) => BU2_rd_data_count(0),
      DIA(14) => BU2_rd_data_count(0),
      DIA(13) => BU2_rd_data_count(0),
      DIA(12) => BU2_rd_data_count(0),
      DIA(11) => BU2_rd_data_count(0),
      DIA(10) => BU2_rd_data_count(0),
      DIA(9) => BU2_rd_data_count(0),
      DIA(8) => BU2_rd_data_count(0),
      DIA(7) => BU2_rd_data_count(0),
      DIA(6) => BU2_rd_data_count(0),
      DIA(5) => BU2_rd_data_count(0),
      DIA(4) => BU2_rd_data_count(0),
      DIA(3) => din_2(7),
      DIA(2) => din_2(6),
      DIA(1) => din_2(5),
      DIA(0) => din_2(4),
      DIPA(3) => BU2_rd_data_count(0),
      DIPA(2) => BU2_rd_data_count(0),
      DIPA(1) => BU2_rd_data_count(0),
      DIPA(0) => BU2_rd_data_count(0),
      DIB(31) => BU2_rd_data_count(0),
      DIB(30) => BU2_rd_data_count(0),
      DIB(29) => BU2_rd_data_count(0),
      DIB(28) => BU2_rd_data_count(0),
      DIB(27) => BU2_rd_data_count(0),
      DIB(26) => BU2_rd_data_count(0),
      DIB(25) => BU2_rd_data_count(0),
      DIB(24) => BU2_rd_data_count(0),
      DIB(23) => BU2_rd_data_count(0),
      DIB(22) => BU2_rd_data_count(0),
      DIB(21) => BU2_rd_data_count(0),
      DIB(20) => BU2_rd_data_count(0),
      DIB(19) => BU2_rd_data_count(0),
      DIB(18) => BU2_rd_data_count(0),
      DIB(17) => BU2_rd_data_count(0),
      DIB(16) => BU2_rd_data_count(0),
      DIB(15) => BU2_rd_data_count(0),
      DIB(14) => BU2_rd_data_count(0),
      DIB(13) => BU2_rd_data_count(0),
      DIB(12) => BU2_rd_data_count(0),
      DIB(11) => BU2_rd_data_count(0),
      DIB(10) => BU2_rd_data_count(0),
      DIB(9) => BU2_rd_data_count(0),
      DIB(8) => BU2_rd_data_count(0),
      DIB(7) => BU2_rd_data_count(0),
      DIB(6) => BU2_rd_data_count(0),
      DIB(5) => BU2_rd_data_count(0),
      DIB(4) => BU2_rd_data_count(0),
      DIB(3) => BU2_rd_data_count(0),
      DIB(2) => BU2_rd_data_count(0),
      DIB(1) => BU2_rd_data_count(0),
      DIB(0) => BU2_rd_data_count(0),
      DIPB(3) => BU2_rd_data_count(0),
      DIPB(2) => BU2_rd_data_count(0),
      DIPB(1) => BU2_rd_data_count(0),
      DIPB(0) => BU2_rd_data_count(0),
      ADDRAL(15) => BU2_rd_data_count(0),
      ADDRAL(14) => BU2_rd_data_count(0),
      ADDRAL(13) => BU2_rd_data_count(0),
      ADDRAL(12) => BU2_rd_data_count(0),
      ADDRAL(11) => BU2_rd_data_count(0),
      ADDRAL(10) => BU2_rd_data_count(0),
      ADDRAL(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAL(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAL(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAL(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAL(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAL(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAL(1) => BU2_rd_data_count(0),
      ADDRAL(0) => BU2_rd_data_count(0),
      ADDRAU(14) => BU2_rd_data_count(0),
      ADDRAU(13) => BU2_rd_data_count(0),
      ADDRAU(12) => BU2_rd_data_count(0),
      ADDRAU(11) => BU2_rd_data_count(0),
      ADDRAU(10) => BU2_rd_data_count(0),
      ADDRAU(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAU(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAU(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAU(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAU(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAU(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAU(1) => BU2_rd_data_count(0),
      ADDRAU(0) => BU2_rd_data_count(0),
      ADDRBL(15) => BU2_rd_data_count(0),
      ADDRBL(14) => BU2_rd_data_count(0),
      ADDRBL(13) => BU2_rd_data_count(0),
      ADDRBL(12) => BU2_rd_data_count(0),
      ADDRBL(11) => BU2_rd_data_count(0),
      ADDRBL(10) => BU2_rd_data_count(0),
      ADDRBL(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBL(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBL(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBL(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBL(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBL(4) => BU2_rd_data_count(0),
      ADDRBL(3) => BU2_rd_data_count(0),
      ADDRBL(2) => BU2_rd_data_count(0),
      ADDRBL(1) => BU2_rd_data_count(0),
      ADDRBL(0) => BU2_rd_data_count(0),
      ADDRBU(14) => BU2_rd_data_count(0),
      ADDRBU(13) => BU2_rd_data_count(0),
      ADDRBU(12) => BU2_rd_data_count(0),
      ADDRBU(11) => BU2_rd_data_count(0),
      ADDRBU(10) => BU2_rd_data_count(0),
      ADDRBU(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBU(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBU(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBU(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBU(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBU(4) => BU2_rd_data_count(0),
      ADDRBU(3) => BU2_rd_data_count(0),
      ADDRBU(2) => BU2_rd_data_count(0),
      ADDRBU(1) => BU2_rd_data_count(0),
      ADDRBU(0) => BU2_rd_data_count(0),
      WEAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEBU(7) => BU2_rd_data_count(0),
      WEBU(6) => BU2_rd_data_count(0),
      WEBU(5) => BU2_rd_data_count(0),
      WEBU(4) => BU2_rd_data_count(0),
      WEBU(3) => BU2_rd_data_count(0),
      WEBU(2) => BU2_rd_data_count(0),
      WEBU(1) => BU2_rd_data_count(0),
      WEBU(0) => BU2_rd_data_count(0),
      WEBL(7) => BU2_rd_data_count(0),
      WEBL(6) => BU2_rd_data_count(0),
      WEBL(5) => BU2_rd_data_count(0),
      WEBL(4) => BU2_rd_data_count(0),
      WEBL(3) => BU2_rd_data_count(0),
      WEBL(2) => BU2_rd_data_count(0),
      WEBL(1) => BU2_rd_data_count(0),
      WEBL(0) => BU2_rd_data_count(0),
      DOA(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED,
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED,
      DOB(31) => dout_3(7),
      DOB(30) => dout_3(6),
      DOB(29) => dout_3(5),
      DOB(28) => dout_3(4),
      DOB(27) => dout_3(23),
      DOB(26) => dout_3(22),
      DOB(25) => dout_3(21),
      DOB(24) => dout_3(20),
      DOB(23) => dout_3(39),
      DOB(22) => dout_3(38),
      DOB(21) => dout_3(37),
      DOB(20) => dout_3(36),
      DOB(19) => dout_3(55),
      DOB(18) => dout_3(54),
      DOB(17) => dout_3(53),
      DOB(16) => dout_3(52),
      DOB(15) => dout_3(71),
      DOB(14) => dout_3(70),
      DOB(13) => dout_3(69),
      DOB(12) => dout_3(68),
      DOB(11) => dout_3(87),
      DOB(10) => dout_3(86),
      DOB(9) => dout_3(85),
      DOB(8) => dout_3(84),
      DOB(7) => dout_3(103),
      DOB(6) => dout_3(102),
      DOB(5) => dout_3(101),
      DOB(4) => dout_3(100),
      DOB(3) => dout_3(119),
      DOB(2) => dout_3(118),
      DOB(1) => dout_3(117),
      DOB(0) => dout_3(116),
      DOPB(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED,
      DOPB(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED,
      DOPB(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED,
      DOPB(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP : RAMB36_EXP
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_FILE => "NONE",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 4,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "ALL",
      SIM_MODE => "SAFE",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 4,
      WRITE_WIDTH_B => 36,
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000"
    )
    port map (
      ENAU => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENAL => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      ENBU => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      ENBL => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRAU => BU2_rd_data_count(0),
      SSRAL => BU2_rd_data_count(0),
      SSRBU => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      SSRBL => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      CLKAU => wr_clk,
      CLKAL => wr_clk,
      CLKBU => rd_clk,
      CLKBL => rd_clk,
      REGCLKAU => wr_clk,
      REGCLKAL => wr_clk,
      REGCLKBU => rd_clk,
      REGCLKBL => rd_clk,
      REGCEAU => BU2_rd_data_count(0),
      REGCEAL => BU2_rd_data_count(0),
      REGCEBU => BU2_rd_data_count(0),
      REGCEBL => BU2_rd_data_count(0),
      CASCADEINLATA => BU2_rd_data_count(0),
      CASCADEINLATB => BU2_rd_data_count(0),
      CASCADEINREGA => BU2_rd_data_count(0),
      CASCADEINREGB => BU2_rd_data_count(0),
      CASCADEOUTLATA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATA_UNCONNECTED
,
      CASCADEOUTLATB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTLATB_UNCONNECTED
,
      CASCADEOUTREGA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGA_UNCONNECTED
,
      CASCADEOUTREGB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_CASCADEOUTREGB_UNCONNECTED
,
      DIA(31) => BU2_rd_data_count(0),
      DIA(30) => BU2_rd_data_count(0),
      DIA(29) => BU2_rd_data_count(0),
      DIA(28) => BU2_rd_data_count(0),
      DIA(27) => BU2_rd_data_count(0),
      DIA(26) => BU2_rd_data_count(0),
      DIA(25) => BU2_rd_data_count(0),
      DIA(24) => BU2_rd_data_count(0),
      DIA(23) => BU2_rd_data_count(0),
      DIA(22) => BU2_rd_data_count(0),
      DIA(21) => BU2_rd_data_count(0),
      DIA(20) => BU2_rd_data_count(0),
      DIA(19) => BU2_rd_data_count(0),
      DIA(18) => BU2_rd_data_count(0),
      DIA(17) => BU2_rd_data_count(0),
      DIA(16) => BU2_rd_data_count(0),
      DIA(15) => BU2_rd_data_count(0),
      DIA(14) => BU2_rd_data_count(0),
      DIA(13) => BU2_rd_data_count(0),
      DIA(12) => BU2_rd_data_count(0),
      DIA(11) => BU2_rd_data_count(0),
      DIA(10) => BU2_rd_data_count(0),
      DIA(9) => BU2_rd_data_count(0),
      DIA(8) => BU2_rd_data_count(0),
      DIA(7) => BU2_rd_data_count(0),
      DIA(6) => BU2_rd_data_count(0),
      DIA(5) => BU2_rd_data_count(0),
      DIA(4) => BU2_rd_data_count(0),
      DIA(3) => din_2(3),
      DIA(2) => din_2(2),
      DIA(1) => din_2(1),
      DIA(0) => din_2(0),
      DIPA(3) => BU2_rd_data_count(0),
      DIPA(2) => BU2_rd_data_count(0),
      DIPA(1) => BU2_rd_data_count(0),
      DIPA(0) => BU2_rd_data_count(0),
      DIB(31) => BU2_rd_data_count(0),
      DIB(30) => BU2_rd_data_count(0),
      DIB(29) => BU2_rd_data_count(0),
      DIB(28) => BU2_rd_data_count(0),
      DIB(27) => BU2_rd_data_count(0),
      DIB(26) => BU2_rd_data_count(0),
      DIB(25) => BU2_rd_data_count(0),
      DIB(24) => BU2_rd_data_count(0),
      DIB(23) => BU2_rd_data_count(0),
      DIB(22) => BU2_rd_data_count(0),
      DIB(21) => BU2_rd_data_count(0),
      DIB(20) => BU2_rd_data_count(0),
      DIB(19) => BU2_rd_data_count(0),
      DIB(18) => BU2_rd_data_count(0),
      DIB(17) => BU2_rd_data_count(0),
      DIB(16) => BU2_rd_data_count(0),
      DIB(15) => BU2_rd_data_count(0),
      DIB(14) => BU2_rd_data_count(0),
      DIB(13) => BU2_rd_data_count(0),
      DIB(12) => BU2_rd_data_count(0),
      DIB(11) => BU2_rd_data_count(0),
      DIB(10) => BU2_rd_data_count(0),
      DIB(9) => BU2_rd_data_count(0),
      DIB(8) => BU2_rd_data_count(0),
      DIB(7) => BU2_rd_data_count(0),
      DIB(6) => BU2_rd_data_count(0),
      DIB(5) => BU2_rd_data_count(0),
      DIB(4) => BU2_rd_data_count(0),
      DIB(3) => BU2_rd_data_count(0),
      DIB(2) => BU2_rd_data_count(0),
      DIB(1) => BU2_rd_data_count(0),
      DIB(0) => BU2_rd_data_count(0),
      DIPB(3) => BU2_rd_data_count(0),
      DIPB(2) => BU2_rd_data_count(0),
      DIPB(1) => BU2_rd_data_count(0),
      DIPB(0) => BU2_rd_data_count(0),
      ADDRAL(15) => BU2_rd_data_count(0),
      ADDRAL(14) => BU2_rd_data_count(0),
      ADDRAL(13) => BU2_rd_data_count(0),
      ADDRAL(12) => BU2_rd_data_count(0),
      ADDRAL(11) => BU2_rd_data_count(0),
      ADDRAL(10) => BU2_rd_data_count(0),
      ADDRAL(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAL(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAL(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAL(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAL(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAL(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAL(1) => BU2_rd_data_count(0),
      ADDRAL(0) => BU2_rd_data_count(0),
      ADDRAU(14) => BU2_rd_data_count(0),
      ADDRAU(13) => BU2_rd_data_count(0),
      ADDRAU(12) => BU2_rd_data_count(0),
      ADDRAU(11) => BU2_rd_data_count(0),
      ADDRAU(10) => BU2_rd_data_count(0),
      ADDRAU(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRAU(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRAU(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRAU(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRAU(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRAU(4) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRAU(1) => BU2_rd_data_count(0),
      ADDRAU(0) => BU2_rd_data_count(0),
      ADDRBL(15) => BU2_rd_data_count(0),
      ADDRBL(14) => BU2_rd_data_count(0),
      ADDRBL(13) => BU2_rd_data_count(0),
      ADDRBL(12) => BU2_rd_data_count(0),
      ADDRBL(11) => BU2_rd_data_count(0),
      ADDRBL(10) => BU2_rd_data_count(0),
      ADDRBL(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBL(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBL(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBL(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBL(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBL(4) => BU2_rd_data_count(0),
      ADDRBL(3) => BU2_rd_data_count(0),
      ADDRBL(2) => BU2_rd_data_count(0),
      ADDRBL(1) => BU2_rd_data_count(0),
      ADDRBL(0) => BU2_rd_data_count(0),
      ADDRBU(14) => BU2_rd_data_count(0),
      ADDRBU(13) => BU2_rd_data_count(0),
      ADDRBU(12) => BU2_rd_data_count(0),
      ADDRBU(11) => BU2_rd_data_count(0),
      ADDRBU(10) => BU2_rd_data_count(0),
      ADDRBU(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRBU(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRBU(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRBU(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRBU(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRBU(4) => BU2_rd_data_count(0),
      ADDRBU(3) => BU2_rd_data_count(0),
      ADDRBU(2) => BU2_rd_data_count(0),
      ADDRBU(1) => BU2_rd_data_count(0),
      ADDRBU(0) => BU2_rd_data_count(0),
      WEAU(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAU(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEAL(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEBU(7) => BU2_rd_data_count(0),
      WEBU(6) => BU2_rd_data_count(0),
      WEBU(5) => BU2_rd_data_count(0),
      WEBU(4) => BU2_rd_data_count(0),
      WEBU(3) => BU2_rd_data_count(0),
      WEBU(2) => BU2_rd_data_count(0),
      WEBU(1) => BU2_rd_data_count(0),
      WEBU(0) => BU2_rd_data_count(0),
      WEBL(7) => BU2_rd_data_count(0),
      WEBL(6) => BU2_rd_data_count(0),
      WEBL(5) => BU2_rd_data_count(0),
      WEBL(4) => BU2_rd_data_count(0),
      WEBL(3) => BU2_rd_data_count(0),
      WEBL(2) => BU2_rd_data_count(0),
      WEBL(1) => BU2_rd_data_count(0),
      WEBL(0) => BU2_rd_data_count(0),
      DOA(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOA_0_UNCONNECTED,
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPA_0_UNCONNECTED,
      DOB(31) => dout_3(3),
      DOB(30) => dout_3(2),
      DOB(29) => dout_3(1),
      DOB(28) => dout_3(0),
      DOB(27) => dout_3(19),
      DOB(26) => dout_3(18),
      DOB(25) => dout_3(17),
      DOB(24) => dout_3(16),
      DOB(23) => dout_3(35),
      DOB(22) => dout_3(34),
      DOB(21) => dout_3(33),
      DOB(20) => dout_3(32),
      DOB(19) => dout_3(51),
      DOB(18) => dout_3(50),
      DOB(17) => dout_3(49),
      DOB(16) => dout_3(48),
      DOB(15) => dout_3(67),
      DOB(14) => dout_3(66),
      DOB(13) => dout_3(65),
      DOB(12) => dout_3(64),
      DOB(11) => dout_3(83),
      DOB(10) => dout_3(82),
      DOB(9) => dout_3(81),
      DOB(8) => dout_3(80),
      DOB(7) => dout_3(99),
      DOB(6) => dout_3(98),
      DOB(5) => dout_3(97),
      DOB(4) => dout_3(96),
      DOB(3) => dout_3(115),
      DOB(2) => dout_3(114),
      DOB(1) => dout_3(113),
      DOB(0) => dout_3(112),
      DOPB(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_3_UNCONNECTED,
      DOPB(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_2_UNCONNECTED,
      DOPB(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_1_UNCONNECTED,
      DOPB(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v5_noinit_ram_SDP_SINGLE_PRIM36_TDP_DOPB_0_UNCONNECTED
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_0_11_INV_0 : INV
    port map (
      I => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0003_Result1 : LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I4 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0002_Result1 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000067 : LUT6
    generic map(
      INIT => X"0020000200000000"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_158,
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      I5 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000033_308,
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000067_313
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000036 : LUT6
    generic map(
      INIT => X"2002000000002002"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_155,
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      I5 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(7),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000036_307
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0001_Result1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(7),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_7_rt_282
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_295
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_294
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_292
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_290
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_288
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_286
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(6),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_284
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000281 : LUT5
    generic map(
      INIT => X"54504400"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_RST_FULL_GEN_160,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000190_310,
      I2 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000125_309,
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000242_312,
      I4 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000067_313,
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000242 : LUT4
    generic map(
      INIT => X"4100"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000224_311,
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000242_312
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000224 : LUT4
    generic map(
      INIT => X"0009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000224_311
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000190 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      I5 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000190_310
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000125 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(7),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      I4 => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      I5 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000125_309
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000033 : LUT4
    generic map(
      INIT => X"0009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux000033_308
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_bin_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000192 : LUT4
    generic map(
      INIT => X"EAC0"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000126_305,
      I1 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000036_307,
      I2 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000086_304,
      I3 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000176_306,
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000176 : LUT6
    generic map(
      INIT => X"8040201008040201"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(6),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I5 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000176_306
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000126 : LUT4
    generic map(
      INIT => X"8241"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(7),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000126_305
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000086 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(6),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I5 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or000086_304
    );
  BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_158,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001
    );
  BU2_U0_grf_rf_gl0_rd_ram_rd_en_i1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_155,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001
    );
  BU2_U0_grf_rf_mem_tmp_ram_rd_en1 : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_155,
      I1 => rd_en,
      I2 => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      O => BU2_U0_grf_rf_mem_tmp_ram_rd_en
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_4_11 : LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I4 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00031 : LUT5
    generic map(
      INIT => X"96696996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I4 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_3_11 : LUT4
    generic map(
      INIT => X"6AAA"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00021 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_2_11 : LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00011 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0003_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0003_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0004_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0005_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0005
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0006_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0006
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_1_11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00001 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_rstblk_rd_rst_comb1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_166,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_162,
      O => BU2_U0_grf_rf_rstblk_rd_rst_comb
    );
  BU2_U0_grf_rf_rstblk_wr_rst_comb1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_167,
      I1 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_164,
      O => BU2_U0_grf_rf_rstblk_wr_rst_comb
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_295,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_0_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_295,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(0),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_294,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_1_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(0),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_294,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(1),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_292,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_2_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(1),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_292,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(2),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_290,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(2),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_290,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(3),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_288,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(3),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_288,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(4),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_286,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(4),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_286,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(5),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_284,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(5),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_284,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(6),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_7_rt_282,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count7
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_1 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count7,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(7)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(7),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(6),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0006,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0005,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(7)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(0),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(1),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(2),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(0),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(1),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(2),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(4),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(6),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(7),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(7)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(0),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(1),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(2),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(4),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(6),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(7),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(7)
    );
  BU2_U0_grf_rf_rstblk_wr_rst_reg_0 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_reg(0)
    );
  BU2_U0_grf_rf_rstblk_wr_rst_reg_1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_reg(1)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_0 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(0)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(1)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_2 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(2)
    );
  BU2_U0_grf_rf_rstblk_rst_d1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d1_165
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg : FDPE
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_161,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_166
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_167,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_163
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg : FDPE
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_163,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_167
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_166,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_161
    );
  BU2_U0_grf_rf_rstblk_rst_d2 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_rst_d1_165,
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d2_157
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_163,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_164
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_161,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_162
    );
  BU2_U0_grf_rf_rstblk_rst_d3 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_rst_d2_157,
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rst_d3_159
    );
  BU2_U0_grf_rf_rstblk_RST_FULL_GEN : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => rst,
      D => BU2_U0_grf_rf_rstblk_rst_d3_159,
      Q => BU2_U0_grf_rf_rstblk_RST_FULL_GEN_160
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rst_d2_157,
      Q => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_158
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rst_d2_157,
      Q => full
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => empty
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_155
    );
  BU2_XST_VCC : VCC
    port map (
      P => BU2_N1
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_rd_data_count(0)
    );

end STRUCTURE;

-- synthesis translate_on
