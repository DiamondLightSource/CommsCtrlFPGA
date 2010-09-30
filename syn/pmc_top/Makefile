export FPGA_DESIGN = pmc

# Set ISE 7.1 environment variable for v2p support
ISE = source /dls_sw/apps/FPGA/Xilinx/7.1/ISE/settings.sh
#ISE = source /dls_sw/apps/FPGA/Xilinx/10.1/ISE/settings32.sh

# Print the names of unlocked (unconstrainted) IOs
export XIL_PAR_DESIGN_CHECK_VERBOSE=1

NGDBUILD_OPTIONS = -aul -verbose
MAP_OPTIONS      = -ol high
PAR_OPTIONS      = -ol high -w
TRCE_OPTIONS     =
BITGEN_OPTIONS   = -w

main: all

#$(VERSION_FILE):
#	echo 'library ieee;' >>$@
#	echo 'use ieee.std_logic_1164.all;' >>$@
#	echo 'package fofb_cc_version is' >>$@
#	echo -n 'constant FPGAFirmwareVersion: std_logic_vector(31 downto 0)' \
#	        >>$@
#	echo ' := X"$(FPGA_VER)";' >>$@
#	echo 'end fofb_cc_version;' >>$@

clean:
	rm -rf ../run/*

design_save:
	mkdir /dls_sw/work/hardware/Libera/isa/fpga/pmc/${FPGA_VER}
	cp pmc_top.bit /dls_sw/work/hardware/Libera/isa/fpga/pmc/${FPGA_VER}/

xst_dumpdirs:
	-rm -rf ./xst_tmpdir
	-rm -rf ./xst_dumpdir
	mkdir ./xst_tmpdir
	mkdir ./xst_dumpdir

pmc_top.lst:
	-/bin/cat "../xilinx/fofb_cc_top.lst" >> pmc_top.lst
	-/bin/cat "../xilinx/pmc_common.lst" >> pmc_top.lst

pmc_top.ucf:
	/bin/cat ../constr/pmc_top.ucf > pmc_top.ucf
	/bin/cat ../constr/mgt.ucf     >> pmc_top.ucf

pmc_top.bit:
	$(ISE) && bitgen $(BITGEN_OPTIONS) pmc_top.ncd

pmc_top.ncd:
	$(ISE) && par $(PAR_OPTIONS) pmc_top_map.ncd pmc_top.ncd pmc_top.pcf
#	trce -intstyle xflow -e 3 -l 3 -s 5 -xml pmc_top pmc_top.ncd -o pmc_top.twr pmc_top.pcf

pmc_top_map.ncd:
	$(ISE) && map $(MAP_OPTIONS) -o pmc_top_map.ncd pmc_top.ngd pmc_top.pcf

pmc_top.ngd: pmc_top.ucf
	$(ISE) && ngdbuild $(NGDBUILD_OPTIONS) -uc pmc_top.ucf pmc_top.ngc -sd ../../../rtl/chipscope/virtex2pro -sd ../../../rtl/fofb_cc_rx_fifo/coregen/virtex2pro -sd ../../../rtl/fofb_cc_tx_fifo/coregen/virtex2pro

pmc_top.ngc: pmc_top.lst xst_dumpdirs $(VERSION_FILE)
	$(ISE) && xst -ifn ../xilinx/xst.scr

all: clean pmc_top.ngc pmc_top.ngd pmc_top_map.ncd pmc_top.ncd pmc_top.bit
