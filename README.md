rtw89
===========
### Usage

```
git clone -b 6.6-lts https://github.com/a5a5aa555oo/rtw89
cd rtw89
make clean modules
sudo make install
sudo make install_fw
```
or
```
git clone -b 6.6-lts https://github.com/a5a5aa555oo/rtw89
cd rtw89
sudo dkms install $PWD
sudo make install_fw
```

`sudo make install_fw` is optional if your system (/lib/firmware/rtw89) has the firmware needed already.

### Note
**ONLY** kernel 5.15 ~ 6.6 are supported. For kernel 6.6+ users, use the rtw89 driver in [main branch](https://github.com/a5a5aa555oo/rtw89) instead.

If your system has [Larry's rtw89 driver](https://github.com/lwfinger/rtw89) installed, you must remove it completely before trying this driver, or the driver probably won't work correctly.
