#!/bin/bash
set -e

echo "=== Installing RTL8922A Bluetooth DKMS module ==="

# Check prerequisites
for cmd in dkms modprobe; do
    command -v $cmd >/dev/null 2>&1 || { echo "Error: $cmd not found. Install with: sudo -S -p '' apt install dkms"; exit 1; }
done

# Copy firmware
echo "Installing firmware..."
sudo -S -p '' cp firmware/rtl8922au_fw.bin /lib/firmware/rtl_bt/
sudo -S -p '' cp firmware/rtl8922au_config.bin /lib/firmware/rtl_bt/

# Create DKMS source directory
sudo -S -p '' mkdir -p /usr/src/rtbtrtl-1.0
sudo -S -p '' cp btrtl.c btrtl.h btusb.c btintel.h btbcm.h btmtk.h /usr/src/rtbtrtl-1.0/
sudo -S -p '' cp Makefile.bluetooth /usr/src/rtbtrtl-1.0/Makefile

# Create dkms.conf
sudo -S -p '' tee /usr/src/rtbtrtl-1.0/dkms.conf > /dev/null << 'DKMS_CONF'
PACKAGE_NAME="rtbtrtl"
PACKAGE_VERSION="1.0"
BUILD_EXCLUSIVE_KERNEL="^6\\.8\\."
AUTOINSTALL=yes
MAKE="'make' -C /usr/src/rtbtrtl-1.0 KDIR=/lib/modules/${kernelver}/build KVER=${kernelver}"
CLEAN="'make' -C /usr/src/rtbtrtl-1.0 KDIR=/lib/modules/${kernelver}/build clean"
BUILT_MODULE_NAME[0]="btrtl"
BUILT_MODULE_NAME[1]="btusb"
BUILT_MODULE_LOCATION[0]=""
BUILT_MODULE_LOCATION[1]=""
DEST_MODULE_LOCATION[0]="/updates/dkms"
DEST_MODULE_LOCATION[1]="/updates/dkms"
DKMS_CONF

# Build and install
echo "Building DKMS module..."
sudo -S -p '' dkms add rtbtrtl/1.0
sudo -S -p '' dkms build rtbtrtl/1.0
sudo -S -p '' dkms install rtbtrtl/1.0 --force

# Reload
echo "Reloading Bluetooth..."
sudo -S -p '' modprobe -r btusb btrtl 2>/dev/null || true
sudo -S -p '' modprobe btusb
sudo -S -p '' systemctl restart bluetooth

echo "=== Done! Check with: hcitool scan ==="
