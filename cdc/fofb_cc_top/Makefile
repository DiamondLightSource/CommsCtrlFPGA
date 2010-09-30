PATH:=$(PATH):/dls_sw/apps/FPGA/Questa/6.5b/questasim/linux:/dls_sw/apps/FPGA/0-In/V2.6n/suse9_x86/bin

export HOME_0IN=/dls_sw/apps/FPGA/0-In/V2.6n/suse9_x86

#####################################################################
#
# DUT Sources
#
#########################################################################
#
DUT=fofb_cc_top
SRCLIST=compile.lst
CTRLFILE=cdc_control.vhd
DB = run/0in_cdc.db


#########################################################################
#
#
# Make Targets
#
#########################################################################

all:     compile \
         cdc

compile:
	0in -od run -cmd analyze \
	-vhf $(SRCLIST) \
	-vhdl

#	vlib work
#	vmap work work
#	$(HOME_0IN)/modeltech/bin/vcom -f $(SRCLIST) | tee vcom.log

report_clock:
	0in -od run -cmd cdc \
	-d $(DUT) \
	-vhctrl $(CTRLFILE) \
	-report_clock

cdc:
	0in -od run -cmd cdc \
    -d $(DUT) \
    -vhctrl $(CTRLFILE)

view:
	0in_cdc $(DB)

cdcui:
	0in_cdc -p myproj -d $(DUT) \
    -vhf $(SRCLIST) -vhctrl $(CTRLFILE) \

clean:
	0in_clean
	rm -rf run
	rm -rf work transcript vcom.log vlog.log modelsim.ini
	rm -rf myproj myproj.zpf

