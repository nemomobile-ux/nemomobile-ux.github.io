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

* Download latest image from [img.nemomobile.net](https://img.nemomobile.net/) (for example [Manjaro-ARM-nemomobile-pinephone-0.5.img.xz](https://img.nemomobile.net/2021.10/Manjaro-ARM-nemomobile-pinephone-0.5.img.xz))
* Copy image on the &micro;SD card
```
xz -dc "Manjaro-ARM-nemomobile-pinephone-0.5.img.xz" | dd if=/dev/stdin of=/dev/mmcblk0 status=progress conv=fsync bs=4M
```



## Virtualbox

* Install standard [Manjaro Linux](https://manjaro.org/).
* Add repository `nemomobile` repository into `/etc/pacman.conf`. It must be first in the list.
```
[nemomobile]
SigLevel = Optional
Server = https://img.nemomobile.net/manjaro/10.2021/devel/x86_64/
```

* Install NemoMobile packages
```
pacman -S --noconfirm $(pacman -Slq nemomobile)
```

* enable mce daemon `systemctl enable mce`
* disable device display going blank `mcetool -j enabled`
* Run `lipstick` or logout, choose NemoMobile, and logging in.
