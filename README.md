# rtw89

### Supported chips
RTL8851BE, RTL8852AE, RTL8852BE and RTL8852CE

### Prerequisites

git, make, gcc, kernel-headers, dkms and mokutil (dkms and mokutil are optional.)

### Installation Guide

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


6. Enroll the MOK (Machine Owner Key). This is needed **ONLY IF** [Secure Boot](https://wiki.debian.org/SecureBoot) is enabled on your system. Please see [this guide]() on Internet for details.

   ```
   sudo mokutil --import /var/lib/dkms/mok.pub
   ```

   For Ubuntu-based distro users, run this command instead.

   ```
   sudo mokutil --import /var/lib/shim-signed/mok/MOK.der
   ```

### Note

**ONLY** kernel 5.15 ~ 6.5 are supported. For kernel 6.6+ users, use the [rtw89 driver maintained by morrownr](https://github.com/morrownr/rtw89) instead.

Tested with RTL8852BE on Arch Linux (kernel version: 5.15.180-1-lts515 / 6.1.130-1-lts61) and it works.
