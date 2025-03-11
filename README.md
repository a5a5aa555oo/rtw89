rtw89
===========
### Supported chips
RTL8851BE, RTL8852AE, RTL8852BE and RTL8852CE\
(The rtw89 driver in this branch is older and **DOES NOT** support RTL8922AE and other Wi-Fi 7 chips)

### Prerequisites
git, make, gcc, kernel-headers and dkms (dkms is needed only if you want to install this driver via [dkms](https://en.wikipedia.org/wiki/Dynamic_Kernel_Module_Support).)

### Usage

```
git clone -b 6.6-lts https://github.com/a5a5aa555oo/rtw89
cd rtw89
make clean modules
sudo make cleanup_target_system (This step is optional.)
sudo make install
sudo make install_fw
```
or
```
git clone -b 6.6-lts https://github.com/a5a5aa555oo/rtw89
cd rtw89
sudo make cleanup_target_system (This step is optional.)
sudo dkms install $PWD
sudo make install_fw
```
If your system has [Larry's rtw89 driver](https://github.com/lwfinger/rtw89) installed, you must run `sudo make cleanup_target_system` to remove it, or this driver won't work as expected.

### Note
**ONLY** kernel 5.15 ~ 6.6 are supported. For kernel 6.6+ users, use the rtw89 driver in [main branch](https://github.com/a5a5aa555oo/rtw89) instead.

Tested with RTL8852BE on Arch Linux (kernel version: 5.15.178-1-lts515 / 6.1.123-1-lts61) and it works.
