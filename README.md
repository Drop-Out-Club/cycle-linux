# Setup

### Dependancies
- npm v14.17.0 (just use nvm to install this version)
- jq
- ssh
- curl
- adb
- [scrcpy](https://github.com/Genymobile/scrcpy)

### Install other dependancies
```bash
npm i
```

### Build
```bash
npm run-script build
```

# Run
```bash
./run.sh <username> <password> <path to SSH public key file (for whatever your default SSH key is)>
```

# Raspberry Pi (armhf)

If your display is all spotty and rainbow-y, possible fix [here](https://www.waveshare.com/wiki/5.5inch_HDMI_AMOLED).

## Raspbian

scrcpy will need to be built from source. That's pretty easy. Just follow the guide on the scrcpy repo.

Apart from that, and adb, all the dependancies can just be installed through apt.

We need the same version of adb on the client and the sever in order for scrcpy to work. That's currently version 1.0.41. This verison is not available by just doing an `apt install` on Raspbian, as far as I can tell.

This was a huge pain in the ass. Not interested in finding all these packages again:
- [adb v1.0.41](http://ftp.br.debian.org/debian/pool/main/a/android-platform-system-core/adb_10.0.0+r36-7_armhf.deb)  
Which requires:
> - [libgcc-s1](http://ftp.br.debian.org/debian/pool/main/g/gcc-10/libgcc-s1_10.2.1-6_armhf.deb)
>> Which requires:
>> - [gcc-10-base](http://ftp.br.debian.org/debian/pool/main/g/gcc-10/gcc-10-base_10.2.1-6_armhf.deb)
> - [android-libadb 1:10.0-r36-7](http://ftp.br.debian.org/debian/pool/main/a/android-platform-system-core/android-libadb_10.0.0+r36-7_armhf.deb)
> - [android-sdk-platform-tools-common 28.0.2](http://ftp.br.debian.org/debian/pool/main/a/android-sdk-meta/android-sdk-platform-tools-common_28.0.2+3_all.deb)
> - [android-libbase 1:10.0.0-r36](http://ftp.br.debian.org/debian/pool/main/a/android-platform-system-core/android-libbase_10.0.0+r36-7_armhf.deb)
> - [libstdc++ >= 9](http://ftp.br.debian.org/debian/pool/main/g/gcc-10/libstdc++6_10.2.1-6_armhf.deb)  
>> Which requires:
>> - [libc6](http://ftp.br.debian.org/debian/pool/main/g/glibc/libc6_2.31-12_armhf.deb)

And that version of libc6 apparently breaks everything, so this currently can't be installed on Raspberry Pi with Raspbian. I'm leaving this here anyway, since I already found all the packages.

## Manjaro

scrcpy can either be built from source manually, or you can use the AUR package. If you want to do it manually, you'll need to install the following packages:
- sdl2
- meson
- wget
- gcc
- git
- pkg-config
- adb

From there, you can just follow the instructions for building scrcpy in the scrcpy repo (skipping the dependancy install, of course).

After that, just install the cycle-linux dependancies, build it, and then run as normal.
