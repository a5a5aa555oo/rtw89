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

modules:
	$(MAKE) -j`nproc` -C $(KDIR) M=$$PWD modules

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean

install:
	@strip -g *.ko
	@install -Dvm 644 -t $(MODDIR) *.ko
	@install -Dvm 644 -t /etc/modprobe.d blacklist-rtw89.conf
	depmod -a $(KVER)

uninstall:
	@rm -rvf $(MODDIR)
	@rmdir -v --ignore-fail-on-non-empty /lib/modules/$(KVER)/extra || true
	@rm -vf /etc/modprobe.d/blacklist-rtw89.conf
	depmod -a $(KVER)

endif
