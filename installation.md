---
layout: post
permalink: /installation/
title: "Installation"
---

Glacier UI is the next interface for NemoMobile.
It is a new UI, created and built by the community, and made with the latest technologies like Qt 5 and Wayland.
For developing look on [Software Development Kit](/sdk/) and our [Application Programming Interface](/qtquickcontrols-nemo/) documentation.

# Try it

## On a PinePhone or PineTab

* Download latest image from [img.nemomobile.net](https://img.nemomobile.net/) (for example [Manjaro-ARM-nemomobile-pinephone-0.9.img.xz](https://img.nemomobile.net/2022.05/Manjaro-ARM-nemomobile-pinephone-0.9.img.xz))
* Copy image on the &micro;SD card
```
xz -dc "Manjaro-ARM-nemomobile-pinephone-0.9.img.xz" | dd if=/dev/stdin of=/dev/mmcblk0 status=progress conv=fsync bs=4M
```



## Virtualbox

* Install standard [Manjaro Linux](https://manjaro.org/).
* Add repository `nemomobile` repository into `/etc/pacman.conf`. It must be first in the list.
```
[nemomobile]
SigLevel = Optional
Server = https://img.nemomobile.net/manjaro/05.2023/stable/x86_64/
```

* Install NemoMobile packages
```
pacman -S --noconfirm $(pacman -Slq nemomobile)
```

* Enable mce daemon by running `systemctl enable mce`
* Disable device display going blank `mcetool -j enabled`
* Add device-specific configuration files, such as [/etc](https://github.com/neochapay/nemo-device-dont_be_evil/blob/master/sparse/etc/eglfs-config.json) and [/var/lib/environment/compositor](https://github.com/neochapay/nemo-device-dont_be_evil/blob/master/sparse/var/lib/environment/compositor/dont_be_evil.conf). Sparse files aren't part of packages and are device specific.
* Ensure the configuration is set correctly for the device. For example, change `/dev/dri/card1` to `/dev/dri/card0`.
* Make sure user is [all necessary groups](https://gitlab.manjaro.org/manjaro-arm/applications/manjaro-arm-tools/-/blob/5619ab3a02a63147596234cc323226a6dab8669f/lib/functions.sh#L456) such as input group.
* Run `lipstick` or logout, choose NemoMobile, and logging in.
