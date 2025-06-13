# rtw89

## Supported chips
RTL8851BE, RTL8852AE, RTL8852BE and RTL8852CE

## Prerequisites

git, make, gcc, kernel-headers, dkms and mokutil (dkms and mokutil are optional.)

## Installation Guide

1. Create a clone of this repo in your local machine

   ```
   git clone https://github.com/a5a5aa555oo/rtw89
   ```

2. Change the working directory to rtw89

   ```
   cd rtw89
   ```

3. Search and remove other out-of-tree rtw89 drivers. If your system has [Larry's rtw89 driver](https://github.com/lwfinger/rtw89) installed, you must run this command to remove it, or this driver won't work as expected.

   ```
   sudo make cleanup_target_system
   ```

4. Build and install the driver

   * _via dkms (Recommended especially Secure Boot is enabled on your system)_

     ```
     sudo dkms install $PWD
     ```

   * _via make_

     ```
     make clean modules && sudo make install
     ```

5. Install the firmware necessary for the driver

   ```
   sudo make install_fw
   ```

6. Copy the configuration file `rtw89.conf` to /etc/modprobe.d/

   ```
   sudo cp -v rtw89.conf /etc/modprobe.d/
   ```

7. Enroll the MOK (Machine Owner Key). This is needed **ONLY IF** [Secure Boot](https://wiki.debian.org/SecureBoot) is enabled on your system. Please see [this guide](https://github.com/dell/dkms?tab=readme-ov-file#secure-boot) for details.

   ```
   sudo mokutil --import /var/lib/dkms/mok.pub
   ```

   For Ubuntu-based distro users, run this command instead.

   ```
   sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
   ```

## Uninstallation Guide

For users who installed the driver via `DKMS`,
1. Check the version of the rtw89 driver installed on your system.
   ```
   sudo dkms status rtw89
   ```

2. Remove the rtw89 driver and its source code (Change the driver version accordingly)
   ```
   sudo dkms remove rtw89/6.6.88 --all
   ```

   ```
   sudo rm -rf /usr/src/rtw89-6.6.88
   ```

3. Remove the configuration file
   ```
   sudo rm -f /etc/modprobe.d/rtw89.conf
   ```

For users who installed the driver via `make`, run these commands in the rtw89 source directory
```
sudo make uninstall
```

```
sudo rm -f /etc/modprobe.d/rtw89.conf
```

## Note

**ONLY** kernel 5.15 ~ 6.5 are supported. For kernel 6.6+ users, use [the rtw89 driver maintained by morrownr](https://github.com/morrownr/rtw89) instead.

Tested with RTL8852BE on Arch Linux (kernel version: 5.15.185-1-lts515 / 6.1.140-1-lts61) and it works.

## Q&A

### Q1. Bluetooth is still not working after installing this driver, why?

This `rtw89` driver is the **Wi-Fi** driver for Realtek Wi-Fi 6/6E adapters and has nothing to do with Bluetooth.

### Q2. How to update the driver installed via DKMS?

   1. Check the version of the rtw89 driver installed on your system.
      ```
      sudo dkms status rtw89
      ```   
   2. Remove the rtw89 driver. (Change the driver version accordingly)

      ```
      sudo dkms remove rtw89/6.6.88 --all
      ```

      ```
      sudo rm -rf /usr/src/rtw89-6.6.88
      ```

   3. Run this command in the rtw89 source directory to pull the latest code
      ```
      git pull
      ```

   4. Build, sign and install the rtw89 driver from the latest code.
      ```
      sudo dkms install $PWD
      ```

### Q3. How to update the driver installed via `make`?

   1. Run this command in the rtw89 source directory to pull the latest code
      ```
      git pull
      ```
  
   2. Rebuild and reinstall the driver from the latest code
      ```
      make clean modules && sudo make install
      ```
