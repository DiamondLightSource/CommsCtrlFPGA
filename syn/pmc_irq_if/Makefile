# Make sure Xilinx specific variables are initialized
ifndef XILINX
   $(error Run "home/share/Xilinx71/settings.sh" first!)
endif

# make sure FPGA_DESIGN is set to a valid design name: pmc OR sniffer
ifndef FPGA_DESIGN
   $(error Set FPGA_DESIGN to target design first (pmc or bpm)!)
endif

# Diretory for saving the final designs
ifndef XILINX_OUT_DIR
   XILINX_OUT_DIR = ../out/
endif
# prepare output dir	
COPY := $(shell /bin/mkdir -p $(XILINX_OUT_DIR) )

###################### user affectable parameter ends here #############

# override complains about Language settings
LANGUAGE=usenglish

# needed for unique design naming
TIMESTAMP :=$(shell /bin/date +%Y%m%d_%H%M)

.PHONY: clean design_save test pmc_irq_if.lst xst_dumpdirs

main: pmc_irq_if.bin 

clean:
	rm -rf ../run/*

design_save:
	cp pmc_irq_if.bin ../out/libera_${FPGA_DESIGN}_${TIMESTAMP}.bin
	cp pmc_irq_if.twr ../out/libera_${FPGA_DESIGN}_${TIMESTAMP}.twr
	mkdir /dls_sw/work/hardware/Libera/isa/fpga/pmc/${FPGA_VER}
	cp pmc_irq_if.bit /dls_sw/work/hardware/Libera/isa/fpga/pmc/${FPGA_VER}/

pmc_irq_if.lst:
	/bin/echo "vhdl work ../../../rtl/fofb_cc_pkg/rtl/vhdl/fofb_cc_conf_$(FPGA_DESIGN).vhd" > pmc_irq_if.lst
	-/bin/cat "../xilinx/fofb_cc_top.lst" >> pmc_irq_if.lst
	-/bin/cat "../xilinx/pmc_common.lst" >> pmc_irq_if.lst

pmc_irq_if.bit: pmc_irq_if.ncd
	bitgen -intstyle xflow -w -g DebugBitstream:No -g Binary:no -g CRC:Enable -g ConfigRate:4 -g CclkPin:PullUp -g M0Pin:PullUp -g M1Pin:PullUp -g M2Pin:PullUp -g ProgPin:PullUp -g DonePin:PullUp -g PowerdownPin:PullUp -g TckPin:PullUp -g TdiPin:PullUp -g TdoPin:PullUp -g TmsPin:PullUp -g UnusedPin:PullDown -g UserID:0xFFFFFFFF -g DCMShutDown:Disable -g DisableBandgap:No -g DCIUpdateMode:AsRequired -g StartUpClk:CClk -g DONE_cycle:4 -g GTS_cycle:5 -g GWE_cycle:6 -g LCK_cycle:NoWait -g Security:None -g DonePipe:No -g DriveDone:No -g Encrypt:No pmc_irq_if.ncd

pmc_irq_if.hex: pmc_irq_if.bit
	promgen -w -p hex -o pmc_irq_if.hex -u 0 pmc_irq_if.bit

pmc_irq_if.bin: pmc_irq_if.hex
	$(TOP)/virtexHex2Bin < pmc_irq_if.hex > pmc_irq_if.bin

PAR_FLAGS := -ol high
pmc_irq_if.ncd: pmc_irq_if_map.ncd
	par -w -intstyle xflow $(PAR_FLAGS) pmc_irq_if_map.ncd pmc_irq_if.ncd pmc_irq_if.pcf
	trce -intstyle xflow -e 3 -l 3 -s 5 -xml pmc_irq_if pmc_irq_if.ncd -o pmc_irq_if.twr pmc_irq_if.pcf

MAP_FLAGS := 
pmc_irq_if_map.ncd: pmc_irq_if.ngd 
	map -intstyle xflow -p xc2vp30-ff896-6 -cm balanced -pr b $(MAP_FLAGS) -o pmc_irq_if_map.ncd pmc_irq_if.ngd pmc_irq_if.pcf

#FFA_NETLIST_LOC := ./
pmc_irq_if.ngd: pmc_irq_if.ngc pmc_irq_if.ucf
	ngdbuild -intstyle xflow -dd "./_ngo" -nt timestamp -uc pmc_irq_if.ucf -p xc2vp30-ff896-6 -sd ../../../rtl/chipscope -sd ../../../rtl/fofb_cc_rx_fifo/coregen/ -sd ../../../rtl/fofb_cc_tx_fifo/coregen/ pmc_irq_if.ngc pmc_irq_if.ngd

pmc_irq_if.ucf:
	/bin/cat ../constr/pmc_irq_if.ucf      > pmc_irq_if.ucf
	/bin/cat ../constr/mgt.ucf             >> pmc_irq_if.ucf

xst_dumpdirs:
	-rm -rf ./xst_tmpdir
	-rm -rf ./xst_dumpdir
	mkdir ./xst_tmpdir
	mkdir ./xst_dumpdir

#### potrebno poraviti, da je dependance od vseh .v filejev
ALL_RTL := $(shell find ../../../rtl/ -name "*.vhd")
pmc_irq_if.ngc: $(ALL_RTL) pmc_irq_if.lst xst_dumpdirs ../constr/pmc_irq_if.xcf
	xst -ifn ../xilinx/xst.scr






