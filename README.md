rtw89
===========
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
If your system has [Larry's rtw89 driver](https://github.com/lwfinger/rtw89) installed, you must run `sudo make cleanup_target_system` to remove that driver, or this driver won't work correctly.

### Note
**ONLY** kernel 5.15 ~ 6.6 are supported. For kernel 6.6+ users, use the rtw89 driver in [main branch](https://github.com/a5a5aa555oo/rtw89) instead.

Tested only with RTL8852BE on Arch Linux (kernel version: 5.15.178-1-lts515 / 6.1.123-1-lts61) and it works.
