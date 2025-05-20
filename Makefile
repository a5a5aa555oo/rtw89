# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

ifneq ($(KERNELRELEASE),)

obj-m += rtw89.o
rtw89-y +=	core.o \
		mac80211.o \
		mac.o \
		phy.o \
		fw.o \
		cam.o \
		efuse.o \
		regd.o \
		sar.o \
		coex.o \
		ps.o \
		chan.o \
		ser.o \
		acpi.o \
		pci.o \
		debug.o

rtw89-$(CONFIG_PM) += wow.o

obj-m += rtw_8851b.o
rtw_8851b-objs := rtw8851b.o \
		  rtw8851b_table.o \
		  rtw8851b_rfk.o \
		  rtw8851b_rfk_table.o

obj-m += rtw_8851be.o
rtw_8851be-objs := rtw8851be.o

obj-m += rtw_8852a.o
rtw_8852a-objs := rtw8852a.o \
		  rtw8852a_table.o \
		  rtw8852a_rfk.o \
		  rtw8852a_rfk_table.o

obj-m += rtw_8852ae.o
rtw_8852ae-objs := rtw8852ae.o

obj-m += rtw_8852b.o
rtw_8852b-objs := rtw8852b.o \
		  rtw8852b_table.o \
		  rtw8852b_rfk.o \
		  rtw8852b_rfk_table.o

obj-m += rtw_8852be.o
rtw_8852be-objs := rtw8852be.o

obj-m += rtw_8852c.o
rtw_8852c-objs := rtw8852c.o \
		  rtw8852c_table.o \
		  rtw8852c_rfk.o \
		  rtw8852c_rfk_table.o

obj-m += rtw_8852ce.o
rtw_8852ce-objs := rtw8852ce.o

else

KVER ?= `uname -r`
KDIR ?= /lib/modules/$(KVER)/build
MODDIR ?= /lib/modules/$(KVER)/extra/rtw89
FWDIR := /lib/firmware/rtw89
NPROC ?= `nproc --ignore=1`

.PHONY: modules clean cleanup_target_system install install_fw uninstall

modules:
	$(MAKE) -j$(NPROC) -C $(KDIR) M=$$PWD modules

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean

cleanup_target_system:
	find /lib/modules/$(KVER) -name "rtw89core*" -exec rm -fv {} \;
	find /lib/modules/$(KVER) -name "rtw89pci*" -exec rm -fv {} \;
	find /lib/modules/$(KVER) -name "rtw_885*" -exec rm -fv {} \;
	find /lib/modules/$(KVER) -name "rtw_89*" -exec rm -fv {} \;
	depmod -a $(KVER)

install:
	@strip -g *.ko
	@install -Dvm 644 -t $(MODDIR) *.ko
	depmod -a $(KVER)

install_fw:
ifeq ($(wildcard $(FWDIR)), )
	@install -Dvm 644 -t $(FWDIR) firmware/*.bin
else
	@cp -r firmware tmp
ifneq ($(wildcard $(FWDIR)/*.zst), )
	@zstd -fq --rm tmp/*.bin
endif
ifneq ($(wildcard $(FWDIR)/*.xz), )
	@xz -f -C crc32 tmp/*.bin
endif
ifneq ($(wildcard $(FWDIR)/*.gz), )
	@gzip -f tmp/*.bin
endif
	@install -Dvm 644 -t $(FWDIR) tmp/rtw*
	@rm -rf tmp
endif

uninstall:
	@rm -rvf $(MODDIR)
	@rmdir -v --ignore-fail-on-non-empty /lib/modules/$(KVER)/extra || true
	depmod -a $(KVER)

endif
