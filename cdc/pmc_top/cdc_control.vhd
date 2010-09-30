entity cdc_ctrl is
end;

architecture ctrl of cdc_ctrl is
begin

-- 0in set_cdc_clock brefclk_p_i
-- 0in set_cdc_clock brefclk_n_i
-- 0in set_cdc_clock lclk_i
-- 0in set_cdc_clock i_dcm_lclk.clkfb_in
-- 0in set_cdc_clock i_fofb_cc_top_wrapper.i_fofb_cc_top.i_fofb_cc_clk_if.userclk

-- 0in set_black_box fofb_cc_dpbram
-- 0in set_black_box fofb_cc_sdpbram

-- 0in set_cdc_reconvergence -depth 5 -divergence_depth 5

-- 0in set_cdc_port_domain addra   -clock clka -module fofb_cc_dpbram
-- 0in set_cdc_port_domain dina    -clock clka -module fofb_cc_dpbram
-- 0in set_cdc_port_domain wea     -clock clka -module fofb_cc_dpbram
-- 0in set_cdc_port_domain douta   -clock clka -module fofb_cc_dpbram
-- 0in set_cdc_port_domain addrb   -clock clkb -module fofb_cc_dpbram
-- 0in set_cdc_port_domain dinb    -clock clkb -module fofb_cc_dpbram
-- 0in set_cdc_port_domain web     -clock clkb -module fofb_cc_dpbram
-- 0in set_cdc_port_domain doutb   -clock clkb -module fofb_cc_dpbram

-- 0in set_cdc_port_domain addra   -clock clka -module fofb_cc_sdpbram
-- 0in set_cdc_port_domain dina    -clock clka -module fofb_cc_sdpbram
-- 0in set_cdc_port_domain wea     -clock clka -module fofb_cc_sdpbram
-- 0in set_cdc_port_domain addrb   -clock clkb -module fofb_cc_sdpbram
-- 0in set_cdc_port_domain doutb   -clock clkb -module fofb_cc_sdpbram


end ctrl;
