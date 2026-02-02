---
layout: post
permalink: /installation/
title: "Installation"
---

Glacier UI is the next interface for NemoMobile.
It is a new UI, created and built by the community, and made with the latest technologies like Qt 6 and Wayland.
For developing look on [Software Development Kit](/sdk/) and our [Application Programming Interface](/qtquickcontrols-nemo/) documentation.

# Try it

## On a PinePhone or PineTab

* Download latest image from [OBS](https://download.opensuse.org/repositories/devel:/NemoMobile/images/) 
* Choose whether to install it onto the eMMC or the &micro;SD card.
  *  To install onto the SD card, use the following command:
  ```
  xzcat "openSUSE-Tumbleweed-ARM-NEMO-pinephone.aarch64.raw.xz" | dd if=/dev/stdin of=/dev/mmcblk0 status=progress conv=fsync bs=4M
  ```
  * To install onto the eMMC, use the [JumpDrive](https://github.com/dreemurrs-embedded/Jumpdrive) tool.


## KVM/XEN

* Download latest qcow2 image from [OBS](https://download.opensuse.org/repositories/devel:/NemoMobile/images/) (for example [openSUSE-Tumbleweed-x86_64-NEMO-efi.x86_64-2025.12.13-Build12.1.qcow2](https://download.opensuse.org/repositories/devel:/NemoMobile/images/openSUSE-Tumbleweed-x86_64-NEMO-efi.x86_64-2025.12.13-Build12.1.qcow2))
* Use it as a disk image of virtual machine
* Start virtual machine
* login `root/linux` or `nemo/1234`